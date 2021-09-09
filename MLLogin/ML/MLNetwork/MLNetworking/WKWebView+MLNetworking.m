// WkWebView+MLNetworking.m
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "WKWebView+MLNetworking.h"

#import <objc/runtime.h>

#if TARGET_OS_IOS

#import "MLHTTPSessionManager.h"
#import "MLURLResponseSerialization.h"
#import "MLURLRequestSerialization.h"

@interface WKWebView (_MLNetworking)
@property (readwrite, nonatomic, strong, setter = ml_setURLSessionTask:) NSURLSessionDataTask *ml_URLSessionTask;
@end

@implementation WKWebView (_MLNetworking)

- (NSURLSessionDataTask *)ml_URLSessionTask {
    return (NSURLSessionDataTask *)objc_getAssociatedObject(self, @selector(ml_URLSessionTask));
}

- (void)ml_setURLSessionTask:(NSURLSessionDataTask *)ml_URLSessionTask {
    objc_setAssociatedObject(self, @selector(ml_URLSessionTask), ml_URLSessionTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark -

@implementation WKWebView (MLNetworking)

- (MLHTTPSessionManager *)sessionManager {
    static MLHTTPSessionManager *_ml_defaultHTTPSessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ml_defaultHTTPSessionManager = [[MLHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _ml_defaultHTTPSessionManager.requestSerializer = [MLHTTPRequestSerializer serializer];
        _ml_defaultHTTPSessionManager.responseSerializer = [MLHTTPResponseSerializer serializer];
    });
    
    return objc_getAssociatedObject(self, @selector(sessionManager)) ?: _ml_defaultHTTPSessionManager;
}

- (void)setSessionManager:(MLHTTPSessionManager *)sessionManager {
    objc_setAssociatedObject(self, @selector(sessionManager), sessionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MLHTTPResponseSerializer <MLURLResponseSerialization> *)responseSerializer {
    static MLHTTPResponseSerializer <MLURLResponseSerialization> *_ml_defaultResponseSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ml_defaultResponseSerializer = [MLHTTPResponseSerializer serializer];
    });
    
    return objc_getAssociatedObject(self, @selector(responseSerializer)) ?: _ml_defaultResponseSerializer;
}

- (void)setResponseSerializer:(MLHTTPResponseSerializer<MLURLResponseSerialization> *)responseSerializer {
    objc_setAssociatedObject(self, @selector(responseSerializer), responseSerializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)loadRequest:(NSURLRequest *)request
         navigation:(WKNavigation * _Nonnull)navigation
           progress:(NSProgress * _Nullable __autoreleasing * _Nullable)progress
            success:(nullable NSString * (^)(NSHTTPURLResponse *response, NSString *HTML))success
            failure:(nullable void (^)(NSError *error))failure {
    [self loadRequest:request navigation:navigation MIMEType:nil textEncodingName:nil progress:progress success:^NSData * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSData * _Nonnull data) {
        NSStringEncoding stringEncoding = NSUTF8StringEncoding;
        if (response.textEncodingName) {
            CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
            if (encoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
            }
        }
        
        NSString *string = [[NSString alloc] initWithData:data encoding:stringEncoding];
        if (success) {
            string = success(response, string);
        }
        
        return [string dataUsingEncoding:stringEncoding];
    } failure:failure];
}

- (void)loadRequest:(NSURLRequest *)request
         navigation:(WKNavigation * _Nonnull)navigation
           MIMEType:(nullable NSString *)MIMEType
   textEncodingName:(nullable NSString *)textEncodingName
           progress:(NSProgress * _Nullable __autoreleasing * _Nullable)progress
            success:(nullable NSData * (^)(NSHTTPURLResponse *response, NSData *data))success
            failure:(nullable void (^)(NSError *error))failure {
    NSParameterAssert(request);
    
    if (self.ml_URLSessionTask.state == NSURLSessionTaskStateRunning || self.ml_URLSessionTask.state == NSURLSessionTaskStateSuspended) {
        [self.ml_URLSessionTask cancel];
    }
    self.ml_URLSessionTask = nil;
    
    __weak __typeof(self)weakSelf = self;
    __block NSURLSessionDataTask *dataTask;
    __strong __typeof(weakSelf) strongSelf = weakSelf;
    __strong __typeof(weakSelf.navigationDelegate) strongSelfDelegate = strongSelf.navigationDelegate;
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        } else {
            if (success) {
                success((NSHTTPURLResponse *)response, responseObject);
            }
            [strongSelf loadData:responseObject MIMEType:MIMEType characterEncodingName:textEncodingName baseURL:[dataTask.currentRequest URL]];
            
            if ([strongSelfDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
                [strongSelfDelegate webView:strongSelf didFinishNavigation:navigation];
            }
        }
    }];
    self.ml_URLSessionTask = dataTask;
    if (progress != nil) {
        *progress = [self.sessionManager downloadProgressForTask:dataTask];
    }
    [self.ml_URLSessionTask resume];
    
    if ([strongSelfDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [strongSelfDelegate webView:self didStartProvisionalNavigation:navigation];
    }
}

@end

#endif

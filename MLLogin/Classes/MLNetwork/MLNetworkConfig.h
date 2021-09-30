//
//  MLNetworkConfig.h 
//
//  Copyright (c) 2012-2016 MLNetwork https://github.com/yuantiku
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MLBaseRequest;
@class MLSecurityPolicy;

typedef void (^MLURLSessionTaskDidFinishCollectingMetricsBlock)(NSURLSession *session, NSURLSessionTask *task, NSURLSessionTaskMetrics * metrics) API_AVAILABLE(ios(10), macosx(10.12), watchos(3), tvos(10));

///  MLUrlFilterProtocol can be used to append common parameters to requests before sending them.
@protocol MLUrlFilterProtocol <NSObject>
///  Preprocess request URL before actually sending them.
///
///  @param originUrl request's origin URL, which is returned by `requestUrl`
///  @param request   request itself
///
///  @return A new url which will be used as a new `requestUrl`
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(MLBaseRequest *)request;
@end

///  MLCacheDirPathFilterProtocol can be used to append common path components when caching response results
@protocol MLCacheDirPathFilterProtocol <NSObject>
///  Preprocess cache path before actually saving them.
///
///  @param originPath original base cache path, which is generated in `MLRequest` class.
///  @param request    request itself
///
///  @return A new path which will be used as base path when caching.
- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(MLBaseRequest *)request;
@end

///  MLNetworkConfig stored global network-related configurations, which will be used in `MLNetworkAgent`
///  to form and filter requests, as well as caching response.
@interface MLNetworkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Return a shared config object.
+ (MLNetworkConfig *)sharedConfig;

///  Request base URL, such as "http://www.yuantiku.com". Default is empty string.
@property (nonatomic, strong) NSString *baseUrl;
///  Request CDN URL. Default is empty string.
@property (nonatomic, strong) NSString *cdnUrl;
///  URL filters. See also `MLUrlFilterProtocol`.
@property (nonatomic, strong, readonly) NSArray<id<MLUrlFilterProtocol>> *urlFilters;
///  Cache path filters. See also `MLCacheDirPathFilterProtocol`.
@property (nonatomic, strong, readonly) NSArray<id<MLCacheDirPathFilterProtocol>> *cacheDirPathFilters;
///  Security policy will be used by MLNetworking. See also `MLSecurityPolicy`.
@property (nonatomic, strong) MLSecurityPolicy *securityPolicy;
///  Whether to log debug info. Default is NO;
@property (nonatomic) BOOL debugLogEnabled;
///  SessionConfiguration will be used to initialize MLHTTPSessionManager. Default is nil.
@property (nonatomic, strong, nullable) NSURLSessionConfiguration* sessionConfiguration;
///  NSURLSessionTaskMetrics
@property (nonatomic, strong) MLURLSessionTaskDidFinishCollectingMetricsBlock collectingMetricsBlock API_AVAILABLE(ios(10), macosx(10.12), watchos(3), tvos(10));

///  Add a new URL filter.
- (void)addUrlFilter:(id<MLUrlFilterProtocol>)filter;
///  Remove all URL filters.
- (void)clearUrlFilter;
///  Add a new cache path filter
- (void)addCacheDirPathFilter:(id<MLCacheDirPathFilterProtocol>)filter;
///  Clear all cache path filters.
- (void)clearCacheDirPathFilter;

@end

NS_ASSUME_NONNULL_END

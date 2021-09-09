// UIActivityIndicatorView+MLNetworking.m
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

#import "UIActivityIndicatorView+MLNetworking.h"
#import <objc/runtime.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import "MLURLSessionManager.h"

@interface MLActivityIndicatorViewNotificationObserver : NSObject
@property (readonly, nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
- (instancetype)initWithActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;

- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task;

@end

@implementation UIActivityIndicatorView (MLNetworking)

- (MLActivityIndicatorViewNotificationObserver *)ml_notificationObserver {
    MLActivityIndicatorViewNotificationObserver *notificationObserver = objc_getAssociatedObject(self, @selector(ml_notificationObserver));
    if (notificationObserver == nil) {
        notificationObserver = [[MLActivityIndicatorViewNotificationObserver alloc] initWithActivityIndicatorView:self];
        objc_setAssociatedObject(self, @selector(ml_notificationObserver), notificationObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return notificationObserver;
}

- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task {
    [[self ml_notificationObserver] setAnimatingWithStateOfTask:task];
}

@end

@implementation MLActivityIndicatorViewNotificationObserver

- (instancetype)initWithActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView
{
    self = [super init];
    if (self) {
        _activityIndicatorView = activityIndicatorView;
    }
    return self;
}

- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:MLNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:MLNetworkingTaskDidSuspendNotification object:nil];
    [notificationCenter removeObserver:self name:MLNetworkingTaskDidCompleteNotification object:nil];
    
    if (task) {
        if (task.state != NSURLSessionTaskStateCompleted) {
            UIActivityIndicatorView *activityIndicatorView = self.activityIndicatorView;
            if (task.state == NSURLSessionTaskStateRunning) {
                [activityIndicatorView startAnimating];
            } else {
                [activityIndicatorView stopAnimating];
            }

            [notificationCenter addObserver:self selector:@selector(ml_startAnimating) name:MLNetworkingTaskDidResumeNotification object:task];
            [notificationCenter addObserver:self selector:@selector(ml_stopAnimating) name:MLNetworkingTaskDidCompleteNotification object:task];
            [notificationCenter addObserver:self selector:@selector(ml_stopAnimating) name:MLNetworkingTaskDidSuspendNotification object:task];
        }
    }
}

#pragma mark -

- (void)ml_startAnimating {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView startAnimating];
    });
}

- (void)ml_stopAnimating {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
    });
}

#pragma mark -

- (void)dealloc {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:MLNetworkingTaskDidCompleteNotification object:nil];
    [notificationCenter removeObserver:self name:MLNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:MLNetworkingTaskDidSuspendNotification object:nil];
}

@end

#endif

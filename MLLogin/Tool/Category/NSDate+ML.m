//
//  NSDate+MLCommon.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "NSDate+ML.h"

@implementation NSDate (ML)

// 获取 当前 时间的 时间戳
+ (NSString *)ml_currentTimeStampString {
    NSTimeInterval currentTimeStamp = [self ml_currentTimeStamp];
    NSString *timeIntervalStr = [NSString stringWithFormat:@"%lld",(long long)currentTimeStamp];
    if (timeIntervalStr.length < 13) {
        timeIntervalStr = [NSString stringWithFormat:@"%lld",(long long)currentTimeStamp];
    }
    return timeIntervalStr;
}

// 获取 当前 时间的 时间戳
+ (NSTimeInterval)ml_currentTimeStamp {
    return [[NSDate date] timeIntervalSince1970];
}

// 获取 当前 时间的 时间戳M(毫秒 级别)
+ (NSTimeInterval)ml_currentMillisecondTimeStamp {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

// 获取 当前 时间的 时间戳
+ (NSString *)ml_currentMillisecondTimeStampString {
    NSTimeInterval currentTimeStamp = [self ml_currentMillisecondTimeStamp];
    NSString *timeIntervalStr = [NSString stringWithFormat:@"%lld",(long long)currentTimeStamp];
    if (timeIntervalStr.length < 13) {
        timeIntervalStr = [NSString stringWithFormat:@"%lld",(long long)currentTimeStamp];
    }
    return timeIntervalStr;
}

@end

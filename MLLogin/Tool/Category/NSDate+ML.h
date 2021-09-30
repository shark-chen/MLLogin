//
//  NSDate+MLCommon.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ML)


/**
 获取 当前 时间的 时间戳

 @return 时间戳
 */
+ (NSString *)ml_currentTimeStampString;

/**
 获取 当前 时间的 时间戳

 @return  时间戳
 */
+ (NSTimeInterval)ml_currentTimeStamp;


/**
 获取 当前 时间的 时间戳M(毫秒 级别)

 @return 毫秒
 */
+ (NSTimeInterval)ml_currentMillisecondTimeStamp;

// 获取 当前 时间的 时间戳
+ (NSString *)ml_currentMillisecondTimeStampString;

@end

NS_ASSUME_NONNULL_END

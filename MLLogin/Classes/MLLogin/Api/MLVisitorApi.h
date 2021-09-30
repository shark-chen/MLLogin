//
//  MLVisitorApi.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLVisitorApi : MLRequest

/// init
/// @param parameter 可选参数 @"mobile": 用户手机号码; "mobile_model":用户手机型号
- (id)initWithParameter:(NSDictionary * __nullable)parameter;

@end

NS_ASSUME_NONNULL_END

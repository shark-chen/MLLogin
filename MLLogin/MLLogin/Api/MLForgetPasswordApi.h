//
//  MLForgotPasswordApi.h
//  GameProject
//
//  Created by shark on 2021/9/8.
//

#import "MLRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLForgetPasswordApi : MLRequest

/// 忘记密码
/// @param email 邮箱
/// @param parameter 其他参数
- (id)initWithEmail:(NSString *)email
          parameter:(NSDictionary * __nullable)parameter;

@end

NS_ASSUME_NONNULL_END

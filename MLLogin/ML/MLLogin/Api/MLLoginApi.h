//
//  MLLoginApi.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLLoginApi : MLRequest

/// init
/// @param account 账户
/// @param password 密码
/// @param parameter 可选参数 “platform” 如通过第三方社交登录则需要填写此栏目：
- (id)initWithAccount:(NSString *)account
             password:(NSString * __nullable)password
            parameter:(NSDictionary * __nullable)parameter;

@end

NS_ASSUME_NONNULL_END

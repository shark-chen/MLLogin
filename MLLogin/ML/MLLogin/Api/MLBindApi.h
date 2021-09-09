//
//  MLBindApi.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLBindApi : MLRequest

/// init
/// @param account 账户
/// @param password 密码
/// @param gameId 需要绑定的游戏账号
/// @param parameter 可选参数  @"mobile": 用户手机号码; "mobile_model":用户手机型号
- (id)initWithAccount:(NSString *)account
             password:(NSString *)password
               gameId:(NSString *)gameId
            parameter:(NSDictionary * __nullable)parameter;

@end

NS_ASSUME_NONNULL_END

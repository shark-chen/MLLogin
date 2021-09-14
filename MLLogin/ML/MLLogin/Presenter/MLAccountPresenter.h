//
//  MLLoginRegisterPresenter.h
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import <Foundation/Foundation.h>
#import "MLLoginDalegate.h"
#import "MLFacebookApi.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *MLStatusKey = @"status";
static NSString *MLSuccessValue = @"success";
static NSString *MLErrorValue = @"error";

@interface MLAccountPresenter : NSObject

/// dalagate get call back data
@property (weak, nonatomic) id<MLLoginDalegate> delegate;

/// auto login
- (void)autoLogin;

#pragma mark - request

/// 游客
- (void)visitorRequest;

/// 登陆
/// @param account  账号
/// @param password 密码
/// @param parameter 可选参数 “platform” 如通过第三方社交登录则需要填写此栏目：
- (void)loginRequestWithAccount:(NSString *)account
                       password:(NSString * __nullable)password
                      parameter:(NSDictionary * __nullable)parameter;

/// 注册请求
/// @param account 账户
/// @param password 密码
/// @param parameter 可选参数  “platform" ; "email": 用户邮箱; @"mobile": 用户手机号码; "mobile_model":用户手机型号
- (void)registerRequestWithAccount:(NSString *)account
                          password:(NSString *)password
                         parameter:(NSDictionary * __nullable)parameter;

/// 绑定
/// @param account 账户
/// @param password 密码
/// @param gameId 需要绑定的游戏账号
/// @param parameter 可选参数  @"mobile": 用户手机号码; "mobile_model":用户手机型号
- (void)bindRequestWithAccount:(NSString *)account
                      password:(NSString *)password
                        gameId:(NSString *)gameId
                      parameter:(NSDictionary * __nullable)parameter;

/// 忘记密码
/// @param email 邮箱
/// @param parameter 其他参数
- (void)forgetPasswordRequestWithEmail:(NSString *)email
                             parameter:(NSDictionary * __nullable)parameter;


/// facebook 三方登陆
/// @param fromVc 控制器
- (void)facebookLogin:(UIViewController * __nullable)fromVc;


/// 苹果 三方登陆
/// @param account 苹果userid
- (void)appleLoginWithAccount:(NSString *)account;

/// 谷歌 三方登陆
/// @param account 苹果userid
- (void)gooleLoginWithAccount:(NSString *)account;

@end

NS_ASSUME_NONNULL_END

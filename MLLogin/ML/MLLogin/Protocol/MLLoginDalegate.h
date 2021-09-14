//
//  MLLoginProtocol.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    MLLogin = 1,        /// 登陆
    MLAutoLogin,        /// 自动登陆
    MLGuestLogin,       /// 游客
    MLRegister,         /// 注册
    MLBind,             /// 绑定
    MLForgetPassword,   /// 忘记密码
    MLFacebook,         /// facebook登陆
    MLGoole,            /// 谷歌登陆
    MLApple,            /// 苹果登陆
    MLNnknown,          /// 未知
} MLApiUrlType;

NS_ASSUME_NONNULL_BEGIN

@protocol MLLoginDalegate <NSObject>

/// result call back
/// @param apiUrlType 1
/// @param status 1
/// @param result dic data
- (void)callBackApiUrl:(MLApiUrlType)apiUrlType status:(NSString *)status result:(id)result error:(nullable NSError * )error;

@end

NS_ASSUME_NONNULL_END

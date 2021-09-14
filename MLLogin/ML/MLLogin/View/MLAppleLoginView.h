//
//  HandleSignInWithAppleModel.h
//  SignInWithApple
//
//  Created by lishengfeng on 2019/10/18.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AuthenticationServices/AuthenticationServices.h>
NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(13.0))
@interface MLAppleLoginView : NSObject
+ (MLAppleLoginView *)defaultSignInWithAppleModel;
+ (void)attempDealloc;
+ (UIButton *)createAppleButtonWithsuccess:(void(^)(ASAuthorization *authorization,NSString *user))success
                                   failure:(void (^)(NSError *err))failure;
@end

NS_ASSUME_NONNULL_END

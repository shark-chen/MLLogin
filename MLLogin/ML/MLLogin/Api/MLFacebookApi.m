//
//  MLFacebookApi.m
//  GameProject
//
//  Created by shark on 2021/9/8.
//

#import "MLFacebookApi.h"

@implementation MLFacebookApi

- (void)facebookLogin:(UIViewController * __nullable)fromVC
             complete:(void(^)(NSDictionary *result, NSError * _Nullable error))complete {
    
    if ([FBSDKAccessToken currentAccessToken] != nil) {
        !complete?:complete(@{@"userID": [FBSDKAccessToken currentAccessToken].userID?:@"", @"token": [FBSDKAccessToken currentAccessToken].tokenString?:@""}, nil);
        return;
    }
    
    // 打开 FBSDKProfile 自动追踪 FBSDKAccessToken
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    // 清空FBSDKAccessToken
    [FBSDKAccessToken setCurrentAccessToken:nil];
    // 登录
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
//    loginManager.loginBehavior = .native // 优先客户端方式
    [loginManager logInWithPermissions:@[@"public_profile"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",  error);
            !complete?:complete(nil, error);
        } else {
            !complete?:complete(@{@"userID": result.token.userID?:@"", @"token": result.token.tokenString?:@""}, error);
            NSLog(@"facebook userID: %@   token: %@", result.token.userID, result.token.tokenString);
        }
    }];
}

@end

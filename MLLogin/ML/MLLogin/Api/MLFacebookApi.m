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
    
//    if ([FBSDKAccessToken currentAccessToken] != nil) {
//        !complete?:complete(@{@"userID": [FBSDKAccessToken currentAccessToken].userID?:@"", @"token": [FBSDKAccessToken currentAccessToken].tokenString?:@""}, nil);
//        return;
//    }
    
    // 打开 FBSDKProfile 自动追踪 FBSDKAccessToken
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    // 清空FBSDKAccessToken
    [FBSDKAccessToken setCurrentAccessToken:nil];
    // 登录
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
//    loginManager.loginBehavior = .native // 优先客户端方式
    [loginManager logInWithPermissions:@[@"public_profile",@"email"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",  error);
            !complete?:complete(nil, error);
        } else {
            [self getUserInfoWithResult:result complete: complete];
            NSLog(@"facebook userID: %@   token: %@", result.token.userID, result.token.tokenString);
        }
    }];
}

/// 获取用户信息 picture用户头像
- (void)getUserInfoWithResult:(FBSDKLoginManagerLoginResult *)result complete:(void(^)(NSDictionary *result, NSError * _Nullable error))complete {
    NSDictionary*params= @{@"fields":@"id,name,email,age_range,first_name,last_name,link,gender,locale,picture,timezone,updated_time,verified"};
      
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:result.token.userID
                                  parameters:params
                                  HTTPMethod:@"GET"];
    [request startWithCompletion:^(id<FBSDKGraphRequestConnecting>  _Nullable connection, id  _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",  error);
            !complete?:complete(nil, error);
        } else if (result){
            !complete?:complete(@{@"userID": result[@"id"]?:@"", @"email": result[@"email"]?:@""}, error);
            NSLog(@"facebook userID: %@   email: %@", result[@"id"]?:@"", result[@"email"]?:@"");
        }
    }];
}

@end

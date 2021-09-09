//
//  MLLoginRegisterPresenter.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLAccountPresenter.h"
#import "Header.h"

@implementation MLAccountPresenter

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        MLNetworkConfig *config = [MLNetworkConfig sharedConfig];
        config.baseUrl = MLBaseURL;
        
        MLNetworkAgent *agent = [MLNetworkAgent sharedAgent];
        [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html", nil]
        forKeyPath:@"jsonResponseSerializer.acceptableContentTypes"];
    }
    return self;
}

- (void)autoLogin {
    if ([MLUserManger share].account.length && [MLUserManger share].password.length) {
        [self loginRequestWithAccount:[MLUserManger share].account password:[MLUserManger share].password parameter:nil];
    } else {
        if ([self.delegate respondsToSelector:@selector(callBackApiUrl:status:result:error:)]) {
            [self.delegate callBackApiUrl:MLAutoLogin status:@"error" result:@{@"status":@"error"} error:nil];
        }
    }
}

#pragma mark - request

/// 游客
- (void)visitorRequest {
    [MLProgressHUD showLoadingText:@"logining"];
    MLVisitorApi *visitorApi = [[MLVisitorApi alloc] init];
    [visitorApi startWithCompletionBlockWithSuccess:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        [self handleDelegateApiUrl:MLGuestLogin result:request.responseJSONObject?:request.responseObject error:request.error];
    } failure:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        [self handleDelegateApiUrl:MLGuestLogin result:request.responseJSONObject?:request.responseObject error:request.error];
    }];
}

- (void)loginRequestWithAccount:(NSString *)account
                       password:(NSString * __nullable)password
                      parameter:(NSDictionary * __nullable)parameter {
    [MLProgressHUD showLoadingText:@"logining"];
    MLLoginApi *loginApi = [[MLLoginApi alloc] initWithAccount:account password:password parameter:parameter];
    [loginApi startWithCompletionBlockWithSuccess:^(MLBaseRequest *request) {
        // 你可以直接在这里使用 self
        [MLProgressHUD hide];
        /// 登陆注册完保存账户数据
        [self saveAccuunt:account password:password responseResullt:request.responseJSONObject];
        [self handleDelegateApiUrl:MLLogin result:request.responseJSONObject?:request.responseObject error:request.error];
    } failure:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        [self handleDelegateApiUrl:MLLogin result:request.responseJSONObject error:request.error];
    }];
}

- (void)registerRequestWithAccount:(NSString *)account
                          password:(NSString *)password
                         parameter:(NSDictionary * __nullable)parameter {
    [MLProgressHUD showLoadingText:@"registering"];
    MLRegisterApi *api = [[MLRegisterApi alloc] initWithAccount:account password:password parameter: parameter];
    [api startWithCompletionBlockWithSuccess:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        /// 登陆注册完保存账户数据
        [self saveAccuunt:account password:password responseResullt:request.responseJSONObject];
        [self handleDelegateApiUrl:MLRegister result:request.responseJSONObject?:request.responseObject error:request.error];
    } failure:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        [self handleDelegateApiUrl:MLRegister result:request.responseJSONObject?:request.responseObject error:request.error];
    }];
}

- (void)bindRequestWithAccount:(NSString *)account
                   password:(NSString *)password
                     gameId:(NSString *)gameId
                  parameter:(NSDictionary * __nullable)parameter {
    [MLProgressHUD showLoadingText:@"binding"];
    MLBindApi *api = [[MLBindApi alloc] initWithAccount:account password:password gameId:gameId parameter:parameter];
    [api startWithCompletionBlockWithSuccess:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        /// 登陆注册完保存账户数据
        [self saveAccuunt:account password:password responseResullt:request.responseJSONObject];
        [self handleDelegateApiUrl:MLRegister result:request.responseJSONObject?:request.responseObject error:request.error];
    } failure:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        [self handleDelegateApiUrl:MLBind result:request.responseJSONObject?:request.responseObject error:request.error];
    }];
}

- (void)forgetPasswordRequestWithEmail:(NSString *)email
                             parameter:(NSDictionary * __nullable)parameter {
    [MLProgressHUD showLoadingText:@"sending"];
    MLForgetPasswordApi *api = [[MLForgetPasswordApi alloc] initWithEmail:email parameter:parameter];
    [api startWithCompletionBlockWithSuccess:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        /// 登陆注册完保存账户数据
        [self handleDelegateApiUrl:MLForgetPassword result:request.responseJSONObject?:request.responseObject error:request.error];
    } failure:^(MLBaseRequest *request) {
        [MLProgressHUD hide];
        [self handleDelegateApiUrl:MLForgetPassword result:request.responseJSONObject?:request.responseObject error:request.error];
    }];
}

- (void)facebookLogin:(UIViewController * __nullable)fromVc {
    MLFacebookApi *facebookApi = [[MLFacebookApi alloc] init];
    __weak __typeof__(self) weakSelf = self;
    [facebookApi facebookLogin: fromVc complete:^(NSDictionary * _Nonnull result, NSError * _Nullable error) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        if (result) {
            NSString *userID = [NSString stringWithFormat:@"%@", result[@"userID"]];
            [strongSelf loginRequestWithAccount:userID password:nil parameter:@{@"platform":@"Facebook"}];
            [strongSelf handleDelegateApiUrl:MLFacebook result:result error:error];
        } else {
            [strongSelf handleDelegateApiUrl:MLFacebook result:result error:error];
        }
    }];
}

/// 处理代理回调
- (void)handleDelegateApiUrl:(MLApiUrlType)apiUrlType result:(id)result error:(NSError *)error {
    /// 处理请求结果
    [self handleRequestResullt: result apiUrl:apiUrlType];
    if ([self.delegate respondsToSelector:@selector(callBackApiUrl:status:result:error:)]) {
        [self.delegate callBackApiUrl:apiUrlType status:result[@"status"] result:result error:error];
    }
}

/// 处理请求结果
- (void)handleRequestResullt:(id)resullt apiUrl:(MLApiUrlType)apiUrlType {
    switch (apiUrlType) {
        case MLLogin: {
            
        }
            break;
        case MLGuestLogin: {
            if ([resullt isKindOfClass:[NSDictionary class]]) {
                NSDictionary *result = (NSDictionary *)resullt;
                if ([result[@"status"] isEqualToString:@"success"]) {
                    [MLUserManger share].gusetGameId = result[@"game_id"] ?:@"";
                }
            }
        }
            break;
        case MLBind: {
            
        }
            break;
        default:
            break;
    }
}

/// 登陆注册完保存账户数据
-  (void)saveAccuunt:(NSString *)account
            password:(NSString * __nullable)password
     responseResullt:(id)responseResullt {
    if ([responseResullt isKindOfClass:[NSDictionary class]]) {
        NSDictionary *result = (NSDictionary *)responseResullt;
        if ([result[@"status"] isEqualToString:@"success"]) {
            [MLUserManger share].account = account;
            [MLUserManger share].password = password;
            [MLUserManger share].gameId = result[@"game_id"] ?:@"";
        }
    }
}

@end

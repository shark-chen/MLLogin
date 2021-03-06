//
//  MLoginViewController.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLoginSDK.h"
#import "HLLTransitioning.h"
#import "MLPresentation.h"
#import "MLUserManger.h"
#import "MLAccountPresenter.h"
#import "MLLoginView.h"
#import "MLRegisterVew.h"
#import "MLForgetPasswordView.h"
#import "MLBindView.h"
#import "MLBindNotifyView.h"
#import "Header.h"
#import "GoogleSignIn.h"
#import <SafariServices/SafariServices.h>

@implementation MLLoginConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needAutoLogin = NO;
    }
    return self;
}

@end

@interface MLLoginSDKInfo ()

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *gameId;
@property (strong, nonatomic) NSString *gusetGameId;
@property (strong, nonatomic) NSString *appleUserId;

@end

@implementation MLLoginSDKInfo

+ (instancetype)share {
    static MLLoginSDKInfo *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MLLoginSDKInfo alloc] init];
    });
    return instance;
}

- (NSString *)account {
    return [MLUserManger share].account;
}

- (NSString *)password {
    return [MLUserManger share].password;
}

- (NSString *)gameId {
    return [MLUserManger share].gameId;
}

- (NSString *)gusetGameId {
    return [MLUserManger share].gusetGameId;
}

- (NSString *)appleUserId {
    return [MLUserManger share].appleUserId;
}

/// 清楚本地存储的账号数据
- (void)clearAccout {
    [[MLUserManger share] clearAccout];
}

@end

@interface MLoginSDK ()<UIViewControllerTransitioningDelegate, MLLoginDalegate>
{
    MLLoginView *_loginView;
    MLRegisterVew *_registerVew;
    MLForgetPasswordView *_forgetPasswordView;
    MLBindView *_bindView;
    MLBindNotifyView *_bindNotifyView;
    NSInteger _showType;
}

@property (strong, nonatomic) MLAccountPresenter *accountPresenter;  /// p 层
@property (strong, nonatomic) MLLoginConfig *loginConfig;

@end

@implementation MLoginSDK

- (void)dealloc
{
    NSLog(@"MLoginSDK -dealloc");
}

- (instancetype)initWithGame:(NSString *)game
                  encryptKey:(NSString *)encryptKey
                      config:(MLLoginConfig * __nullable)config {
    self = [super init];
    if (self) {
        [MLUserManger share].encryptKey = encryptKey;
        [MLUserManger share].game = game;
        self.loginConfig = config;
        [self creatVCDelegate];
        _showType = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.loginConfig.needAutoLogin) {
        [self.accountPresenter autoLogin];
    }
    [self layoutUI];
    [self clickMenthod];
    [self bindClickMenthod];
    [self adddNotification];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)layoutUI {
    CGFloat margint = (isIpad() || MLScreenWidthL > MLScreenHeightL) ? (MLScreenWidthL * 0.5 - 177):30;
    CGFloat width = (isIpad() || MLScreenWidthL > MLScreenHeightL) ? 354:(MLScreenWidthL - margint * 2);
    _loginView = [[MLLoginView alloc] initWithFrame:CGRectMake(margint, MLScreenHeightL * 0.5 - 175, width, 350)];
    _loginView.accountTF.text = [MLUserManger share].account;
    _loginView.passwordTF.text = [MLUserManger share].password;
    _loginView.hidden = NO;
    [self.view addSubview:_loginView];
    
    _registerVew = [[MLRegisterVew alloc] initWithFrame:CGRectMake(margint, _loginView.y, width, 350)];
    _registerVew.hidden = YES;
    [self.view addSubview:_registerVew];

    _forgetPasswordView = [[MLForgetPasswordView alloc] initWithFrame:CGRectMake(margint, _loginView.y, width , 350)];
    _forgetPasswordView.hidden = YES;
    [self.view addSubview:_forgetPasswordView];
    
    _bindNotifyView = [[MLBindNotifyView alloc] initWithFrame:CGRectMake(margint, _loginView.y, width, 350)];
    _bindNotifyView.hidden = YES;
    [self.view addSubview:_bindNotifyView];
    
    _bindView = [[MLBindView alloc] initWithFrame:CGRectMake(margint, _loginView.y, width, 350)];
    _bindView.hidden = YES;
    [self.view addSubview:_bindView];
    
    if (_showType == 1) { // 只展示注册
        _loginView.hidden = YES;
        _registerVew.hidden = NO;
    } else if(_showType == 2) { // 只展示绑定
        _loginView.hidden = YES;
        _bindView.hidden = NO;
    }
}

- (void)adddNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    CGFloat margint = (isIpad() || MLScreenWidthL > MLScreenHeightL) ? (MLScreenWidthL * 0.5 - 177):30;
    CGFloat width = (isIpad() || MLScreenWidthL > MLScreenHeightL) ? 354:(MLScreenWidthL - margint * 2);
    _loginView.frame = CGRectMake(margint, MLScreenHeightL * 0.5 - 175, width, 350);
    _registerVew.frame = CGRectMake(margint, _loginView.y, width, 350);
    _forgetPasswordView.frame = CGRectMake(margint, _loginView.y, width , 350);
    _bindNotifyView.frame = CGRectMake(margint, _loginView.y, width , 350);
    _bindView.frame = CGRectMake(margint, _loginView.y, width , 350);
}

- (void)clearAccout {
    [[MLUserManger share] clearAccout];
}

- (void)clickMenthod {
    __weak __typeof__(self) weakSelf = self;
    _loginView.clickBlock = ^(NSInteger clickType) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        switch (clickType) {
            case 1: /// 登陆
            {
                NSString *account = strongSelf->_loginView.accountTF.text,
                *password = strongSelf->_loginView.passwordTF.text;
                [strongSelf.accountPresenter loginRequestWithAccount:account password:password parameter:nil];
            }
                break;
            case 2:   /// 记住密码
                break;
            case 3:   /// 忘记密码
                strongSelf->_forgetPasswordView.hidden = NO;
                break;
            case 4:  /// 注册
                strongSelf->_registerVew.hidden = NO;
                break;
            case 5:   /// 游客登陆
                [strongSelf.accountPresenter requestVisitorID];
                strongSelf->_bindNotifyView.hidden = NO;
                break;
            case 6:   /// feackbook
                [strongSelf.accountPresenter facebookLogin:nil];
                break;
            case 7:   /// goole
                [strongSelf gooleLogin];
                break;
            default:
                strongSelf->_registerVew.hidden = NO;
                break;
        }
    };
    
    if (@available(iOS 13.0, *)) {
        _loginView.appleBlock = ^(ASAuthorization *authorization, NSString *user, NSString *email, NSError *err) {
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            if (user.length) {
                [strongSelf.accountPresenter appleLoginWithAccount:user parameter:@{@"platform":MLAppleLogin, @"email": email?:@""}];
            } else {
                [strongSelf callBackApiUrl:MLApple status:MLErrorValue result:@{@"status":MLErrorValue} error:err];
            }
        };
    }
    
    _registerVew.clickBlock = ^(NSInteger clickType) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        switch (clickType) {
            case 1:  /// 返回
                if(strongSelf->_showType == 1) { // 只展示绑定
                    [strongSelf dismissViewControllerAnimated:YES completion:nil];
                } else {
                    strongSelf->_registerVew.hidden = YES;
                }
                break;
            case 2:  /// 注册
                {
                NSString *account = strongSelf->_registerVew.accountTF.text,
                        *password = strongSelf->_registerVew.passwordTF.text,
                        *rePassword = strongSelf->_registerVew.rePasswordTF.text,
                        *email = strongSelf->_registerVew.emailTF.text;
                    if (![password isEqualToString:rePassword]){
                        [MLProgressHUD showText: @"Password does not match."];
                    } else {
                        [strongSelf.accountPresenter registerRequestWithAccount:account password:password parameter:@{@"email":email?:@""}];
                    }
            }
                break;
            case 3:  /// 注册协议
            {
                [strongSelf gotoServicesProtol:1];
            }
                break;
            case 4:  /// 隐私协议
            {
                [strongSelf gotoServicesProtol:2];
            }
                break;
            default:
                strongSelf->_registerVew.hidden = NO;
                break;
        }
    };
    
    _forgetPasswordView.clickBlock = ^(NSInteger clickType) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        switch (clickType) {
            case 1:  /// 返回
                strongSelf->_forgetPasswordView.hidden = YES;
                break;
            case 2:  /// 发送
            {
                NSString *email = strongSelf->_forgetPasswordView.emailTF.text;
                [strongSelf.accountPresenter forgetPasswordRequestWithEmail:email parameter:nil];
            }
                break;
            default:
                strongSelf->_registerVew.hidden = NO;
                break;
        }
    };
}

- (void)bindClickMenthod {
    __weak __typeof__(self) weakSelf = self;
    _bindNotifyView.clickBlock = ^(NSInteger clickType) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        switch (clickType) {
            case 1:  /// 返回
                strongSelf->_bindNotifyView.hidden = YES;
                break;
            case 2:  /// 游客登陆
                [strongSelf.accountPresenter visitorRequest];
                break;
            case 3:  /// 绑定
                strongSelf->_bindView.hidden = NO;
                break;
            default:
                break;
        }
    };
    
    _bindView.clickBlock = ^(NSInteger clickType) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        switch (clickType) {
            case 1:  /// 返回
                if(strongSelf->_showType == 2) { // 只展示绑定
                    [strongSelf dismissViewControllerAnimated:YES completion:nil];
                } else {
                    strongSelf->_bindView.hidden = YES;
                }
                break;
            case 2:  /// 绑定
            {
                NSString *account = strongSelf->_bindView.accountTF.text,
                        *password = strongSelf->_bindView.passwordTF.text,
                        *rePassword = strongSelf->_bindView.rePasswordTF.text,
                        *email = strongSelf->_bindView.emailTF.text;
                if (![password isEqualToString:rePassword]){
                    [MLProgressHUD showText: @"Password does not match."];
                } else {
                    [strongSelf.accountPresenter bindRequestWithAccount:account password:password gameId:[MLUserManger share].gusetGameId parameter:@{@"email":email?:@""}];
                }
            }
                break;
            case 3:  /// 注册协议
            {
                [strongSelf gotoServicesProtol:1];
            }
                break;
            case 4:  /// 隐私协议
            {
                [strongSelf gotoServicesProtol:2];
            }
                break;
            default:
                strongSelf->_registerVew.hidden = NO;
                break;
        }
    };
}

/// 跳转协议。
/// @param type 1 注册协议 2 隐私协议
- (void)gotoServicesProtol:(NSInteger)type {
    NSString *urlStr;
    if (type == 1) {
        urlStr = @"https://www.sixthkingdoms.com/term-services";
    } else {
        urlStr = @"https://www.sixthkingdoms.com/privacy-policy";
    }
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [self presentViewController:vc animated:YES completion:nil];
}

/// goole登陆
- (void)gooleLogin {
    __weak __typeof__(self) weakSelf = self;
    GIDConfiguration *signInConfig = [[GIDConfiguration alloc] initWithClientID:self.loginConfig.gooleClientID?:@"748197369663-mtcr8e00arei2bogdnofsoabdbsi86k2.apps.googleusercontent.com"];
    [GIDSignIn.sharedInstance signInWithConfiguration:signInConfig
                           presentingViewController:self
                                           callback:^(GIDGoogleUser * _Nullable user,
                                                      NSError * _Nullable error) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        if (error) {
            [strongSelf callBackApiUrl:MLGoole status:MLErrorValue result:@{@"status":MLErrorValue} error:error];
        } else {
            [strongSelf.accountPresenter gooleLoginWithAccount: user.userID
                                                     parameter:@{@"platform":MLGooleLogin,@"email":user.profile.email
                                                                                        ?:@""}];
        }
    }];
}

#pragma mark - private menthod

-(void)creatVCDelegate {
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (void)showLoginTo:(UIViewController *)vc{
    [vc presentViewController:self animated:YES completion:nil];
}

/// 展示注册界面 vc 是父控制器
- (void)showRegisterTo:(UIViewController *)vc {
    _showType = 1;
    [vc presentViewController:self animated:YES completion:nil];
}

/// 展示绑定界面 vc 是父控制器
- (void)showBindTo:(UIViewController *)vc {
    _showType = 2;
    [vc presentViewController:self animated:YES completion:nil];
}

/// 隐藏销毁
+ (void)dissmiss:(UIViewController *)vc {
    if(vc.presentedViewController && [vc.presentedViewController isKindOfClass:[MLoginSDK class]]) {
        [vc.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - dalegate

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[MLPresentation alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[HLLTransitioning alloc]init];
}

/// 请求回调
- (void)callBackApiUrl:(MLApiUrlType)apiUrlType status:(NSString *)status result:(id)result error:(NSError *)error {
    if (apiUrlType == MLGuestLoginID) return;
    if ([self.delegate respondsToSelector:@selector(callBackApiUrl:status:result:error:)]) {
        [self.delegate callBackApiUrl:apiUrlType status:status result:result error:error];
    }
    if (result && result[@"status_code"]) {
        [MLProgressHUD showText:result[@"status_code"]];
    }
    switch (apiUrlType) {
        case MLLogin: case MLGuestLogin: case MLRegister: case MLFacebook: case MLApple: case MLGoole: {
            if ([status isEqualToString:MLSuccessValue]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case MLAutoLogin: {
            if ([status isEqualToString:MLSuccessValue]) {
//                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
//                _loginView.hidden = NO;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - lazyUI
- (MLAccountPresenter *)accountPresenter {
    if (!_accountPresenter) {
        _accountPresenter = [[MLAccountPresenter alloc] init];
        _accountPresenter.delegate = self;
    }
    return _accountPresenter;
}

@end

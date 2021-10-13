//
//  MLLoginView.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLLoginView.h"
#import "MLUserManger.h"
#import "MLAppleLoginView.h"

@implementation MLLoginView
{
    UIButton *_rememberButton;  /// 记住密码按钮
    UIButton *_forgetButton;    /// 忘记密码按钮
    UIButton *_registerButton;  /// 注册按钮
    UIButton *_guestButton;     /// 游客登陆按钮
    
    UIButton *_otherButton;     /// 其他方式
    UIButton *_fackBookButton;  /// Fackbook按钮登陆
    UIButton *_gooleButton;     /// 谷歌按钮登陆
    UIButton *_appleButton;  ///苹果登陆
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
        [self layouFrame];
        [self imageBg];
    }
    return self;
}

- (void)layoutUI {
    [self addSubview:self.logoImg];
    [self addSubview:self.accountTF];
    [self addSubview:self.passwordTF];
    [self addSubview:self.loginButton];
    [self.loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.tag = 101;

    _rememberButton = [[UIButton alloc] init];
    _rememberButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_rememberButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _rememberButton.tag = 102;
    [self addSubview:_rememberButton];

    _forgetButton = [[UIButton alloc] init];
    _forgetButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_forgetButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _forgetButton.tag = 103;
    [self addSubview:_forgetButton];
    
    _registerButton = [[UIButton alloc] init];
    [_registerButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_registerButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _registerButton.tag = 104;
    [self addSubview:_registerButton];
    
    _guestButton = [[UIButton alloc] init];
    [_guestButton setTitle:@"Guest Login" forState:UIControlStateNormal];
    _guestButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_guestButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _guestButton.tag = 105;
    [self addSubview:_guestButton];
    
    _otherButton = [[UIButton alloc] init];
    [_otherButton setTitle:@"Other ways to login" forState:UIControlStateNormal];
    _otherButton.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [self addSubview:_otherButton];
    
    _fackBookButton = [[UIButton alloc] init];
    [_fackBookButton setBackgroundImage:[self imageNamed:@"fackbook_icom"] forState:UIControlStateNormal];
    [_fackBookButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _fackBookButton.tag = 106;
    [self addSubview:_fackBookButton];
    
    _gooleButton = [[UIButton alloc] init];
    [_gooleButton setBackgroundImage:[self imageNamed:@"goole_icom"] forState:UIControlStateNormal];
    [_gooleButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _gooleButton.tag = 107;
    [self addSubview:_gooleButton];
    
    if (@available(iOS 13.0, *)) {
        __weak __typeof__(self) weakSelf = self;
        _appleButton = [MLAppleLoginView createAppleButtonWithsuccess:^(ASAuthorization * _Nonnull authorization, NSString * _Nonnull user, NSString * _Nonnull email) {
            NSLog(@"授权成功");
            !weakSelf.appleBlock?:weakSelf.appleBlock(authorization, user, email, nil);
        } failure:^(NSError * _Nonnull err) {
            NSLog(@"授权失败");
            !weakSelf.appleBlock?:weakSelf.appleBlock(nil, nil, nil ,err);
        }];
        [_appleButton setBackgroundImage:[self imageNamed:@"apple_icon"] forState:UIControlStateNormal];
        [self addSubview:_appleButton];
        _appleButton.layer.cornerRadius = 2.0f;
        _appleButton.layer.masksToBounds = YES;
    } else {
        // Fallback on earlier versions
    }
}

- (void)layouFrame {
    self.logoImg.frame = CGRectMake(MLMargint, 6, self.width - MLMargint * 2, 45);
    self.accountTF.frame = CGRectMake(MLMargint, self.logoImg.maxY + 8, self.width - 120, MLTFHeight);
    self.passwordTF.frame = CGRectMake(self.accountTF.x, self.accountTF.maxY + 8, self.accountTF.width, self.accountTF.height);
    self.loginButton.frame = CGRectMake(self.accountTF.x - 2 , self.passwordTF.maxY + 4, self.accountTF.width + 4, MLLoginHeight);

    _rememberButton.frame = CGRectMake(self.accountTF.x - 5, self.loginButton.maxY, 118, 19);
    _forgetButton.frame = CGRectMake(self.accountTF.maxX - _rememberButton.width, self.loginButton.maxY, _rememberButton.width, _rememberButton.height);

    _registerButton.frame = CGRectMake(self.accountTF.x - 15, _forgetButton.maxY + 2, _rememberButton.width, 30);
    _guestButton.frame = CGRectMake(self.accountTF.maxX - 100, _registerButton.y, _rememberButton.width, 30);
    _guestButton.centerX = _forgetButton.centerX + 6;
    
    _otherButton.frame = CGRectMake(self.accountTF.x - 5 , _registerButton.maxY - 4, 110, 35);
    
    _appleButton.frame = CGRectMake(self.accountTF.x, self.height - 80, 55, 55);
    _appleButton.centerX = self.loginButton.centerX;
    CGFloat Twidth =  self.accountTF.width/2;
    if (_appleButton.y > 0) {
        _fackBookButton.frame = CGRectMake(self.accountTF.x - 5, _appleButton.y, 55, 55);
        _gooleButton.frame = CGRectMake(self.accountTF.maxX - 50, _appleButton.y, 55, 55);
    }  else  {
        _fackBookButton.frame = CGRectMake((Twidth - 55)/2 + self.accountTF.x, self.height - 80, 55, 55);
        _gooleButton.frame = CGRectMake(self.loginButton.centerX + (Twidth - 55)/2, self.height - 80, 55, 55);
    }
}

- (void)imageBg {
    self.loginButton.backgroundColor = [self.loginButton colorWithImage: [self imageNamed:@"login_btn_icon"]];
    _rememberButton.backgroundColor = [_rememberButton colorWithImage: [self imageNamed:[MLUserManger share].isRemember?@"remember_me_selected_icon":@"remember_me_icon"]];
    _forgetButton.backgroundColor = [_rememberButton colorWithImage: [self imageNamed:@"forget_password_icon"]];
}

- (void)clickButton:(UIButton *)sender {
    !self.clickBlock?:self.clickBlock(sender.tag - 100);
    if (sender.tag - 100 == 2) {
        [MLUserManger share].isRemember = ![MLUserManger share].isRemember;
        _rememberButton.backgroundColor = [_rememberButton colorWithImage: [self imageNamed:[MLUserManger share].isRemember?@"remember_me_selected_icon":@"remember_me_icon"]];
        if (![MLUserManger share].isRemember) {
            [[MLUserManger share] clearAccout];
        }
    }
}

@end

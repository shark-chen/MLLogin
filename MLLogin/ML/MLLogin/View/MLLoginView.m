//
//  MLLoginView.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLLoginView.h"
#import "MLUserManger.h"


@implementation MLLoginView
{
    UIButton *_rememberButton;  /// 记住密码按钮
    UIButton *_forgetButton;    /// 忘记密码按钮
    UIButton *_registerButton;  /// 注册按钮
    UIButton *_guestButton;     /// 游客登陆按钮
    
    UIButton *_otherButton;     /// 其他方式
    UIButton *_fackBookButton;  /// Fackbook按钮登陆
    UIButton *_gooleButton;     /// 谷歌按钮登陆
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
    _registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_registerButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _registerButton.tag = 104;
    [self addSubview:_registerButton];
    
    _guestButton = [[UIButton alloc] init];
    [_guestButton setTitle:@"Guest Login" forState:UIControlStateNormal];
    _guestButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
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
}

- (void)layouFrame {
    self.logoImg.frame = CGRectMake(MLMargint, 6, self.width - MLMargint * 2, 45);
    self.accountTF.frame = CGRectMake(MLMargint, self.logoImg.maxY + 8, self.width - 120, MLTFHeight);
    self.passwordTF.frame = CGRectMake(self.accountTF.x, self.accountTF.maxY + 8, self.accountTF.width, self.accountTF.height);
    self.loginButton.frame = CGRectMake(self.accountTF.x - 2 , self.passwordTF.maxY + 4, self.accountTF.width + 4, MLLoginHeight);

    _rememberButton.frame = CGRectMake(self.accountTF.x, self.loginButton.maxY, 107.5, 15.5);
    _forgetButton.frame = CGRectMake(self.accountTF.maxX - _rememberButton.width, self.loginButton.maxY, _rememberButton.width, _rememberButton.height);

    _registerButton.frame = CGRectMake(self.accountTF.x, _forgetButton.maxY + 12, _rememberButton.width, 30);
    _guestButton.frame = CGRectMake(self.accountTF.maxX - 100, _registerButton.y, _rememberButton.width, 30);
    
    _otherButton.frame = CGRectMake(self.accountTF.x , _registerButton.maxY + 25, self.passwordTF.width * 0.5, 30);
    _fackBookButton.frame = CGRectMake(_otherButton.maxX, _otherButton.y - 15, 60, 60);
    _fackBookButton.centerY = _otherButton.centerY;
    _gooleButton.frame = CGRectMake(_fackBookButton.maxX, _fackBookButton.y, 60, 60);
    _gooleButton.centerY = _otherButton.centerY;
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
    }
}

@end

//
//  MLBaseLoginView.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLBaseAccountView.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "UIView+ML.h"

@implementation MLBaseAccountView

#pragma mark - private menthod

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] initWithImage:[self imageNamed:@"background_icon"]];
        bg.frame = self.bounds;
        [self addSubview:bg];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)conFigText:(UITextField *)TF {
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(TF, ivar);
    placeholderLabel.textColor = [UIColor whiteColor];
    placeholderLabel.font = [UIFont boldSystemFontOfSize:12];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.width = 10;
    TF.leftViewMode = UITextFieldViewModeAlways;
    TF.leftView = leftView;
}

#pragma mark - lazyUI

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setBackgroundImage:[self imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [self imageNamed:@"logo_icom"];
    }
    return _logoImg;
}

- (UITextField *)accountTF {
    if (!_accountTF) {
        _accountTF = [[UITextField alloc] init];
        _accountTF.placeholder = @"Username";
        _accountTF.font = [UIFont systemFontOfSize:16];
        _accountTF.textColor = [UIColor whiteColor];
        _accountTF.backgroundColor = [UIColor colorWithHex:0x6A728A alpha:1];
        [self conFigText: _accountTF];
    }
    return _accountTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.placeholder = @"Password";
        _passwordTF.font = [UIFont systemFontOfSize:16];
        _passwordTF.textColor = [UIColor whiteColor];
        _passwordTF.backgroundColor = [UIColor colorWithHex:0x6A728A alpha:1];
        [self conFigText: _passwordTF];
    }
    return _passwordTF;
}

- (UITextField *)rePasswordTF {
    if (!_rePasswordTF) {
        _rePasswordTF = [[UITextField alloc] init];
        _rePasswordTF.placeholder = @"Re-type Password";
        _rePasswordTF.font = [UIFont systemFontOfSize:16];
        _rePasswordTF.textColor = [UIColor whiteColor];
        _rePasswordTF.backgroundColor = [UIColor colorWithHex:0x6A728A alpha:1];
        [self conFigText: _rePasswordTF];
    }
    return _rePasswordTF;
}

- (UITextField *)emailTF {
    if (!_emailTF) {
        _emailTF = [[UITextField alloc] init];
        _emailTF.placeholder = @"Email";
        _emailTF.font = [UIFont systemFontOfSize:16];
        _emailTF.textColor = [UIColor whiteColor];
        _emailTF.backgroundColor = [UIColor colorWithHex:0x6A728A alpha:1];
        [self conFigText: _emailTF];
    }
    return _emailTF;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _loginButton;
}

@end

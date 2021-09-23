//
//  MLForgetPasswordView.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLForgetPasswordView.h"

@implementation MLForgetPasswordView

{
    UILabel *_infoLabel;  /// Already have an account?
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
        [self layouFrame];
    }
    return self;
}

- (void)layoutUI {
    [self addSubview:self.backButton];
    self.backButton.tag = 101;
    [self.backButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.logoImg];
    [self addSubview:self.emailTF];
    [self addSubview:self.loginButton];
    self.loginButton.tag = 102;
    [self.loginButton setBackgroundImage:[self imageNamed:@"send_password_icon"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.text = @"Please enter your registered email and press SEND. You will receive an email to recover your password.";
    _infoLabel.font = [UIFont boldSystemFontOfSize:14];
    _infoLabel.numberOfLines = 0;
    _infoLabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
    [self addSubview:_infoLabel];
}

- (void)layouFrame {
    self.backButton.frame = CGRectMake(10, 0, 50, 40);
    self.logoImg.frame = CGRectMake(MLMargint, 6, self.width - MLMargint * 2, 45);
    self.backButton.centerY =  self.logoImg.centerY;
    _infoLabel.frame = CGRectMake(MLMargint, self.logoImg.maxY + 6, self.width - MLMargint * 2, 80);
    
    self.emailTF.frame = CGRectMake(MLMargint, _infoLabel.maxY + 15, self.width - MLMargint * 2, MLTFHeight);
    
    self.loginButton.frame = CGRectMake(self.emailTF.x - 3, self.emailTF.maxY + 40, self.emailTF.width + 6, MLLoginHeight);
}

- (void)clickButton:(UIButton *)sender {
    !self.clickBlock?:self.clickBlock(sender.tag - 100);
}

@end

//
//  MLRegisterVew.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLRegisterVew.h"

@implementation MLRegisterVew
{
    UILabel *_infoLabel;  /// Already have an account?
    UILabel *_textLabel;  /// By registering, you agress to SIXTHKINGDOMS's Term & Service and Privacy Policy
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
    [self addSubview:self.accountTF];
    [self addSubview:self.passwordTF];
    [self addSubview:self.rePasswordTF];
    [self addSubview:self.emailTF];
    [self addSubview:self.loginButton];
    [self.loginButton setBackgroundImage:[self imageNamed:@"register_icon"] forState:UIControlStateNormal];
    self.loginButton.tag = 102;
    [self.loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.text = @"Already have an account?";
    _infoLabel.font = [UIFont systemFontOfSize:12];
    _infoLabel.textColor = [UIColor colorWithHex:0x6D87FB alpha:1];
    [self addSubview:_infoLabel];

    _textLabel = [[UILabel alloc] init];
    _textLabel.text = @"By registering, you agress to SIXTHKINGDOMS's \nTerm & Service and Privacy Policy";
    _textLabel.font = [UIFont systemFontOfSize:10];
    _textLabel.textColor = [UIColor colorWithHex:0x6D87FB alpha:1];
    _textLabel.numberOfLines = 0;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_textLabel setUserInteractionEnabled:YES];
    [self addSubview:_textLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textClick:)];
    [_textLabel addGestureRecognizer:tap];
}

- (void)layouFrame {
    self.backButton.frame = CGRectMake(10, 0, 50, 40);
    self.logoImg.frame = CGRectMake(MLMargint, 6, self.width - MLMargint * 2, 45);
    self.backButton.centerY =  self.logoImg.centerY;
    _infoLabel.frame = CGRectMake(60, self.logoImg.maxY + 6, 200, 13);
    
    self.accountTF.frame = CGRectMake(MLMargint, _infoLabel.maxY + 8, self.width - MLMargint * 2, MLTFHeight);
    self.passwordTF.frame = CGRectMake(self.accountTF.x, self.accountTF.maxY + 6, self.accountTF.width, self.accountTF.height);
    self.rePasswordTF.frame = CGRectMake(self.accountTF.x, self.passwordTF.maxY + 6, self.accountTF.width, self.accountTF.height);
    self.emailTF.frame = CGRectMake(self.accountTF.x, self.rePasswordTF.maxY + 6, self.accountTF.width, self.accountTF.height);
    
    _textLabel.frame = CGRectMake(0, self.emailTF.maxY + 5, self.width, 24);
    self.loginButton.frame = CGRectMake(self.accountTF.x - 3, _textLabel.maxY + 6, self.accountTF.width + 6, MLLoginHeight);
}

- (void)clickButton:(UIButton *)sender {
    !self.clickBlock?:self.clickBlock(sender.tag - 100);
}

- (void)textClick:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:_textLabel];
    if (point.x < _textLabel.width/2) {
        !self.clickBlock?:self.clickBlock(3);
    } else {
        !self.clickBlock?:self.clickBlock(4);
    }
}

@end

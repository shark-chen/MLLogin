//
//  MLBindView.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLBindView.h"
#import "MLUserManger.h"

@implementation MLBindView
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
    [self.loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.tag = 102;

    _infoLabel = [[UILabel alloc] init];
    _infoLabel.text = [NSString stringWithFormat:@"Guest ID:%@", [MLUserManger share].gusetGameId];
    _infoLabel.font = [UIFont boldSystemFontOfSize:12];
    _infoLabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
    [self addSubview:_infoLabel];

    _textLabel = [[UILabel alloc] init];
    _textLabel.text = @"By registering, you agress to SIXTHKINGDOMS's Term & Service and Privacy Policy";
    _textLabel.font = [UIFont systemFontOfSize:6.5];
    _textLabel.textColor = [UIColor colorWithHex:0x5B72CC alpha:1];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];
}

- (void)layouFrame {
    self.backButton.frame = CGRectMake(10, 0, 50, 40);
    self.logoImg.frame = CGRectMake(MLMargint, 6, self.width - MLMargint * 2, 45);
    self.backButton.centerY =  self.logoImg.centerY;
    _infoLabel.frame = CGRectMake(MLMargint, self.logoImg.maxY + 6, 200, 13);
    
    self.accountTF.frame = CGRectMake(MLMargint, _infoLabel.maxY + 8, self.width - MLMargint * 2, MLTFHeight);
    self.passwordTF.frame = CGRectMake(self.accountTF.x, self.accountTF.maxY + 6, self.accountTF.width, self.accountTF.height);
    self.rePasswordTF.frame = CGRectMake(self.accountTF.x, self.passwordTF.maxY + 6, self.accountTF.width, self.accountTF.height);
    self.emailTF.frame = CGRectMake(self.accountTF.x, self.rePasswordTF.maxY + 6, self.accountTF.width, self.accountTF.height);
    
    _textLabel.frame = CGRectMake(0, self.emailTF.maxY + 10, self.width, 13);
    self.loginButton.frame = CGRectMake(self.accountTF.x - 3, _textLabel.maxY + 6, self.accountTF.width + 6, MLLoginHeight);
}


- (void)clickButton:(UIButton *)sender {
    !self.clickBlock?:self.clickBlock(sender.tag - 100);
}

@end

//
//  MLBIndNotifyView.m
//  MLLogin
//
//  Created by shark on 2021/9/18.
//

#import "MLBindNotifyView.h"
#import "MLUserManger.h"

@implementation MLBindNotifyView
{
    UILabel *_infoLabel;  /// Already have an account?
    UILabel *_textLabel;  /// By registering, you agress to SIXTHKINGDOMS's Term & Service and Privacy Policy
    UIButton *_bindButton;  ///绑定按钮
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
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.text = [NSString stringWithFormat:@"Guest ID:%@", [MLUserManger share].gusetGameId];
    _infoLabel.font = [UIFont boldSystemFontOfSize:13];
    _infoLabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
    [self addSubview:_infoLabel];
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.text = @"Please bind your account to get \nmore service from us.\n*forget password need your email\nvalid and registered";
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.textColor = [UIColor colorWithHex:0xFFFFFF alpha:1];
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
    
    [self.loginButton setBackgroundImage:[self imageNamed:@"continue_icon"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.tag = 102;
    [self addSubview:self.loginButton];

    _bindButton = [[UIButton alloc] init];
    [_bindButton setBackgroundImage:[self imageNamed:@"bind_icon"] forState:UIControlStateNormal];
    [_bindButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _bindButton.tag = 103;
    [self addSubview:_bindButton];
}

- (void)layouFrame {
    self.backButton.frame = CGRectMake(10, 0, 50, 40);
    self.logoImg.frame = CGRectMake(MLMargint, 6, self.width - MLMargint * 2, 45);
    self.backButton.centerY =  self.logoImg.centerY;
    
    _infoLabel.frame = CGRectMake(MLMargint, self.logoImg.maxY + 35, 200, 14);

    _textLabel.frame = CGRectMake(MLMargint, _infoLabel.maxY + 12, 200, 80);

    self.loginButton.frame = CGRectMake(MLMargint - 3, _textLabel.maxY + 25, self.width - MLMargint * 2+ 6, MLLoginHeight);
    _bindButton.frame = CGRectMake(self.loginButton.x, self.loginButton.maxY, self.loginButton.width, MLLoginHeight);
}

- (void)clickButton:(UIButton *)sender {
    !self.clickBlock?:self.clickBlock(sender.tag - 100);
}

@end


//
//  MLBaseLoginView.h
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import <UIKit/UIKit.h>
#import "UIColor+ML.h"
#import "UIView+ML.h"

NS_ASSUME_NONNULL_BEGIN

static CGFloat MLTFHeight = 38;
static CGFloat MLLoginHeight = 50;
static CGFloat MLMargint = 60;



@interface MLBaseAccountView : UIView

/// 点击事件回调  1 点击返回按钮， 2 点击loginButton登陆注册按钮
@property (copy, nonatomic) void(^clickBlock)(NSInteger clickType);

@property (strong, nonatomic) UIButton *backButton;   /// 返回按钮
@property (strong, nonatomic) UIImageView *logoImg;    /// logo
@property (strong, nonatomic) UITextField *accountTF;   /// 账号输入框
@property (strong, nonatomic) UITextField *passwordTF;  /// 密码输入框
@property (strong, nonatomic) UITextField *rePasswordTF;   /// 密码确认输入
@property (strong, nonatomic) UITextField *emailTF;     /// 邮箱输入框

@property (strong, nonatomic) UIButton *loginButton;   /// 登陆，注册，绑定等按钮

@end

NS_ASSUME_NONNULL_END

//
//  MLoginViewController.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import <UIKit/UIKit.h>
#import "MLLoginDalegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLLoginConfig : NSObject

/// 是否需要自动登陆, 默认是自动打开的
@property (assign, nonatomic) BOOL needAutoLogin;
/// 谷歌用户端ID，可动态配置
@property (strong, nonatomic) NSString *gooleClientID;
@property (assign, nonatomic) BOOL showAppleLogin;  /// 默认展示

@end

@interface MLLoginSDKInfo : NSObject

@property (strong, nonatomic, readonly) NSString *account;
@property (strong, nonatomic, readonly) NSString *password;
@property (strong, nonatomic, readonly) NSString *gameId;
@property (strong, nonatomic, readonly) NSString *gusetGameId;
@property (strong, nonatomic, readonly) NSString *appleUserId;

+ (instancetype)share;

/// 清楚本地存储的账号数据
- (void)clearAccout;

- (instancetype)init NS_UNAVAILABLE;

@end

@interface MLoginSDK : UIViewController

- (instancetype)init NS_UNAVAILABLE;

/// dalagate get call back data
@property (weak, nonatomic) id<MLLoginDalegate> delegate;
@property (strong, nonatomic, readonly) MLLoginConfig *loginConfig;
     
/// init function
/// @param game gameName
/// @param encryptKey parent View
/// @param config 其他配置
- (instancetype)initWithGame:(NSString *)game
                  encryptKey:(NSString *)encryptKey
                      config:(MLLoginConfig * __nullable)config;


/// 展示登陆界面 vc 是父控制器
- (void)show:(UIViewController *)vc;

/// 隐藏销毁
/// @param vc 父控制器
+ (void)dissmiss:(UIViewController *)vc;

/// 清楚本地存储的账号数据
- (void)clearAccout;

@end

NS_ASSUME_NONNULL_END

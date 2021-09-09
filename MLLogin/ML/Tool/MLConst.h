//
//  MLDevice.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MLUserType) {
    MLRegularUserType,      /// 普通正常用户
    MLVisitorUserType,      /// 游客用户
    MLUnknownUserType       /// 未知用户类型
};

@interface MLConst : NSObject

#pragma mark - App Info

/// app显示名称
+ (NSString*)appDisplayName;

+ (NSString*)appBundleID;

/// 版本号 example: 1.0.2
+ (NSString*)appVersion;

/// 构建号 example: 1002，根据 appVersion 计算得出
+ (NSString*)appBuild;

/// 数字构建号 example: 1002，根据 appVersion 计算得出
+ (int)appBuildNumber;

#pragma mark - Device Info

///设备名称 example: iPhone 7Plus
+ (NSString*)deviceName;

/// 设备uuid
+ (NSString *)deviceUUID;
/// 清除设备uuid
+ (void)clearDeviceUUID;

///wifi名称
+(NSString*)wifiName;

///mac-wifi地址
+ (NSString *)macAddress;

//ip地址
+ (NSString *)ipAddress;

/// 获取bundle图片
UIImage* MLImage(NSString *name);

@end

NS_ASSUME_NONNULL_END

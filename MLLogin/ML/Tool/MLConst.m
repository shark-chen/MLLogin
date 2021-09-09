//
//  MLDevice.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLConst.h"
#import "MLKeychain.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation MLConst

+ (NSString *)appDisplayName{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString *)appBundleID{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)appVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString*)appBuild{
    return [@([self appBuildNumber]) stringValue];
}

+ (int)appBuildNumber {
    static int buildNumber;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *versionNumbers = [[self appVersion] componentsSeparatedByString:@"."];
        int mainVersion = [versionNumbers.firstObject intValue];
        int subVersion = versionNumbers.count<2?0:[versionNumbers[1] intValue];
        int patchVersion = versionNumbers.count<3?0:[versionNumbers[2] intValue];
        buildNumber = mainVersion*1000 + subVersion*100 + patchVersion;
    });
    return buildNumber;
}

#pragma mark - Device Info
// 生成UUID并保存到keychain以保证APP重装后UUID不变
+ (NSString *)deviceUUID {
    NSString *uuidKey = @"ML_GAME_UUID";
    static NSString *UUIDString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UUIDString = (NSString *)[MLKeychain load:uuidKey];
       if (!UUIDString || [UUIDString isEqualToString:@""]){
           UUIDString = [[[[UIDevice currentDevice] identifierForVendor] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
           if (UUIDString) {
               [MLKeychain save:uuidKey data:UUIDString];
           }
       }
    });
    return UUIDString;
}

+ (void)clearDeviceUUID {
    NSString *uuidKey = @"ML_GAME_UUID";
    [MLKeychain deleteKeyData:uuidKey];
}

+ (NSString*)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform , *deviceName = @"";
    platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform hasPrefix:@"iPad"]) {
        deviceName = @"iPad";
    }else if ([platform hasPrefix:@"iPod"]){
        deviceName = @"iPod";
    }else{
        deviceName = [self deviceNameDic][platform];
        if (!deviceName || deviceName.length ==0) {
            deviceName = platform;
        }
    }
    
    return deviceName;
}

+ (NSDictionary<NSString* , NSString*>*)deviceNameDic
{
    return @{@"iPhone1,1":@"iPhone 2G",
             @"iPhone1,2":@"iPhone 3G",
             @"iPhone2,1":@"iPhone 3GS",
             @"iPhone3,1":@"iPhone 4",
             @"iPhone3,2":@"iPhone 4",
             @"iPhone3,3":@"iPhone 4",
             @"iPhone3,3":@"iPhone 4",
             @"iPhone4,1":@"iPhone 4S",
             @"iPhone5,1":@"iPhone 5",
             @"iPhone5,2":@"iPhone 5",
             @"iPhone5,3":@"iPhone 5c",
             @"iPhone5,4":@"iPhone 5c",
             @"iPhone6,1":@"iPhone 5s",
             @"iPhone6,2":@"iPhone 5s",
             @"iPhone7,1":@"iPhone 6 Plus",
             @"iPhone7,2":@"iPhone 6",
             @"iPhone8,1":@"iPhone 6s",
             @"iPhone8,2":@"iPhone 6s Plus",
             @"iPhone8,4":@"iPhone SE",
             @"iPhone9,1":@"iPhone 7",
             @"iPhone9,2":@"iPhone 7 Plus",
             @"iPhone10,1":@"iPhone 8",
             @"iPhone10,4":@"iPhone 8",
             @"iPhone10,2":@"iPhone 8 Plus",
             @"iPhone10,5":@"iPhone 8 Plus",
             @"iPhone10,3":@"iPhone X",
             @"iPhone10,6":@"iPhone X",
             @"iPhone11,2":@"iPhone XS",
             @"iPhone11,4":@"iPhone XS Max",
             @"iPhone11,6":@"iPhone XS Max",
             @"iPhone11,8":@"iPhone XR",
             @"iPhone12,1":@"iPhone 11",
             @"iPhone12,3":@"iPhone 11 Pro",
             @"iPhone12,5":@"iPhone 11 Pro Max",
             @"iPhone12,8":@"iPhone SE2",
             @"iPhone13,1":@"iPhone 12 mini",
             @"iPhone13,2":@"iPhone 12",
             @"iPhone13,3":@"iPhone 12 Pro",
             @"iPhone13,4":@"iPhone 12 Pro Max",
             @"i386":@"iPhone Simulator",
             @"x86_64":@"iPhone Simulator"};
}

+(NSString*)wifiName{
    NSString *ssid = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            ssid = [dict valueForKey:@"SSID"];
        }
    }
    return ssid;
}

+ (NSString *)macAddress{
    NSString *bssid = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            bssid = [dict valueForKey:@"BSSID"];
        }
    }
    return bssid;
}

+ (NSString *)ipAddress{
   NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

@end

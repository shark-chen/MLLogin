//
//  MLParameter.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *MLBaseURL = @"http://api.sixthkingdoms.com";

@interface MLParameter : NSObject

+ (NSDictionary*)publicParametersDic;

@end

@interface MLUserManger : NSObject

@property (strong, nonatomic) NSString *encryptKey;   /// 加密
@property (strong, nonatomic) NSString *game;      /// 游戏ID

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *gameId;
@property (strong, nonatomic) NSString *gusetGameId;
@property (strong, nonatomic) NSString *appleUserId;
@property (assign, nonatomic) BOOL isRemember;   /// 是否记住密码

+ (instancetype)share;

- (void)clearAccout;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

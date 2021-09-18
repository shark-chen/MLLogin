//
//  MLParameter.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLUserManger.h"
#import "MLConst.h"
#import "NSDate+ML.h"
#import "MLKeychain.h"

@implementation MLParameter

+ (NSDictionary*)publicParametersDic {
    return @{@"uuid":[MLConst deviceUUID] ?:@"",
             @"ip": [MLConst ipAddress] ?:@"",
             @"time": [NSDate ml_currentTimeStampString] ?:@"",
             @"game": [MLUserManger share].game,
    };
}

@end

@implementation MLUserManger

static NSString *MLAccountKey = @"ML_GAME_ACCOUT";
static NSString *MLPasswordKey = @"ML_GAME_PASSWORD";
static NSString *MLIsRemember = @"ML_GAME_ISREMEMBER";
static NSString *MLGameId = @"ML_GAME_GAMEID";
static NSString *MLGusetGameId = @"ML_GAME_GUEST_GAMEID";
static NSString *MLAppleUserID = @"ML_GAME_APPLE_USERID";
static NSString *MLPlatformID = @"ML_GAME_PLATFORMID";

+ (instancetype)share {
    static MLUserManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.account = [MLKeychain load: MLAccountKey];
        instance.password = [MLKeychain load: MLPasswordKey];
        instance.gameId = [MLKeychain load: MLGameId];
        instance.gusetGameId = [MLKeychain load: MLGusetGameId];
        instance.appleUserId = [MLKeychain load: MLAppleUserID];
        instance.isRemember = [[NSUserDefaults standardUserDefaults] boolForKey:MLIsRemember];
    });
    return instance;
}

- (void)setAccount:(NSString *)account {
    _account = account;
    if (!self.isRemember) return;
    [MLKeychain save:MLAccountKey data:account];
}

- (void)setPassword:(NSString *)password {
    _password = password;
    if (!self.isRemember) return;
    [MLKeychain save:MLPasswordKey data:password];
}

- (void)setGameId:(NSString *)gameId {
    _gameId = gameId;
    if (!self.isRemember) return;
    [MLKeychain save:MLGameId data:gameId];
}

- (void)setGusetGameId:(NSString *)gusetGameId {
    _gusetGameId = gusetGameId;
    if (!self.isRemember) return;
    [MLKeychain save:MLGusetGameId data:gusetGameId];
}

- (void)setAppleUserId:(NSString *)appleUserId {
    _appleUserId = appleUserId;
    [MLKeychain save:MLAppleUserID data:appleUserId];
}

- (void)setPlatform:(NSString *)platform {
    _platform = platform;
    if (!self.isRemember) return;
    [MLKeychain save:MLPlatformID data:platform];
}

- (void)setIsRemember:(BOOL)isRemember {
    _isRemember = isRemember;
    [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:MLIsRemember];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearAccout {
    [MLKeychain deleteKeyData: MLAccountKey];
    [MLKeychain deleteKeyData: MLPasswordKey];
    [MLKeychain deleteKeyData: MLGameId];
    [MLKeychain deleteKeyData: MLPlatformID];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:MLIsRemember];
    self.account = @"";
    self.password = @"";
    self.gameId = @"";
    self.platform = @"";
}

@end

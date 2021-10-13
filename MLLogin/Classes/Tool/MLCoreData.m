//
//  MLCoreData.m
//  MLLogin
//
//  Created by shark on 2021/10/13.
//

#import "MLCoreData.h"

@implementation MLCoreData

+ (void)saveObject:(NSString *)object forKey:(NSString *)forKey {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:forKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)stringForKey:(NSString *)forKey {
    return [[NSUserDefaults standardUserDefaults] stringForKey:forKey];
}

+ (void)deleteKeyData:(NSString *)forKey {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:forKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

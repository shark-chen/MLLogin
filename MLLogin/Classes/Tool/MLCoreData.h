//
//  MLCoreData.h
//  MLLogin
//
//  Created by shark on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLCoreData : NSObject

+ (void)saveObject:(NSString *)object forKey:(NSString *)forKey;
+ (NSString*)stringForKey:(NSString *)forKey;
+ (void)deleteKeyData:(NSString *)forKey;

@end

NS_ASSUME_NONNULL_END

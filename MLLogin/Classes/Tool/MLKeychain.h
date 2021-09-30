//
//  MLKeychain.h
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLKeychain : NSObject

/**
 保存到keychain

 @param service 在keychain中的service名
 @param data 待保存对象
 */
+ (void)save:(NSString *)service data:(id)data;

/**
 从keychain加载

 @param service 在keychain中的service名
 @return 保存的对象
 */
+ (id)load:(NSString *)service;

/**
 从keychain删除

 @param service 在keychain中的service名
 */
+ (void)deleteKeyData:(NSString *)service;

@end

NS_ASSUME_NONNULL_END

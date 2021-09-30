//
//  MLFacebookApi.h
//  GameProject
//
//  Created by shark on 2021/9/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLFacebookApi : NSObject

- (void)facebookLogin:(UIViewController * __nullable)fromVC
             complete:(void(^)(NSDictionary *result, NSError * _Nullable error))complete;

@end

NS_ASSUME_NONNULL_END

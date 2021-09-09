//
//  MLProgressHUD+MLCommon.h
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLProgressHUD (ML)

+ (instancetype)showLoading;

+ (instancetype)showLoadingText:(NSString *)text;
    
+ (instancetype)showText:(NSString *)text;

+ (BOOL)hide;

@end

NS_ASSUME_NONNULL_END

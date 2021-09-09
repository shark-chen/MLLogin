//
//  UIViewController+MLCommon.h
//  GameProject
//
//  Created by shark on 2021/9/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ML)

/// 当前最上层的vc
+ (UIViewController *)topViewController;

@end

NS_ASSUME_NONNULL_END

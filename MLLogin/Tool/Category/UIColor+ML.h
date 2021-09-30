//
//  UIColor+ML.h
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ML)

/**
 根据16进制生成对应颜色

 @param hex 颜色十六进制
 @return 生成的颜色
 */
+ (UIColor *)colorWithHex:(int)hex;

/**
 根据16进制和透明度生成对应颜色

 @param hex 颜色十六进制
 @param alpha 颜色透明度
 @return 生成的颜色
 */
+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END

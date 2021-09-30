//
//  UIColor+ML.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "UIColor+ML.h"

@implementation UIColor (ML)

+ (UIColor *)colorWithHex:(int)hex {
    return [self colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.f
                           green:((hex >> 8) & 0xFF)/255.f
                            blue:(hex & 0xFF)/255.f
                           alpha:alpha];
}



@end

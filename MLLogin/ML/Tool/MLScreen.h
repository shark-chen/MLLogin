//
//  MLScreen.h
//  GameProject
//
//  Created by shark on 2021/9/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLScreen : NSObject

#undef  MLScreenBounds
#define MLScreenBounds KMLScreenBounds()

/// 屏幕尺寸
#undef  MLScreenSize
#define MLScreenSize KMLScreenSize()

/// 屏幕宽度
#undef  MLScreenWidth
#define MLScreenWidth KMLScreenSize().width

/// 屏幕高度
#undef  MLScreenHeight
#define MLScreenHeight KMLScreenSize().height

//根据6，7，8适配
#define MLScaleWidth(width) (width / 375.0) * MLScreenWidth
#define MLScaleHeight(height) (height / 667.0) * MLScreenHeight

#undef  MLKeyWindow
#define MLKeyWindow [UIApplication sharedApplication].keyWindow

#undef  MLTopViewController
#define MLTopViewController [UIViewController topViewController]

#undef  MLTopView
#define MLTopView [[UIApplication sharedApplication].windows lastObject]

#define MLImage(name) [NSString stringWithFormat:(name), ##__VA_ARGS__];

CGSize KMLScreenSize(void);

CGRect KMLScreenBounds(void);

bool isIpad(void);

@end

NS_ASSUME_NONNULL_END

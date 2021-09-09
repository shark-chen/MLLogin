//
//  UIView+MLCommon.h
//  GameProject
//
//  Created by shark on 2021/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ML)

/// 所在控制器
@property (nonatomic,weak,readonly) UIViewController* viewController;

/// 宽
@property (nonatomic,assign) CGFloat width;

/// 高
@property (nonatomic,assign) CGFloat height;

/// X坐标
@property (nonatomic,assign) CGFloat x;

/// Y坐标
@property (nonatomic,assign) CGFloat y;

/// 尺寸
@property (nonatomic,assign) CGSize size;

/// 坐标
@property (nonatomic,assign) CGPoint origin;

/// 在X轴的最大值
@property (nonatomic,assign) CGFloat maxX;

/// 在Y轴的最大值
@property (nonatomic,assign) CGFloat maxY;

/// 中心点的X坐标
@property (assign,nonatomic) CGFloat centerX;

/// 中心点的Y坐标
@property (assign,nonatomic) CGFloat centerY;

/// 图片生成颜色
/// @param image 图片对象
- (UIColor *)colorWithImage:(UIImage *)image;


/// 获取bundle图片
/// @param name 图片
- (UIImage *)imageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

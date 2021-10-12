//
//  UIView+MLCommon.m
//  GameProject
//
//  Created by shark on 2021/9/2.
//

#import "UIView+ML.h"

@implementation UIView (ML)

#pragma mark - width

- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
#pragma mark - height

- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
#pragma mark - x
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

#pragma mark - y
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
#pragma mark - y
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - origin
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}

#pragma mark - maxX
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

#pragma mark - maxY
- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

- (UIColor *)colorWithImage:(UIImage *)image {
    if (image) {
        UIImage *oldImage = image;
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        [oldImage drawInRect:self.bounds];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return [UIColor colorWithPatternImage:newImage];
    }
    return nil;
}

/// 获取bundle图片
/// @param name 图片
- (UIImage *)imageNamed:(NSString *)name {
    return [UIImage imageNamed:[NSString stringWithFormat:@"MLLoginResources.bundle/images/%@", name] inBundle: [NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

@end

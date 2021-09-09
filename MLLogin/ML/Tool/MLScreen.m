//
//  MLScreen.m
//  GameProject
//
//  Created by shark on 2021/9/3.
//

#import "MLScreen.h"

@implementation MLScreen

CGSize KMLScreenSize(){
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

CGRect KMLScreenBounds(){
    static CGRect rect;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rect = [UIScreen mainScreen].bounds;
    });
    return rect;
}

bool isIpad(void) {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

CGFloat HLLOrientedScreenWidth(){
    return isLandscape()?KMLScreenSize().height:KMLScreenSize().width;
}

CGFloat HLLOrientedScreenHeight(){
    return isLandscape()?KMLScreenSize().width:KMLScreenSize().height;
}

bool isLandscape() {
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
}

@end

//
//  MLProgressHUD+MLCommon.m
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLProgressHUD+ML.h"
#import "MLScreen.h"

@implementation MLProgressHUD (ML)

+ (instancetype)showLoadingText:(NSString *)text {
    MLProgressHUD *hud = [MLProgressHUD showHUDAddedTo:MLKeyWindow animated:YES];
    hud.mode = MLProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(text, @"HUD loading title");
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:3.0f];
    return hud;
}

+ (instancetype)showLoading {
    MLProgressHUD *hud = [MLProgressHUD showHUDAddedTo:MLKeyWindow animated:YES];
    [hud hideAnimated:YES afterDelay:4.0f];
    return hud;
}

+ (instancetype)showText:(NSString *)text {
    MLProgressHUD *hud = [MLProgressHUD showHUDAddedTo:MLKeyWindow animated:YES];
    hud.mode = MLProgressHUDModeText;
    hud.label.text = NSLocalizedString(text, @"HUD loading title");
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:3.0f];
    return hud;
}

+ (BOOL)hide {
    MLProgressHUD *hud = [self HUDForView:MLKeyWindow];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
        return YES;
    }
    return NO;
}


@end

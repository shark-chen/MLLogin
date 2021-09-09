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
    MLProgressHUD *hud = [MLProgressHUD showHUDAddedTo:MLTopView animated:YES];
    hud.mode = MLProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(text, @"HUD loading title");
    return hud;
}

+ (instancetype)showLoading {
    MLProgressHUD *hud = [MLProgressHUD showHUDAddedTo:MLTopView animated:YES];
    return hud;
}

+ (instancetype)showText:(NSString *)text {
    MLProgressHUD *hud = [MLProgressHUD showHUDAddedTo:MLTopView animated:YES];
    hud.mode = MLProgressHUDModeText;
    hud.label.text = NSLocalizedString(text, @"HUD loading title");
    [hud hideAnimated:YES afterDelay:1.5f];
    return hud;
}

+ (BOOL)hide {
    MLProgressHUD *hud = [self HUDForView:MLTopView];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
        return YES;
    }
    return NO;
}


@end

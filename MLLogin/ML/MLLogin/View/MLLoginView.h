//
//  MLLoginView.h
//  GameProject
//
//  Created by shark on 2021/9/5.
//

#import "MLBaseAccountView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLLoginView : MLBaseAccountView

- (void)layouFrame;

/// 苹果登陆回调
@property (copy, nonatomic) void(^appleBlock)(ASAuthorization *authorization,NSString *user, NSError *err)API_AVAILABLE(ios(13.0)); 

@end

NS_ASSUME_NONNULL_END

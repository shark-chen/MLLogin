//
//  MLPresentation.m
//  GameProject
//
//  Created by shark on 2021/9/3.
//

#import "MLPresentation.h"
#import "MLScreen.h"

@interface MLPresentation ()

@property(nonatomic, strong)UIView *effectView;

@end

@implementation MLPresentation

/**
 即将弹出presentview时
 */
- (void)presentationTransitionWillBegin {
    _effectView = [[UIVisualEffectView alloc]init];
    _effectView.frame = self.containerView.bounds;
    _effectView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self.containerView addSubview:_effectView];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [_effectView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    _effectView.alpha = 0;
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_effectView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    self.presentedView.frame = [UIScreen mainScreen].bounds;
    return self.presentedView.frame;
}

@end

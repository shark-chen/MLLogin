//
//  HLLTransitioning.m
//  GameProject
//
//  Created by shark on 2021/9/3.
//

#import "HLLTransitioning.h"
#import "MLScreen.h"

@implementation HLLTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (fromVC.navigationController) {
        UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *contentView = [transitionContext containerView];
        [contentView addSubview:toVC.view];
        [contentView addSubview:fromVC.view];
    }

    UIView * fromView = fromVC.view;
    NSTimeInterval duration = 0.5;
    CGRect parentRectB = CGRectMake(MLScreenWidthL * 0.5 - 15, MLScreenHeightL * 0.5 - 15 , 30, 30);
    
    [UIView animateWithDuration:duration animations:^{
        fromView.transform = CGAffineTransformScale(fromView.transform, 0.05, 0.05);
        fromView.alpha = 0.2;
        fromView.center = CGPointMake(parentRectB.origin.x + 18, parentRectB.origin.y + 10);
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end

//
//  SQSquareTransition.m
//  animationSamples
//
//  Created by ToothBond on 2017/6/17.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQSquareTransition.h"

@implementation SQSquareTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    CGFloat kScreenWidth = containerView.frame.size.width;
    CGFloat kScreenHeight = containerView.frame.size.height;
    CGRect centerImgFrame = CGRectMake(0, (kScreenHeight - kScreenWidth)/2, kScreenWidth, kScreenWidth);
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //此处判断是push，还是pop 操作
    BOOL isPush = ([toViewController.navigationController.viewControllers indexOfObject:toViewController] > [fromViewController.navigationController.viewControllers indexOfObject:fromViewController]);
    
    UIView *transitionBg = [[UIView alloc] initWithFrame:containerView.bounds];
    transitionBg.backgroundColor = [UIColor blackColor];

    if (isPush) {
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        
        transitionBg.alpha = 0;
        self.transitionView.frame = self.startFrame;
        toView.hidden = YES;
        
    }else{
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        transitionBg.alpha = 1;
        self.transitionView.frame = centerImgFrame;
        fromView.hidden = YES;
    }
    [containerView addSubview:transitionBg];
    [containerView addSubview:self.transitionView];
    
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (isPush) {
            self.transitionView.frame = centerImgFrame;
            transitionBg.alpha = 1;
        }else{
            self.transitionView.frame = self.startFrame;
            transitionBg.alpha = 0;
        }
    } completion:^(BOOL finished) {
        
        [self.transitionView removeFromSuperview];
        [transitionBg removeFromSuperview];
        if (isPush) {
            toView.hidden = NO;
        }else{
            fromView.hidden = NO;
        }
        
        //设置transitionContext通知系统动画执行完毕
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end

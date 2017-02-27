//
//  SQBubbleTransition.m
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQBubbleTransition.h"

@interface SQBubbleTransition()

@property(nonatomic,strong)UIView *bubble;

@end

@implementation SQBubbleTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *contanerView = [transitionContext containerView];
    CGFloat width = contanerView.bounds.size.width;
    CGFloat height = contanerView.bounds.size.height;
    CGFloat radius;
    
    if (self.startPoint.x > width/2) {
        if (self.startPoint.y < height/2) {
            radius = sqrtf((self.startPoint.x * self.startPoint.x) + (height - self.startPoint.y) * (height - self.startPoint.y));
        }else{
            radius = sqrtf((self.startPoint.x * self.startPoint.x) + (self.startPoint.y * self.startPoint.y));
        }
    }else{
        if (self.startPoint.y < height/2) {
            radius = sqrtf(((width- self.startPoint.x) * (width- self.startPoint.x)) + (height - self.startPoint.y) * (height - self.startPoint.y));
        }else{
            radius = sqrtf((width - self.startPoint.x) * (width - self.startPoint.x) + self.startPoint.y * self.startPoint.y);
        }
    }
    
    CGSize size = CGSizeMake(radius*2, radius*2);
    self.bubble = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.bubble.center = self.startPoint;
    self.bubble.layer.cornerRadius = radius;
    self.bubble.backgroundColor = self.bubbleColor;
    
    if (self.transitionMode == Present) {
        //设置初始状态center 和 缩放比例
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint originalCenter = toView.center;
        self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
        toView.center = self.startPoint;
        toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        toView.alpha = 0.0;
        _bubble.alpha = 1.0;
        
        [contanerView addSubview:_bubble];
        [contanerView addSubview:toView];
        //动画的过程 就是缩放比例复原，center复原
        [UIView animateWithDuration:self.duration animations:^{
            _bubble.transform = CGAffineTransformIdentity;
            toView.transform = CGAffineTransformIdentity;
            toView.alpha = 1.0;
            toView.center = originalCenter;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _bubble.alpha = 0.0;
            } completion:^(BOOL finished) {
                [_bubble removeFromSuperview];
                //通知系统动画结束
                [transitionContext completeTransition:YES];
                
            }];
        }];
    }else{
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        [contanerView addSubview:toView];
        [contanerView addSubview:self.bubble];
        [contanerView addSubview:fromView];
        [UIView animateWithDuration:self.duration animations:^{
            self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            fromView.center = self.startPoint;
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [self.bubble removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    
    
}

@end

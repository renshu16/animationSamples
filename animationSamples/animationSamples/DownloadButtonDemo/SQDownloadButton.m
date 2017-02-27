//
//  SQDownloadButton.m
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQDownloadButton.h"

@interface SQDownloadButton()<CAAnimationDelegate>

@end

@implementation SQDownloadButton
{
    BOOL  animating;
    CGRect originframe;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSomething];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpSomething];
    }
    return self;
}

- (void)setUpSomething
{
    self.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
    
    UIGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGes];
}

- (void)tapped:(UITapGestureRecognizer *)ges
{
    originframe = self.frame;
    
    if (animating == YES) {
        return;
    }
    
    for (CALayer *subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    self.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    animating = YES;
    self.layer.cornerRadius = self.progressBarHeight/2;
    
    CABasicAnimation *radiusShrinkAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusShrinkAnimation.duration = 0.2f;
    radiusShrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    radiusShrinkAnimation.fromValue = @(originframe.size.height/2);
    
    //不设置toValue，只需要监听动画开始的代理，动画的过程用UIView的animate方法，可以实现弹性效果
    
    radiusShrinkAnimation.delegate = self;
    [self.layer addAnimation:radiusShrinkAnimation forKey:@"cornerRadiusShrinkAnim"];
    
}

- (void)progressBarAnimation
{
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.progressBarHeight/2, self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - self.progressBarHeight/2, self.bounds.size.height/2)];
    
    progressLayer.path = path.CGPath;
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressLayer.lineWidth = self.progressBarHeight - 6;
    progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:progressLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.delegate = self;
    //kvc，用于区分代理方法中的动画实例
    [pathAnimation setValue:@"progressBarAnimation" forKey:@"animationName"];
    [progressLayer addAnimation:pathAnimation forKey:nil];
}

- (void)checkAnimation
{
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isEqual:[self.layer animationForKey:@"cornerRadiusShrinkAnim"]]) {
        [UIView animateWithDuration:0.6f
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.bounds = CGRectMake(0, 0, self.progressBarWidth, self.progressBarHeight);
                         } completion:^(BOOL finished) {
                             [self.layer removeAllAnimations];
                             [self progressBarAnimation];
                         }];
    }
    else if([anim isEqual:[self.layer animationForKey:@"cornerRadiusExpandAnim"]]){
        [UIView animateWithDuration:0.8
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.bounds = originframe;
                             self.backgroundColor = [UIColor colorWithRed:0.1803921568627451 green:0.8 blue:0.44313725490196076 alpha:1.0];
                         } completion:^(BOOL finished) {
                             [self.layer removeFromSuperlayer];
                             [self checkAnimation];
                         }];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"progressBarAnimation"]) {
        
        [UIView animateWithDuration:0.3 animations:^{
            for (CALayer *layer in self.layer.sublayers) {
                layer.opacity = 0.0f;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                for (CALayer *layer in self.layer.sublayers) {
                    [layer removeFromSuperlayer];
                }
                
                //设置动画结束后的状态
                self.layer.cornerRadius = originframe.size.width/2;
                
                CABasicAnimation *radiusExpandAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                radiusExpandAnimation.duration = 0.2f;
                radiusExpandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                radiusExpandAnimation.fromValue = @(self.progressBarHeight/2);
                //不设置toValue
                radiusExpandAnimation.delegate = self;
                [self.layer addAnimation:radiusExpandAnimation forKey:@"cornerRadiusExpandAnim"];
                

            }
        }];
        

    }
}

@end

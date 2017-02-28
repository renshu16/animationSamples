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
    //设置CAShapeLayer的path属性，控制strokeEnd属性动画
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat insetRectInCircle = (1-sqrtf(2.0)/2)*self.frame.size.width/2;
    CGRect rectInCircle = CGRectInset(self.bounds, insetRectInCircle, insetRectInCircle);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9, rectInCircle.origin.y + rectInCircle.size.height*2/3)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3,rectInCircle.origin.y + rectInCircle.size.height*9/10)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/10, rectInCircle.origin.y + rectInCircle.size.height*2/10)];
    
    checkLayer.path = path.CGPath;
    checkLayer.lineWidth = 10.0f;
    checkLayer.lineCap = kCALineCapRound;
    //path线段交点渲染模式
    checkLayer.lineJoin = kCALineJoinRound;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.3;
    checkAnimation.fromValue = @0;
    checkAnimation.toValue = @1;
    checkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
    
    //同时控制 strokeStart 和 strokeEnd
//    CABasicAnimation *checkAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    checkAnimation2.beginTime = CACurrentMediaTime() + 0.1;
//    checkAnimation2.duration = 0.3;
//    checkAnimation2.fromValue = @0;
//    checkAnimation2.toValue = @1;
//    checkAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    checkAnimation2.delegate = self;
//    checkAnimation2.fillMode = kCAFillModeForwards;
//    checkAnimation2.removedOnCompletion = NO;
//    [checkAnimation2 setValue:@"checkAnimation2" forKey:@"animationName"];
//    [checkLayer addAnimation:checkAnimation2 forKey:nil];
    
    
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
                             [self.layer removeAllAnimations];
                             [self checkAnimation];
                             animating = NO;
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

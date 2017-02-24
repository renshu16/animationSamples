//
//  SplashAnimationDemoController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/24.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SplashAnimationDemoController.h"

@interface SplashAnimationDemoController ()

@end

@implementation SplashAnimationDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_demo"]];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
    maskLayer.position = image.center;
    maskLayer.bounds = CGRectMake(0, 0, 60, 60);
    image.layer.mask = maskLayer;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    CGRect value1 = CGRectMake(0, 0, 60, 60);
    CGRect value2 = CGRectMake(0, 0, 50, 50);
    CGRect value3 = CGRectMake(0, 0, 2000, 2000);
    
    animation.values = @[[NSValue valueWithCGRect:value1],[NSValue valueWithCGRect:value2],[NSValue valueWithCGRect:value3]];
    animation.duration = 1;
    animation.beginTime = CACurrentMediaTime() + 1;
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [image.layer.mask addAnimation:animation forKey:@"maskAnimation"];
    
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

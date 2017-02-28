//
//  InteractiveView.m
//  animationSamples
//
//  Created by ToothBond on 17/2/28.
//  Copyright © 2017年 rensq. All rights reserved.
//

#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height
#define ANIMATEDURATION 0.5
#define ANIMATEDAMPING  0.6
#define SCROLLDISTANCE  200.0

#import "InteractiveView.h"

@implementation InteractiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.layer.cornerRadius = 7;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setGestureView:(UIView *)gestureView
{
    _gestureView = gestureView;
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [gestureView addGestureRecognizer:ges];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)ges
{
    static CGPoint initialPoint;
    CGFloat factorOfAngle = 0;
    CGFloat factorOfScale = 0;
    CGPoint transition = [ges translationInView:self.superview];
    
    if (ges.state == UIGestureRecognizerStateBegan) {
        initialPoint = self.center;
    }else if(ges.state == UIGestureRecognizerStateChanged){
        self.center = CGPointMake(initialPoint.x, initialPoint.y + transition.y);
    }
}

@end

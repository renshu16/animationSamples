//
//  SQCurveView.m
//  animationSamples
//
//  Created by rensq on 2017/2/28.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQCurveView.h"
#import "SQCurveLayer.h"

@interface SQCurveView()

@property(nonatomic,strong)SQCurveLayer *curveLayer;

@end

@implementation SQCurveView

+ (Class)layerClass
{
    return [SQCurveLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    self.curveLayer.progress = progress;
    [self.curveLayer setNeedsDisplay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.curveLayer = [SQCurveLayer layer];
    self.curveLayer.frame = self.bounds;
    self.curveLayer.contentsScale = [UIScreen mainScreen].scale;
    self.curveLayer.progress = 0.0;
    [self.curveLayer setNeedsDisplay];
    [self.layer addSublayer:self.curveLayer];
}


@end

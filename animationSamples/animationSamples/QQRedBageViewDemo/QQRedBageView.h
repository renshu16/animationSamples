//
//  QQRedBageView.h
//  animationSamples
//
//  Created by ToothBond on 17/2/24.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQRedBageView : UIView

@property(nonatomic,strong)UIView *containerView;

@property(nonatomic,strong)UILabel *bubbleLabel;

@property(nonatomic,assign)CGFloat bubbleWidth;

//气泡粘性系数，越大可以拉得越长
@property(nonatomic,assign)CGFloat viscosity;

@property(nonatomic,strong)UIColor *bubbleColor;

@property(nonatomic,strong)UIView *frontView;

- (instancetype)initWithPoint:(CGPoint )point superView:(UIView *)view;

- (void)setup;

@end

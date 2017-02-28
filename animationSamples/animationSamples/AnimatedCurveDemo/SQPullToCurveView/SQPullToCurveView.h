//
//  SQPullToCurveView.h
//  animationSamples
//
//  Created by ToothBond on 17/2/28.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQPullToCurveView : UIView

@property(nonatomic,assign)CGFloat pullDistance;

-(instancetype)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar;

- (id)iniWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar;

- (void)triggerPulling;

- (void)stopRefreshing;

- (void)addRefreshingBlock:(void (^)(void))block;

@end

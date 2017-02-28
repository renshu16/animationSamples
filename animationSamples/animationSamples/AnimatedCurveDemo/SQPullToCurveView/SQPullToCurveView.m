//
//  SQPullToCurveView.m
//  animationSamples
//
//  Created by ToothBond on 17/2/28.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQPullToCurveView.h"
#import "UIView+Convenient.h"

@interface SQPullToCurveView()
{
    UILabel *labelView;
    UIView *curveView;
    CGFloat originOffset;
    BOOL willEnd;
    BOOL notTracking;
    BOOL loading;
}

@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,weak)UIScrollView *associatedScrollView;
@property(nonatomic,copy)void(^refreshingBlock) (void);

@end

@implementation SQPullToCurveView

-(instancetype)initWithAssociatedScrollView:(UIScrollView *)scrollView withNavigationBar:(BOOL)navBar
{
    self = [super initWithFrame:CGRectMake(scrollView.width/2-200/2, -100, 200, 100)];
    if (self) {
        if (navBar) {
            originOffset = 64.0f;
        }else{
            originOffset = 0.0f;
        }
        self.associatedScrollView = scrollView;
        [self setUp];
        [self.associatedScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self.associatedScrollView insertSubview:self atIndex:0];
        
    }
    return self;
}

- (void)setUp
{
    self.pullDistance = 99;
    curveView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 30, self.height)];
    [self insertSubview:curveView atIndex:0];
    
    labelView = [[UILabel alloc] initWithFrame:CGRectMake(curveView.right + 10, curveView.y, 150, curveView.height)];
    [self insertSubview:labelView atIndex:0];
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    NSLog(@"progress = %f",progress);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
//        NSLog(@"contentOffset %@",NSStringFromCGPoint(contentOffset));
        if (contentOffset.y + originOffset <= 0) {
            self.progress = MAX(MIN(fabs(contentOffset.y + originOffset)/self.pullDistance, 1.0), 0);
        }
    }
}

- (void)dealloc
{
    [self.associatedScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end

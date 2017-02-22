//
//  GooeySlideMenu.m
//  animationSamples
//
//  Created by ToothBond on 17/2/22.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "GooeySlideMenu.h"
#import "SlideMenuButton.h"

#define EXTRAAREA 50
#define kButtonSpace    30
#define kButtonH        40

@interface GooeySlideMenu()

@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,assign)NSInteger animationCount;

@end

@implementation GooeySlideMenu {
    UIWindow *keyWindow;
    BOOL triggered;
    UIView *helperCenterView;
    UIView *helperSideView;
    UIVisualEffectView *blurView;
    CGFloat diff;
    UIColor *_menuColor;
    
    CGFloat menuWidth;
    CGFloat menuHeight;
}

- (instancetype)initWithTitles:(NSArray *)titles withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style
{
    self = [super init];
    if (self) {
        keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
        blurView.frame = keyWindow.frame;
        blurView.alpha = 0.0f;
        
        helperSideView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
        helperSideView.backgroundColor = [UIColor redColor];
        helperSideView.hidden = YES;
        [keyWindow addSubview:helperSideView];
        
        helperCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, CGRectGetHeight(keyWindow.frame)/2 - 20, 40, 40)];
        helperCenterView.backgroundColor = [UIColor yellowColor];
        helperCenterView.hidden = YES;
        [keyWindow addSubview:helperCenterView];
        
        _menuColor = menuColor;
        
        menuWidth = keyWindow.frame.size.width/2 + EXTRAAREA;
        menuHeight = keyWindow.frame.size.height;
        self.frame = CGRectMake(-menuWidth, 0, menuWidth, menuHeight);
        self.backgroundColor = [UIColor clearColor];
        [keyWindow insertSubview:self belowSubview:helperSideView];
        
        [self addButtons:titles];
        
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles
{
    return [self initWithTitles:titles withMenuColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1] withBackBlurStyle:UIBlurEffectStyleDark];
}

- (void)addButtons:(NSArray *)titles
{
    CGFloat btnLeftP = 20;
    CGFloat btnWidth = keyWindow.frame.size.width/2 - 2*btnLeftP;
    CGFloat btnTotalH = titles.count * kButtonH + (titles.count -1)*kButtonSpace;
    CGFloat startY = (menuHeight - btnTotalH)/2;
    
    for (int i=0; i<titles.count; i++) {
        NSString *title = titles[i];
        SlideMenuButton *button = [[SlideMenuButton alloc] initWithTitle:title];
        button.buttonColor = _menuColor;
        button.frame = CGRectMake(btnLeftP, startY, btnWidth, kButtonH);
        [self addSubview:button];
        startY += (kButtonH + kButtonSpace);
        
        __weak typeof (self)WeakSelf = self;
        button.buttonClickBlock = ^(){
            [WeakSelf topToUntrigger:nil];
            if (WeakSelf.menuClickBlock) {
                WeakSelf.menuClickBlock(i,title,titles.count);
            }
        };
    }
}

// 调用setNeedsDisplay触发此方法
- (void)drawRect:(CGRect)rect
{
    //创建BezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - EXTRAAREA, 0)];
    //Bezier曲线
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - EXTRAAREA, self.frame.size.height) controlPoint:CGPointMake(keyWindow.frame.size.width/2 + diff, keyWindow.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    //曲线封闭
    [path closePath];
    
    //获取context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加path
    CGContextAddPath(context, path.CGPath);
    //设置边框和填充颜色
    [_menuColor set];
    //绘制
    CGContextFillPath(context);
}

- (void)trigger
{
    if (!triggered) {
        [keyWindow insertSubview:blurView belowSubview:self];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.bounds;
            blurView.alpha = 1.0f;
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7
                              delay:0
             usingSpringWithDamping:0.5 //弹性阻尼
              initialSpringVelocity:0.9 //初始速度
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             helperSideView.center = CGPointMake(CGRectGetMidX(keyWindow.frame), 20);
                         } completion:^(BOOL finished) {
                             [self afterAnimation];
                         }];
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:2.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             helperCenterView.center = CGPointMake(CGRectGetMidX(keyWindow.frame), CGRectGetMidY(keyWindow.frame));
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topToUntrigger:)];
                                 [blurView addGestureRecognizer:tapGes];
                                 [self afterAnimation];
                             }
                         }];
        
        triggered = YES;
        
        [self animateButtons];
    }else{
        [self topToUntrigger:nil];
    }
}

- (void)topToUntrigger:(UITapGestureRecognizer *)ges
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(-menuWidth, 0, menuWidth, menuHeight);
        blurView.alpha = 0.0f;
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.9
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         helperSideView.center = CGPointMake(-20, 20);
                     } completion:^(BOOL finished) {
                         [self afterAnimation];
                     }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:2
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         helperCenterView.center = CGPointMake(-20, CGRectGetMidY(keyWindow.frame));
                     } completion:^(BOOL finished) {
                         [self afterAnimation];
                     }];
    
    triggered = NO;
}

- (void)animateButtons
{
    NSInteger count = self.subviews.count;
    for (int i=0; i<count; i++) {
        UIView *button = self.subviews[i];
        CGFloat btnWidth = button.frame.size.width;
        CGPoint btnCenter = button.center;
        button.center = CGPointMake(btnCenter.x - btnWidth, btnCenter.y);
        
        [UIView animateWithDuration:0.7
                              delay:i*(0.3/count)
             usingSpringWithDamping:0.6
              initialSpringVelocity:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             button.center = btnCenter;
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}

- (void)onDisplayLinkAction:(CADisplayLink *)display
{
    CALayer *sideHelperPresentationLayer = (CALayer *)[helperSideView.layer presentationLayer];
    CALayer *centerHelperPresentationLayer = (CALayer *)[helperCenterView.layer presentationLayer];
    
    CGRect centerRect = [[centerHelperPresentationLayer valueForKey:@"frame"] CGRectValue];
    CGRect sideRect = [[sideHelperPresentationLayer valueForKey:@"frame"] CGRectValue];
    
    diff = sideRect.origin.x - centerRect.origin.x;
    NSLog(@"diff:%f",diff);
    
    [self setNeedsDisplay];
}

- (void)beforeAnimation{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    self.animationCount ++;
}

- (void)afterAnimation
{
    self.animationCount --;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

@end

//
//  PingTransitionDemoController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "PingTransitionDemoController.h"
#import "PingSecondController.h"
#import "SQBubbleTransition.h"

#define color_random            [UIColor colorWithRed:(arc4random() % 256 / 255.0) green:(arc4random() % 256 / 255.0) blue:(arc4random() % 256 / 255.0) alpha:1.0f]

@interface PingTransitionDemoController ()<UINavigationControllerDelegate>

@end

@implementation PingTransitionDemoController
{
    UIButton *currentBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page1"]];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
    
    CGFloat startY = 200;
    for (int i=0; i<3; i++) {
        UIButton *btn = [self createButton];
        btn.center = CGPointMake(self.view.center.x, startY + i*150);
        btn.backgroundColor = color_random;
        [self.view addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id <UIViewControllerAnimatedTransitioning> )navigationController:(UINavigationController *)navigationController
                                    animationControllerForOperation:(UINavigationControllerOperation)operation
                                                 fromViewController:(UIViewController *)fromVC
                                                   toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        SQBubbleTransition *bubTran = [[SQBubbleTransition alloc] init];
        bubTran.startPoint = currentBtn.center;
        bubTran.bubbleColor = currentBtn.backgroundColor;
        bubTran.duration = 0.25;
        bubTran.transitionMode = Present;
        return bubTran;
    }else{
        return nil;
    }
}

- (void)onBtnAction:(UIButton *)btn
{
    currentBtn = btn;
    PingSecondController *secondVC = [[PingSecondController alloc] init];
    secondVC.orginalBtn = currentBtn;
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (UIButton *)createButton
{
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundColor:[UIColor whiteColor]];
    CGFloat btnW = 80;
    _button.bounds = CGRectMake(0, 0, btnW, btnW);
    _button.layer.cornerRadius = btnW/2;
    _button.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [_button addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _button;
}

@end

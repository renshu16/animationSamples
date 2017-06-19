//
//  PingSecondController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "PingSecondController.h"
#import "SQBubbleTransition.h"
#import "SQSquareTransition.h"

@interface PingSecondController ()<UINavigationControllerDelegate>

@end

@implementation PingSecondController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page2"]];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
//        SQBubbleTransition *bubTran = [[SQBubbleTransition alloc] init];
//        bubTran.startPoint = self.orginalBtn.center;
//        bubTran.bubbleColor = self.orginalBtn.backgroundColor;
//        bubTran.duration = 1.25;
//        bubTran.transitionMode = Dismiss;
//        return bubTran;
        
        SQSquareTransition *sqTran = [[SQSquareTransition alloc] init];
        sqTran.startFrame = self.orginalBtn.frame;
        sqTran.isPresenting = NO;
        return sqTran;
        
    }else{
        return nil;
    }
}

@end

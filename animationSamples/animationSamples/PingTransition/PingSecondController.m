//
//  PingSecondController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "PingSecondController.h"
#import "SQBubbleTransition.h"

@interface PingSecondController ()<UINavigationControllerDelegate>

@end

@implementation PingSecondController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page2"]];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        SQBubbleTransition *bubTran = [[SQBubbleTransition alloc] init];
        bubTran.startPoint = self.orginalBtn.center;
        bubTran.bubbleColor = self.orginalBtn.backgroundColor;
        bubTran.duration = 0.25;
        bubTran.transitionMode = Dismiss;
        return bubTran;
    }else{
        return nil;
    }
}

@end

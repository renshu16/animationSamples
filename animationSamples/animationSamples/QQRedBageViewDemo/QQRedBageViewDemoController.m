//
//  QQRedBageViewDemoController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/24.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "QQRedBageViewDemoController.h"

#import "QQRedBageView.h"

@interface QQRedBageViewDemoController ()

@end

@implementation QQRedBageViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    QQRedBageView *bageView = [[QQRedBageView alloc] initWithPoint:CGPointMake(self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.8) superView:self.view];
    bageView.viscosity = 20;
    bageView.bubbleColor = [UIColor redColor];
    bageView.bubbleWidth = 38;
    [bageView setup];
    bageView.bubbleLabel.text = @"99+";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

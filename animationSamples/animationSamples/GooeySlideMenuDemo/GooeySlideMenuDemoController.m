//
//  GooeySlideMenuDemoController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/22.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "GooeySlideMenuDemoController.h"
#import "GooeySlideMenu.h"

@interface GooeySlideMenuDemoController ()

@end

@implementation GooeySlideMenuDemoController{
    GooeySlideMenu *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    menu = [[GooeySlideMenu alloc] initWithTitles:@[@"1",@"2",@"3",@"4",@"5",@"6"]];
    
    UIButton *triggerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    triggerBtn.frame = CGRectMake(width * 0.8, height * 0.8, 80, 40);
    [triggerBtn setTitle:@"trigger" forState:UIControlStateNormal];
    [triggerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [triggerBtn addTarget:self action:@selector(triggerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:triggerBtn];
    
}

- (void)triggerAction:(UIButton *)btn
{
    [menu trigger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

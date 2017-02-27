//
//  DownloadButtonDemoController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "DownloadButtonDemoController.h"
#import "SQDownloadButton.h"

@interface DownloadButtonDemoController ()

@end

@implementation DownloadButtonDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    SQDownloadButton *btn = [[SQDownloadButton alloc] initWithFrame:CGRectMake(150, 200, 80, 80)];
    btn.progressBarHeight = 30;
    btn.progressBarWidth = 200;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

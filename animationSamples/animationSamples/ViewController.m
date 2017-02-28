//
//  ViewController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/22.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,copy)NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataList = @[@"GooeySlideMenuDemoController",
                  @"QQRedBageViewDemoController",
                  @"SplashAnimationDemoController",
                  @"PingTransitionDemoController",
                  @"JumpStarViewDemoController",
                  @"DownloadButtonDemoController",
                  @"InteractiveViewDemoController",
                  @"AnimatedCurveDemoController"];
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *controllerName = self.dataList[indexPath.row];
    id vc = [[NSClassFromString(controllerName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

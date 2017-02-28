//
//  AnimatedCurveDemoController.m
//  animationSamples
//
//  Created by ToothBond on 17/2/28.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "AnimatedCurveDemoController.h"
#import "SQPullToCurveView.h"

#define initialOffset 50.0
#define targetHeight 500.0

@interface AnimatedCurveDemoController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTable;

@end

@implementation AnimatedCurveDemoController
{
    UILabel *navTitle;
    UIView *bkView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTable];
    
    bkView = [[UIView alloc] init];
    bkView.center = CGPointMake(self.view.center.x, 22);
    bkView.bounds = CGRectMake(0, 0, 250, 44);
    bkView.clipsToBounds = YES;
    [self.navigationController.navigationBar addSubview:bkView];
    
    navTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 44+initialOffset, bkView.bounds.size.width, 44)];
    navTitle.alpha = 0;
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor blackColor];
    navTitle.text = @"Fade in/out navbar title";
    [bkView addSubview:navTitle];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SQPullToCurveView *headerView = [[SQPullToCurveView alloc]initWithAssociatedScrollView:self.mainTable withNavigationBar:YES];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat transitionY =  MIN(MAX(0, scrollView.contentOffset.y + 64), 44+initialOffset+targetHeight);
    if (transitionY <= initialOffset) {
        navTitle.frame = CGRectMake(0, 44+initialOffset-transitionY, bkView.bounds.size.width, 44);
    }else{
        CGFloat factor = MAX(0, MIN(1, (transitionY-initialOffset)/targetHeight));
        navTitle.frame = CGRectMake(0, 44-factor*44,bkView.frame.size.width , 44);
        navTitle.alpha = factor*factor*1;
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    return cell;
}

- (UITableView *)mainTable
{
    if (_mainTable == nil){
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _mainTable;
}

@end

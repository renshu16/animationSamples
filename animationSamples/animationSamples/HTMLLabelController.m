//
//  HTMLLabelController.m
//  animationSamples
//
//  Created by ToothBond on 2017/6/14.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "HTMLLabelController.h"

@interface HTMLLabelController ()

@end

@implementation HTMLLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString *htmlStr = @"<div class=\"conterText\">\r\n\t<h3>\r\n\t\t对公账户\r\n\t</h3>\r\n\t<p>\r\n\t\t账户名称：深圳市爱牙邦医疗有限公司\r\n\t</p>\r\n\t<p>\r\n\t\t开户银行：中国银行深圳松日鼎盛支行\r\n\t</p>\r\n\t<p>\r\n\t\t账 号：758864786949\r\n\t</p>\r\n</div>";
    
//    NSString *htmlStr = @"<div class=\"conterText\"><p>对公账户</p><p>账户名称：深圳市爱牙邦医疗有限公司</p><p>开户银行：中国银行深圳松日鼎盛支行</p><p>账号：758864786949</p></div>";
    UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 300, 300)];
    label.numberOfLines = 0;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    label.attributedText = attrStr;
    
    [self.view addSubview:label];
}


@end

//
//  CrashController.m
//  animationSamples
//
//  Created by ToothBond on 2017/6/20.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "CrashController.h"


@interface CrashController ()

@end

@implementation CrashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self crashDemo1];
    
    [self catchCrashDemo];
}

- (void)catchCrashDemo
{
    
//    for (int i=-1; i<100; i++) {
//        [self testDict:i quantity:i];
//    }

    [self testDict:nil quantity:NULL];
}

- (void)testDict:(int)ids quantity:(int)quantity
{
    
    NSDictionary * requestDictionary = @{@"id":[NSNumber numberWithInteger:ids]};
//    NSDictionary * requestDictionary = @{@"productPackage" : @(ids),
//                                         @"quantity" : @(quantity),
//                                         @"isProductPackage" : @"true"};
    
    NSLog(@"%@",[requestDictionary description]);
}

- (void)crashDemo1
{

    NSString *exceptionName = @"自定义异常";
    NSString *exceptionReson = @"长期下雨导致硬件发霉了";
    NSDictionary *exceptionUserInfo = nil;
    
    NSException *exception = [NSException exceptionWithName:exceptionName
                                                     reason:exceptionReson
                                                   userInfo:exceptionUserInfo];
    
    int i = 0;
    if (i == 0) {
        @throw exception;
    }
}


@end

//
//  SQSquareTransition.h
//  animationSamples
//
//  Created by ToothBond on 2017/6/17.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQSquareTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,strong)UIView *transitionView;

@property(nonatomic,assign)CGRect startFrame;

@property(nonatomic,assign)BOOL isPresenting;

@end

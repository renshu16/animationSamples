//
//  SQBubbleTransition.h
//  animationSamples
//
//  Created by ToothBond on 17/2/27.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum BubbleTransitionMode {
    Present,
    Dismiss
}BubbleTransitionMode;

@interface SQBubbleTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)CGFloat duration;

@property(nonatomic,assign)CGPoint startPoint;

@property(nonatomic,assign)BubbleTransitionMode transitionMode;

@property(nonatomic,strong)UIColor *bubbleColor;


@end

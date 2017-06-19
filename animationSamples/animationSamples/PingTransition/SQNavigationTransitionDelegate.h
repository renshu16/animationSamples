//
//  SQNavigationTransitionDelegate.h
//  animationSamples
//
//  Created by ToothBond on 2017/6/17.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQNavigationTransitionDelegate : NSObject<UINavigationControllerDelegate>

/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView;
/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame;

@end

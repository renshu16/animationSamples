//
//  SQNavigationTransitionDelegate.m
//  animationSamples
//
//  Created by ToothBond on 2017/6/17.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SQNavigationTransitionDelegate.h"
#import "SQSquareTransition.h"

@interface SQNavigationTransitionDelegate()

@property(nonatomic,strong)SQSquareTransition *squareTransion;

@end

@implementation SQNavigationTransitionDelegate

/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView{
    self.squareTransion.transitionView = transitionImgView;
}

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame{
    self.squareTransion.startFrame = frame;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return self.squareTransion;
        
    }else if (operation == UINavigationControllerOperationPop){
        return self.squareTransion;
    }
    return nil;
}

- (SQSquareTransition *)squareTransion{
    if (_squareTransion == nil) {
        _squareTransion = [[SQSquareTransition alloc]init];
    }
    return _squareTransion;
}

@end

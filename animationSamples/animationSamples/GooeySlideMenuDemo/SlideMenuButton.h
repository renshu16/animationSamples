//
//  SlideMenuButton.h
//  animationSamples
//
//  Created by ToothBond on 17/2/22.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuButton : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property(nonatomic,strong)UIColor *buttonColor;

@property(nonatomic,copy)void(^buttonClickBlock)(void);

@end

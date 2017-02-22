//
//  GooeySlideMenu.h
//  animationSamples
//
//  Created by ToothBond on 17/2/22.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuButtonClickedBlock) (NSInteger index,NSString *title,NSInteger titleCounts);

@interface GooeySlideMenu : UIView

- (instancetype)initWithTitles:(NSArray *)titles;

- (instancetype)initWithTitles:(NSArray *)titles withMenuColor:(UIColor *)menuColor withBackBlurStyle:(UIBlurEffectStyle)style;

- (void)trigger;

@property(nonatomic,assign)CGFloat menuButtonHeight;

@property(nonatomic,copy)MenuButtonClickedBlock menuClickBlock;

@end

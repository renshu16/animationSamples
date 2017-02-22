//
//  SlideMenuButton.m
//  animationSamples
//
//  Created by ToothBond on 17/2/22.
//  Copyright © 2017年 rensq. All rights reserved.
//

#import "SlideMenuButton.h"

@interface SlideMenuButton()

@property (nonatomic,copy)NSString *buttonTitle;

@end

@implementation SlideMenuButton

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.buttonTitle = title;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    [self.buttonColor set];
    CGContextFillPath(context);
    
    //圆角矩形
    UIBezierPath *roundedRectAnglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:rect.size.height/2];;
    [self.buttonColor setFill];
    [roundedRectAnglePath fill];
    [[UIColor whiteColor] setStroke];
    roundedRectAnglePath.lineWidth = 1;
    [roundedRectAnglePath stroke];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attr = @{NSParagraphStyleAttributeName:paragraphStyle,
                           NSFontAttributeName:[UIFont systemFontOfSize:24],
                           NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [self.buttonTitle sizeWithAttributes:attr];
    CGRect r = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - size.height)/2, rect.size.width, size.height);
    [self.buttonTitle drawInRect:r withAttributes:attr];
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;

    switch (tapCount) {
        case 1:
            if (self.buttonClickBlock) {
                self.buttonClickBlock();
            }
            break;
        default:
            break;
    }
}



@end

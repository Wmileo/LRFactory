//
//  UIView+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIView+LRFactory.h"
#import <objc/runtime.h>

@implementation UIView (LRFactory)

+(instancetype)lrf_view{
    return [[[self class] alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

+(instancetype)lrf_viewWithFrame:(CGRect)frame{
    return [[[self class] alloc] initWithFrame:frame];
}

+(instancetype)lrf_viewWithSize:(CGSize)size{
    UIView *ui = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    ui.lrf_size = size;
    return ui;
}

#pragma mark - setup

static char keyFiexedType;
static char keyFiexedPoint;
-(void)lrf_setupFixedType:(FixedPointType)type point:(CGPoint)point{
    objc_setAssociatedObject(self, &keyFiexedType, @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyFiexedPoint, [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self fixPoint];
}

-(void)fixPoint{
    FixedPointType type = [objc_getAssociatedObject(self, &keyFiexedType) integerValue];
    CGPoint point = [objc_getAssociatedObject(self, &keyFiexedPoint) CGPointValue];
    if (type == Fixed_Left_Top) {
        return;
    }
    CGPoint origin = CGPointMake(0, 0);
    CGSize size = self.lrf_size;
    switch (type) {
        case Fixed_Left_CenterY:
            origin.x = point.x;
            origin.y = point.y - size.height / 2;
            break;
        case Fixed_Left_Bottom:
            origin.x = point.x;
            origin.y = point.y - size.height;
            break;
        case Fixed_CenterX_Top:
            origin.x = point.x - size.width / 2;
            origin.y = point.y;
            break;
        case Fixed_CenterX_CenterY:
            origin.x = point.x - size.width / 2;
            origin.y = point.y - size.height / 2;
            break;
        case Fixed_CenterX_Bottom:
            origin.x = point.x - size.width / 2;
            origin.y = point.y - size.height;
            break;
        case Fixed_Right_Top:
            origin.x = point.x - size.width;
            origin.y = point.y;
            break;
        case Fixed_Right_CenterY:
            origin.x = point.x - size.width;
            origin.y = point.y - size.height / 2;
            break;
        case Fixed_Right_Bottom:
            origin.x = point.x - size.width;
            origin.y = point.y - size.height;
            break;
        default:
            break;
    }
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void)lrf_setupBorderWidth:(CGFloat)width color:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

-(void)lrf_setupCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


#pragma mark - set get

-(void)setLrf_size:(CGSize)lrf_size{
    CGRect frame = self.frame;
    frame.size = lrf_size;
    self.frame = frame;
    [self fixPoint];
}

-(CGSize)lrf_size{
    return self.frame.size;
}

-(CGFloat)lrf_width{
    return CGRectGetWidth(self.frame);
}

-(void)setLrf_width:(CGFloat)lrf_width{
    CGSize size = self.lrf_size;
    size.width = lrf_width;
    self.lrf_size = size;
}

-(CGFloat)lrf_height{
    return CGRectGetHeight(self.frame);
}

-(void)setLrf_height:(CGFloat)lrf_height{
    CGSize size = self.lrf_size;
    size.height = lrf_height;
    self.lrf_size = size;
}

-(CGPoint)lrf_boundsCenter{
    return CGPointMake(roundf(self.lrf_width / 2), roundf(self.lrf_height / 2));
}

@end

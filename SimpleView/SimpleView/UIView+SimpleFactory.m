//
//  UIView+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIView+SimpleFactory.h"

@implementation UIView (SimpleFactory)

+(instancetype)viewWithFrame:(CGRect)frame{
    return [[[self class] alloc] initWithFrame:frame];
}

-(instancetype)resetBackgroundColor:(UIColor *)color{
    self.backgroundColor = color;
    return self;
}

-(instancetype)resetTag:(NSInteger)tag{
    self.tag = tag;
    return self;
}

-(instancetype)setupOnView:(UIView *)view{
    [view addSubview:self];
    return self;
}

@end

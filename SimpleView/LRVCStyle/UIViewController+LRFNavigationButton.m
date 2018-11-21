//
//  UIViewController+LRFNavigationButton.m
//  SimpleView
//
//  Created by leo on 2018/11/19.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFNavigationButton.h"
#import "UIViewController+LRFactory.h"
#import "UIButton+LRFactory.h"
#import "UIView+LRFactory.h"
#import "NSString+LRFactory.h"
#import <objc/runtime.h>

#define LRF_Key_Button_Tag 88
#define LRF_Key_Button_Text_MaxWidth 80

@implementation UIViewController (LRFNavigationButton)

- (void)lrf_setupNavigationItemWithText:(NSString *)text side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_setupNavigationItemWithText:text color:self.lrf_navigationItemColor font:self.lrf_navigationItemFont side:side action:action];
}

- (void)lrf_addNavigationItemWithText:(NSString *)text side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_addNavigationItemWithText:text color:self.lrf_navigationItemColor font:self.lrf_navigationItemFont side:side action:action];
}

#pragma mark -

static char keyNavigationButtonColor;

- (void)setLrf_navigationItemColor:(UIColor *)lrf_navigationItemColor{
    objc_setAssociatedObject(self, &keyNavigationButtonColor, lrf_navigationItemColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)lrf_navigationItemColor{
    if (objc_getAssociatedObject(self, &keyNavigationButtonColor)) {
        return objc_getAssociatedObject(self, &keyNavigationButtonColor);
    }else{
        return [UIColor blackColor];
    }
}

static char keyNavigationButtonFont;

- (void)setLrf_navigationItemFont:(UIFont *)lrf_navigationItemFont{
    objc_setAssociatedObject(self, &keyNavigationButtonFont, lrf_navigationItemFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIFont *)lrf_navigationItemFont{
    if (objc_getAssociatedObject(self, &keyNavigationButtonFont)) {
        return objc_getAssociatedObject(self, &keyNavigationButtonFont);
    }else{
        return [UIFont systemFontOfSize:16];
    }
}

#pragma mark - back

- (void)lrf_fixNavigationBackButton{
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *button = [self lrf_backButton];
        [button lrf_handleEventTouchUpInsideBlock:self.lrf_navigationBackClick];
        [button lrf_setupNormalImage:self.lrf_navigationBackImage aligning:LRF_Image_Aligning_Left];
        [button lrf_setupNormalText:self.lrf_navigationBackTitle color:self.lrf_navigationBackColor font:self.lrf_navigationBackFont fitSize:YES];
        if (self.lrf_navigationBackImage && self.lrf_navigationBackTitle) {
            CGSize imgSize = self.lrf_navigationBackImage.size;
            CGSize tilSize = [self.lrf_navigationBackTitle lrf_sizeWithFont:self.lrf_navigationBackFont maxWidth:300];
            CGFloat width = imgSize.width + self.lrf_navigationBackGap + tilSize.width;
            CGFloat height = MAX(imgSize.height, tilSize.height);
            button.lrf_size = CGSizeMake(width, height);
            button.imageEdgeInsets = UIEdgeInsetsMake((height - imgSize.height) / 2, 0, (height - imgSize.height) / 2, self.lrf_navigationBackGap);
            button.titleEdgeInsets = UIEdgeInsetsMake((height - tilSize.height) / 2, 0, (height - tilSize.height) / 2, 0);
        }
    }
}


#pragma mark - back set get

static char keyNavigationBackColor;

- (void)setLrf_navigationBackColor:(UIColor *)lrf_navigationBackColor{
    objc_setAssociatedObject(self, &keyNavigationBackColor, lrf_navigationBackColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lrf_fixNavigationBackButton];
}

- (UIColor *)lrf_navigationBackColor{
    if (objc_getAssociatedObject(self, &keyNavigationBackColor)) {
        return objc_getAssociatedObject(self, &keyNavigationBackColor);
    }else{
        return [UIColor blackColor];
    }
}

static char keyNavigationBackFont;

- (void)setLrf_navigationBackFont:(UIFont *)lrf_navigationBackFont{
    objc_setAssociatedObject(self, &keyNavigationBackFont, lrf_navigationBackFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lrf_fixNavigationBackButton];
}

- (UIFont *)lrf_navigationBackFont{
    if (objc_getAssociatedObject(self, &keyNavigationBackFont)) {
        return objc_getAssociatedObject(self, &keyNavigationBackFont);
    }else{
        return [UIFont systemFontOfSize:16];
    }
}

static char keyNavigationBackImage;

- (void)setLrf_navigationBackImage:(UIImage *)lrf_navigationBackImage{
    objc_setAssociatedObject(self, &keyNavigationBackImage, lrf_navigationBackImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lrf_fixNavigationBackButton];
}

- (UIImage *)lrf_navigationBackImage{
    return objc_getAssociatedObject(self, &keyNavigationBackImage);
}

static char keyNavigationBackTitle;

- (void)setLrf_navigationBackTitle:(NSString *)lrf_navigationBackTitle{
    BOOL isCut = NO;
    while ([lrf_navigationBackTitle lrf_sizeWithFont:self.lrf_navigationBackFont maxWidth:300].width >= LRF_Key_Button_Text_MaxWidth) {
        isCut = YES;
        lrf_navigationBackTitle = [lrf_navigationBackTitle substringToIndex:lrf_navigationBackTitle.length - 1];
    }
    if (isCut) {
        lrf_navigationBackTitle = [lrf_navigationBackTitle stringByAppendingString:@"..."];
    }
    objc_setAssociatedObject(self, &keyNavigationBackTitle, lrf_navigationBackTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lrf_fixNavigationBackButton];
}

- (NSString *)lrf_navigationBackTitle{
    return objc_getAssociatedObject(self, &keyNavigationBackTitle);
}

static char keyNavigationBackGap;

- (void)setLrf_navigationBackGap:(CGFloat)lrf_navigationBackGap{
    objc_setAssociatedObject(self, &keyNavigationBackGap, @(lrf_navigationBackGap), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lrf_fixNavigationBackButton];
}

- (CGFloat)lrf_navigationBackGap{
    if (objc_getAssociatedObject(self, &keyNavigationBackGap)) {
        return [objc_getAssociatedObject(self, &keyNavigationBackGap) floatValue];
    }else{
        return 4;
    }
}

static char keyNavigationBackClick;

- (void)setLrf_navigationBackClick:(void (^)(void))lrf_navigationBackClick{
    objc_setAssociatedObject(self, &keyNavigationBackClick, lrf_navigationBackClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self lrf_fixNavigationBackButton];
}

- (void (^)(void))lrf_navigationBackClick{
    if (objc_getAssociatedObject(self, &keyNavigationBackClick)) {
        return objc_getAssociatedObject(self, &keyNavigationBackGap);
    }else{
        __weak typeof(self) wself = self;
        return ^(){
            __strong typeof(wself) sself = wself;
            [sself.navigationController popViewControllerAnimated:YES];
        };
    }
}

- (NSString *)lrf_navigationBackPrevTitle{
    return self.lrf_prevNavigationViewController.title;
}

- (UIButton *)lrf_backButton{
    __block UIButton *button;
    [self.lrf_navigationItemLeftViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == LRF_Key_Button_Tag) {
            button = (UIButton *)obj;
        }
    }];
    if (!button) {
        button = [UIButton lrf_viewWithFrame:CGRectMake(100, 100, 100, 100)];
        button.tag = LRF_Key_Button_Tag;
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self lrf_setupNavigationItemWithButton:button side:LRF_BarButtonItem_Side_Left];
    }
    return button;
}

@end



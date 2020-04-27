//
//  SLTabBar.m
//  SoulApp
//
//  Created by shiyu on 2020/4/15.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLTabBar.h"

@implementation SLTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundImage = [UIImage new];
        [self addSubview:self.plusButton];
    }
    return self;
}

# pragma mark - 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"hzl" forKey:@"name"];
    if (self.block) {
        self.block(dict);
    }
    
    // 设置中间按钮的位置
    self.plusButton.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.2);
    
    // 设置其他的按钮的位置
    CGFloat w = CGRectGetWidth(self.frame) / 5;
    CGFloat index = 0;
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
            childView.frame = CGRectMake(w * index, CGRectGetMinY(childView.frame), w, CGRectGetHeight(childView.frame));
            // 增加索引 要和中间的控件隔开
            index ++;
            if (index == 2) {
               index ++;
           }
        }
    }
}

# pragma mark - 重写hitTest方法以响应点击超出tabBar的加号按钮
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        }
        else {
            for (UIView *subview in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [subview convertPoint:point fromView:self];
                result = [subview hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}

- (void)respondsToPlusButton {
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.barDelegate tabBarDidClickPlusButton:self];
    }
}

- (UIButton *)plusButton {
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setTitle:@"发布" forState:UIControlStateNormal];
        _plusButton.titleLabel.textColor = KWhiteColor;
        _plusButton.backgroundColor = KGreenColor;
        _plusButton.frame = CGRectMake(0, 0, 60, 60);
        _plusButton.layer.cornerRadius = 30;
        [_plusButton addTarget:self action:@selector(respondsToPlusButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

@end

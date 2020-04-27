//
//  SLTabbar.h
//  SoulApp
//
//  Created by shiyu on 2020/4/15.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SLTabBar;

@protocol SLTabBarDelagate <UITabBarDelegate>

// 当点击自定义tabbar的时候
- (void)tabBarDidClickPlusButton:(SLTabBar *)tabBar;

@end


typedef void(^CustomTabBarBlock)(NSMutableDictionary* dict);


@interface SLTabBar : UITabBar

@property (nonatomic, strong) UIButton *plusButton;

@property (nonatomic, weak) id <SLTabBarDelagate> barDelegate;

@property (nonatomic, copy) CustomTabBarBlock block;

@end

NS_ASSUME_NONNULL_END

//
//  SLNavigationController.m
//  SoulApp
//
//  Created by shiyu on 2020/4/16.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLNavigationController.h"
#import "SLBaseViewController.h"

@interface SLNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation SLNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize
{
//    //导航栏主题 title文字属性
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    //导航栏背景图
//    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
//    [navBar setBarTintColor:CNavBgColor];
//    [navBar setTintColor:CNavBgFontColor];
//    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
//
//    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage new]];//去掉阴影线
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[SLBaseViewController class]]) {
        SLBaseViewController *vc = (SLBaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            vc.view.top = kTopHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

@end

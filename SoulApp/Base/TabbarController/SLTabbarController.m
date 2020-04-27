//
//  SLTabbarController.m
//  SoulApp
//
//  Created by shiyu on 2020/4/15.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLTabbarController.h"
#import <AudioToolbox/AudioToolbox.h>

#import "SLNavigationController.h"
#import "SLHomeViewController.h"
#import "SLSquareViewController.h"

#import "SLTabBar.h"

@interface SLTabbarController () <UITabBarControllerDelegate, SLTabBarDelagate>

@property (nonatomic, strong) SLTabBar *customTabBar;

@property (nonatomic, strong) NSMutableArray *VCS;

@end

@implementation SLTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    SLTabBar *tabBar = [[SLTabBar alloc] init];
    //取消tabBar的透明效果
    tabBar.translucent = NO;
    tabBar.barDelegate = self;
    
    [self setValue:tabBar forKey:@"tabBar"];
    
    self.customTabBar = tabBar;
    self.customTabBar.block = ^(NSMutableDictionary * _Nonnull dict) {
        NSLog(@"block = %@",dict);
    };
    
    [self setUpAllChildViewController];
    
}

- (void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
    
    SLHomeViewController *homeVC = [[SLHomeViewController alloc] init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"homePlanet" seleceImageName:@"homePlanetSe"];
    
    SLSquareViewController *squareVC = [[SLSquareViewController alloc] init];
    [self setupChildViewController:squareVC title:@"广场" imageName:@"homePlanet" seleceImageName:@"homePlanetSe"];
    
    SLHomeViewController *msgVC = [[SLHomeViewController alloc] init];
    [self setupChildViewController:msgVC title:@"消息" imageName:@"homePlanet" seleceImageName:@"homePlanetSe"];
    
    SLHomeViewController *mineVC = [[SLHomeViewController alloc] init];
    [self setupChildViewController:mineVC title:@"我的" imageName:@"homePlanet" seleceImageName:@"homePlanetSe"];
    
    self.viewControllers = _VCS;
}


-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName {
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(12.0f)} forState:UIControlStateNormal];
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KGreenColor,NSFontAttributeName:SYSTEMFONT(12.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:controller];
    [_VCS addObject:nav];
}


#pragma mark --SLTabBarDelegate--
- (void)tabBarDidClickPlusButton:(SLTabBar *)tabBar {
    /**
     definesPresentationContext这一属性决定了那个父控制器的View，
     将会以优先于UIModalPresentationCurrentContext这种呈现方式来展现自己的View。
     如果没有父控制器设置这一属性，那么展示的控制器将会是根视图控制器
     modalPresentationStyle可以设置模态是否隐藏
     */
    tabBar.plusButton.selected = YES;
//    SLHomeViewController *vc = [SLHomeViewController new];
//    self.definesPresentationContext = YES;
//    vc.view.backgroundColor = [UIColor clearColor];
//    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:vc animated:YES completion:nil];
    
    NSLog(@"plus+++");
}



#pragma mark --UITabBarControllerDelegate --
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    self.customTabBar.plusButton.selected = NO;
    return YES;
}


#pragma mark --UITabBarDelegate --
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    [self animationWithIndex:item.tag];
}

- (void)animationWithIndex:(NSInteger)index {
    // 得到当前tabbar的下标
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    /**
     对当前下标的tabbar使用帧动画
     可以根据UI的具体要求进行动画渲染
     */
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.2];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
    [self playSoundEffect:@"music" type:@"wav"];
}

# pragma mark - 播放音效的方法
- (void)playSoundEffect:(NSString *)name type:(NSString *)type{
    // 获取音效文件路径
    NSString *resoucePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    SystemSoundID soundID;
    // 地址转换和赋值
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:resoucePath], &soundID);
    // 开始播放音效
    AudioServicesPlaySystemSound(soundID);
}
@end

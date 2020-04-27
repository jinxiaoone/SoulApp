//
//  AppDelegate+AppConfig.m
//  SoulApp
//
//  Created by shiyu on 2020/4/15.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "AppDelegate+AppConfig.h"

@implementation AppDelegate (AppConfig)

//初始化 window
-(void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.tabBarController = [SLTabbarController new];
    self.window.rootViewController = self.tabBarController;
}


@end

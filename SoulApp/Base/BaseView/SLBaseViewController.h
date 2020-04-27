//
//  SLBaseViewController.h
//  SoulApp
//
//  Created by shiyu on 2020/4/16.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLBaseViewController : UIViewController


/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;


/** 数据*/
@property (nonatomic, strong) NSMutableArray *listArray;

@end

NS_ASSUME_NONNULL_END

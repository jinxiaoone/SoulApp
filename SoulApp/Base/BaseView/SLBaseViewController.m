//
//  SLBaseViewController.m
//  SoulApp
//
//  Created by shiyu on 2020/4/16.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLBaseViewController.h"

@interface SLBaseViewController ()

@end

@implementation SLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}








- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}


@end

//
//  SLHomeModel.m
//  SoulApp
//
//  Created by shiyu on 2020/4/20.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLHomeModel.h"

@implementation SLHomeModel

+ (void)load{
    [self regiestDB];
}

//主键ID
+ (NSString *)db_pk{
    return @"primaryID";
}

//创建数据
+ (NSMutableArray<SLHomeModel *> *)createData{
    NSMutableArray*array=[NSMutableArray array];
    for (int i=0; i<50; i++) {
        SLHomeModel *homeModel = [SLHomeModel crateModel];
        homeModel.homeTitle = Localized(@"星球");
        homeModel.stateType = kStateWaiting;
        homeModel.downID = [NSString stringWithFormat:@"%.0f", [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000];
        [homeModel save:nil];
        [array addObject:homeModel];
    }
    return array;
}

//重置
-(void)reset{
    self.homeTitle = Localized(@"星球");
    self.stateType = kStateWaiting;
    self.downID = [NSString stringWithFormat:@"%.0f", [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000];
    self.ico = @"";
    self.completeProportion = 0;
    self.stateType = kStateWaiting;
    [self save:nil];
}

@end

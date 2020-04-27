//
//  SLSperateView.h
//  SoulApp
//
//  Created by shiyu on 2020/4/20.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JhtMarquee/JhtHorizontalMarquee.h>
#import "SLHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLSperateView : UIView

/** 指示视图 */
@property (nonatomic,strong) UIView                *stateView;
/** 标题*/
@property (strong,nonatomic) JhtHorizontalMarquee  *titleLabel;
/** 完成度*/
@property (strong,nonatomic) UILabel               *completeProportionLabel;
/** 数据*/
@property (nonatomic,strong) SLHomeModel            *model;

-(void)setData:(SLHomeModel *)model;

@end

NS_ASSUME_NONNULL_END

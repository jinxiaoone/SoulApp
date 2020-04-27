//
//  SLSphereView.h
//  SoulApp
//
//  Created by shiyu on 2020/4/18.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLSphereView : UIView

/**创建**/
- (void)setCloudTags:(NSArray *)array;
/**开始**/
- (void)timerStart;
/**停止**/
- (void)timerStop;

@end

NS_ASSUME_NONNULL_END

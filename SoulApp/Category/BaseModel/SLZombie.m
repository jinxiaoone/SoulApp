//
//  SLZombie.m
//  SoulApp
//
//  Created by shiyu on 2020/4/18.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLZombie.h"
#import <objc/runtime.h>

@implementation SLZombie

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSLog(@"僵尸对象，%p调用了函数 %@", self, NSStringFromSelector(sel));
    return [[NSObject new] methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:[NSObject new]];
}

@end

//
//  SLPoint.h
//  SoulApp
//
//  Created by shiyu on 2020/4/18.
//  Copyright © 2020 shiyu. All rights reserved.
//

#ifndef SLPoint_h
#define SLPoint_h

struct SLPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

typedef struct SLPoint SLPoint;

SLPoint SLPointMake(CGFloat x, CGFloat y, CGFloat z) {
    SLPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}

#endif /* SLPoint_h */

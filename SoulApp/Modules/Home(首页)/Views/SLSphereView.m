//
//  SLSphereView.m
//  SoulApp
//
//  Created by shiyu on 2020/4/18.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLSphereView.h"
#import "SLPoint.h"
#import "SLMatrix.h"

@interface SLSphereView () <UIGestureRecognizerDelegate>
{
    NSMutableArray *_tags;
    NSMutableArray *_coordinate;
    SLPoint _normalDirection;
    CGPoint _last;
    CGFloat _velocity;
    
    CADisplayLink *_timer;
    CADisplayLink *_inertia;
}

@end

@implementation SLSphereView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

#pragma mark - initial set
//根据传入的数据，创建视图
-(void)setCloudTags:(NSArray *)array
{
    __weak typeof(self) weakSelf = self;
    _tags = [NSMutableArray arrayWithArray:array];
    _coordinate = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < _tags.count; i++) {
        UIView *view = [_tags objectAtIndex:i];
        view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    
    CGFloat p1 = M_PI * (3 - sqrt(5));
    CGFloat p2 = 2. / _tags.count;
    
    for (NSInteger i = 0; i < _tags.count; i++) {
        CGFloat y = i * p2 - 1 + (p2 / 2);
        CGFloat r = sqrt(1 - y * y);
        CGFloat p3 = i * p1;
        CGFloat x = cos(p3) * r;
        CGFloat z = sin(p3) * r;
        
        SLPoint point = SLPointMake(x, y, z);
        NSValue *value = [NSValue value:&point withObjCType:@encode(SLPoint)];
        [_coordinate addObject:value];
        
        CGFloat time = (arc4random() % 10 + 10.) / 20.;
        [UIView animateWithDuration:time delay:0. options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setTagOfPoint:point andIndex:i];
        } completion:^(BOOL finished) {
        }];
    }
    
    //随机抛洒
    NSInteger a = arc4random() % 10 - 5;
    NSInteger b = arc4random() % 10 - 5;
    _normalDirection = SLPointMake(a, b, 0);
    
    [weakSelf timerStart];
    
}


- (void)setTagOfPoint:(SLPoint)point andIndex:(NSInteger)index
{
    UIView *view = [_tags objectAtIndex:index];
    view.center = CGPointMake((point.x + 1) * (self.frame.size.width / 2.), (point.y + 1) * self.frame.size.width / 2.);
    
    CGFloat transform = (point.z + 2) / 3;
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, transform, transform);
    view.layer.zPosition = transform;
    view.alpha = transform;
    if (point.z < 0) {
        view.userInteractionEnabled = NO;
    }else {
        view.userInteractionEnabled = YES;
    }
}


#pragma mark - autoTurnRotation
- (void)timerStart
{
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoTurnRotation)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)timerStop
{
    [_timer invalidate];
    _timer = nil;
}

- (void)autoTurnRotation
{
    for (NSInteger i = 0; i < _tags.count; i ++) {
        [self updateFrameOfPoint:i direction:_normalDirection andAngle:0.002];
    }
}

- (void)updateFrameOfPoint:(NSInteger)index direction:(SLPoint)direction andAngle:(CGFloat)angle
{
    NSValue *value = [_coordinate objectAtIndex:index];
    SLPoint point;
    [value getValue:&point];
    
    SLPoint rPoint = SLPointMakeRotation(point, direction, angle);
    value = [NSValue value:&rPoint withObjCType:@encode(SLPoint)];
    _coordinate[index] = value;
    
    [self setTagOfPoint:rPoint andIndex:index];
}


#pragma mark - inertia

- (void)inertiaStart
{
    [self timerStop];
    _inertia = [CADisplayLink displayLinkWithTarget:self selector:@selector(inertiaStep)];
    [_inertia addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)inertiaStop
{
    [_inertia invalidate];
    _inertia = nil;
    [self timerStart];
}

- (void)inertiaStep
{
    if (_velocity <= 0) {
        [self inertiaStop];
    }else {
        _velocity -= 70.;
        CGFloat angle = _velocity / self.frame.size.width * 2. * _inertia.duration;
        for (NSInteger i = 0; i < _tags.count; i ++) {
            [self updateFrameOfPoint:i direction:_normalDirection andAngle:angle];
        }
    }
}


#pragma mark - gesture selector
- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _last = [gesture locationInView:self];
        [self timerStop];
        [self inertiaStop];
        
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint current = [gesture locationInView:self];
        SLPoint direction = SLPointMake(_last.y - current.y, current.x - _last.x, 0);
        
        CGFloat distance = sqrt(direction.x * direction.x + direction.y * direction.y);
        CGFloat angle = distance / (self.frame.size.width / 2.);
        
        for (NSInteger i = 0; i < _tags.count; i ++) {
            [self updateFrameOfPoint:i direction:direction andAngle:angle];
        }
        _normalDirection = direction;
        _last = current;
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocityP = [gesture velocityInView:self];
        _velocity = sqrt(velocityP.x * velocityP.x + velocityP.y * velocityP.y);
        [self inertiaStart];
    }
    
}

@end

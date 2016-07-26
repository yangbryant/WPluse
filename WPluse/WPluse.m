//
//  WPluse.m
//  WPluse
//
//  Created by everyoo.com on 16/7/26.
//  Copyright © 2016年 goingeo. All rights reserved.
//

#import "WPluse.h"

@interface WPluse ()

@property (nonatomic) CALayer *_layer;
@property (nonatomic) CAAnimationGroup *animaTionGroup;
@property (nonatomic) CADisplayLink *disPlayLink;
@property (nonatomic) UIView *superView;

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) UIColor *color;
@property (nonatomic) BOOL isWithDelegate;

@end

@implementation WPluse

+ (WPluse*)sharedView {
    static dispatch_once_t once;
    
    static WPluse *sharedView;
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:CGRectZero]; });
    return sharedView;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]) != nil) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)dealloc {
    
}

- (void)initAnimation
{
    __layer = [[CALayer alloc] init];
    __layer.cornerRadius = _superView.frame.size.width;
    __layer.frame = CGRectMake(0, 0, __layer.cornerRadius * 2, __layer.cornerRadius * 2);
    __layer.position = _superView.layer.position;
    __layer.backgroundColor = _color.CGColor;
    __layer.opacity = 0.0;
    [_superView.superview.layer insertSublayer:__layer below:_superView.layer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 1;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.5;
    scaleAnimation.toValue = @0.8;
    scaleAnimation.duration = 1;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 1;
    opencityAnimation.values = @[@0.6,@0.3,@0];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    NSArray *animations = @[scaleAnimation,opencityAnimation];
    _animaTionGroup.animations = animations;
    [__layer addAnimation:_animaTionGroup forKey:nil];
    
    [self performSelector:@selector(removeLayer:) withObject:__layer afterDelay:0.9];
    [self performSelector:@selector(stopAnimationFinished) withObject:nil afterDelay:_duration];

}

- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
}

- (void)stopAnimationInterrupted
{
    [self stopAnimation];
    if(_isWithDelegate && [_delegate respondsToSelector:@selector(wPluseDurationInterrupted)])
    {
        [_delegate wPluseDurationInterrupted];
    }
}

- (void)stopAnimationFinished
{
    [self stopAnimation];
    if(_isWithDelegate && [_delegate respondsToSelector:@selector(wPluseDurationFinished)]) {
        [_delegate wPluseDurationFinished];
    }
}

- (void)stopAnimation
{
    [_superView.superview.layer removeAllAnimations];
    [__layer removeFromSuperlayer];
    [_disPlayLink invalidate];
    __layer = nil;
    _disPlayLink = nil;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopAnimationFinished) object:nil];
}

- (void)startAnimation
{
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(initAnimation)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}


+ (void)show:(UIView *)view duration:(NSTimeInterval)duration
{
    [WPluse show:view duration:duration color:[UIColor whiteColor]];
}

+ (void)showWithDelegate:(UIView *)view duration:(NSTimeInterval)duration
{
    [WPluse showWithDelegate:view duration:duration color:[UIColor whiteColor]];
}

+ (void)show:(UIView *)view duration:(NSTimeInterval)duration color:(UIColor *)color
{
    [[self sharedView] stopAnimation];

    [self sharedView].isWithDelegate = NO;
    [self sharedView].superView = view;
    [self sharedView].duration = duration;
    [self sharedView].color = color;
    
    [[self sharedView] startAnimation];
}

+ (void)showWithDelegate:(UIView *)view duration:(NSTimeInterval)duration color:(UIColor *)color
{
    [[self sharedView] stopAnimation];
    
    [self sharedView].isWithDelegate = YES;
    [self sharedView].superView = view;
    [self sharedView].duration = duration;
    [self sharedView].color = color;
    
    [[self sharedView] startAnimation];
}

+ (void)dismiss
{
    [self sharedView].isWithDelegate = NO;
    [[self sharedView] stopAnimationInterrupted];
}

+ (void)dismissWithDelegate
{
    [self sharedView].isWithDelegate = YES;
    [[self sharedView] stopAnimationInterrupted];
}

@end

//
//  WPluse.h
//  JLPulseAnimation
//
//  Created by everyoo.com on 16/7/25.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPluseDurationDelegate <NSObject>

@optional
- (void) wPluseDurationFinished;
- (void) wPluseDurationInterrupted;
@end


@interface WPluse : UIView

@property (nonatomic,retain) id<WPluseDurationDelegate> delegate;

+ (WPluse*)sharedView;

+ (void)show:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)showWithDelegate:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)show:(UIView *)view duration:(NSTimeInterval)duration color:(UIColor *)color;
+ (void)showWithDelegate:(UIView *)view duration:(NSTimeInterval)duration color:(UIColor *)color;
+ (void)dismiss;
+ (void)dismissWithDelegate;

@end

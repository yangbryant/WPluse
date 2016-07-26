//
//  WPluse.h
//  WPluse
//
//  Created by everyoo.com on 16/7/26.
//  Copyright © 2016年 goingeo. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for WPluse.
FOUNDATION_EXPORT double WPluseVersionNumber;

//! Project version string for WPluse.
FOUNDATION_EXPORT const unsigned char WPluseVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WPluse/PublicHeader.h>


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
# WPluse

WPluse is a simple animation similar to Alipay 咻一咻.

## Requirements

iOS 8.0 and higher.


## Adding WPluse to your project

### CocoaPods

- Add a pod entry for WPluse to your Podfile
```
pod 'WPluse'
```
or
```
pod 'WPluse', :git=> 'https://github.com/yangbryant/WPluse.git', :tag => '1.0.2'
```
- Install the pod(s) by running pod install.
- Include WPluse wherever you need it with `#import "WPluse.h"`

### Source files

- Alternatively you can directly add the `WPluse.h` and `WPluse.m` source files to your project.
- Include WPluse wherever you need it with `#import "WPluse.h"`

## Features

- Show the animation without delegate
- Show the animation with delegate

## Usage

### Show the animation without delegate

```
[WPluse show:circleView duration:10.0];
[WPluse show:circleView duration:10.0 color:[UIColor whiteColor]];
[WPluse dismiss];
```

### Show the animation with delegate

```
[WPluse sharedView].delegate = self;
[WPluse sharedView].delegate = nil;
[WPluse showWithDelegate:circleView duration:10.0];
[WPluse showWithDelegate:circleView duration:10.0 color:[UIColor whiteColor]];
[WPluse dismissWithDelegate];
-(void)wPluseDurationFinished {
}
-(void)wPluseDurationInterrupted {
}
```
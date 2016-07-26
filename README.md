# WPluse

WPluse is a simple animation similar to Alipay 咻一咻.

## Requirements

iOS 8.0 and higher.

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
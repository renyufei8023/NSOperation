//
//  ViewController.m
//  RunLoop
//
//  Created by 任玉飞 on 16/5/11.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CFRunLoopObserverRef ref =  CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"发生了改变%zd",activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), ref, kCFRunLoopDefaultMode);
    
    CFRelease(ref);
}

- (void)timer2
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    //修改runloop模式
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timer1
{
    //    NSLog(@"主要的%@  当前的%@",[NSRunLoop mainRunLoop],[NSRunLoop currentRunLoop]);
    
    //这样创建会把定时器放到defalt模式下，当拖拽或者进入runloop进入其他模式的时候就不会继续调用定时器的方法
    //    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    //NSDefaultRunLoopMode和[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES]这个方法效果是一样的，NSRunLoopCommonModes这个模式不管是什么模式下都会调用定时器的方法(NSRunLoopCommonModes其实也不算是一种模式，它只是定时器在标记为common modes模式下跑),UITrackingRunLoopMode这种模式只能呢个在拖拽的情况下调用定时器的方法
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
    
}
- (void)run
{
    NSLog(@"-------");
}
@end

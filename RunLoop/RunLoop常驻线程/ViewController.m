//
//  ViewController.m
//  RunLoop常驻线程
//
//  Created by 任玉飞 on 16/5/11.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"
#import "RYFThread.h"

@interface ViewController ()
@property (nonatomic, strong) RYFThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _thread = [[RYFThread alloc]initWithTarget:self selector:@selector(test) object:nil];
    [_thread start];
    
    
    
}

- (void)test
{
    NSLog(@"线程开启了1");
    
    //子线程中的定时器需要自己调用runloop的run方法才会执行
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]run];
    //1.
//    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop]run];
    
    //2.
//    while (1) {
//        [[NSRunLoop currentRunLoop]run];
//    }
//
    
    NSLog(@"线程开启了2");
}

- (void)timerAction
{
    NSLog(@"111111111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //inModes设置在runloop什么状态下才会调用
//    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"Untitled.jpg"] afterDelay:1.0 inModes:@[NSDefaultRunLoopMode]];
    
    [self performSelector:@selector(hehe) onThread:_thread withObject:nil waitUntilDone:YES];
}

- (void)hehe
{
    
    NSLog(@"这里被执行了");
}
@end

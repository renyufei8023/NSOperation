//
//  ViewController.m
//  GCD几种队列
//
//  Created by 任玉飞 on 16/5/6.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self syncMain];
}

/**
 *  异步函数  并发队列 会开启新的线程
 */
- (void)asyncConcurrent
{
    // 1.创建一个并发队列
    // label : 相当于队列的名字
//    dispatch_queue_t queue = dispatch_queue_create("com.renyufei", DISPATCH_QUEUE_CONCURRENT);
    
    //获得一个全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"2-----%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"3-----%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncConcurrent");
}

/**
 *  同步 并发队列  不会开启新的线程
 */
- (void)syncConcurrent
{
    //1.获取一个全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2.将任务添加到队列当中去
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
}

/**
 *  异步 串行队列  会开启新的线程  但是任务会串行执行 一个执行完之后才会执行下一个任务
 */
- (void)asyncSerial
{
    //1.创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.renyufei", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
}

/**
 *  同步 串行队列  不会开启新的线程 在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务
 */
- (void)syncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("com.renyufei", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
}

/**
 *  异步 主队列：只在主线程中执行任务
 */
- (void)asyncMain
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
}

/**
 *  同步 主队列  会造成死锁
 */

- (void)syncMain
{
    NSLog(@"syncMain ----- begin");
    
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncMain ----- end");

}
@end

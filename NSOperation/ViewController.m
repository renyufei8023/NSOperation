//
//  ViewController.m
//  NSOperation
//
//  Created by 任玉飞 on 16/5/9.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"
#import "RYFOperation.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _queue = [[NSOperationQueue alloc]init];
//    
//    _queue.maxConcurrentOperationCount = 1;
//    
//    
//    // 添加操作
//    [_queue addOperationWithBlock:^{
//        for (NSInteger i = 0; i<5000; i++) {
//            NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
//        }
//    }];
//    [_queue addOperationWithBlock:^{
//        for (NSInteger i = 0; i<1000; i++) {
//            NSLog(@"download2 --- %@", [NSThread currentThread]);
//        }
//    }];
//    [_queue addOperationWithBlock:^{
//        for (NSInteger i = 0; i<1000; i++) {
//            NSLog(@"download3 --- %@", [NSThread currentThread]);
//        }
//    }];
}
- (IBAction)depend:(id)sender {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"________第一个任务%@____",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"________第二个任务%@____",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"________第三个任务%@____",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"________第四个任务%@____",[NSThread currentThread]);
    }];
    
    //op4完成后回调
    op4.completionBlock = ^{
        
    };
    //设置依赖
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];
    
    //添加任务到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //暂停任务，当调用suspended或者cancelAllOperations都会把当前任务执行完然后再暂停或者取消
    if (self.queue.isSuspended) {
        self.queue.suspended = NO;
    }else{
        self.queue.suspended = YES;
    }
//    [self.queue cancelAllOperations];
}

- (void)addOperationWithBlock
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    queue.maxConcurrentOperationCount = 2;//最小为1，等于1的时候串行队列，
    
    [queue addOperationWithBlock:^{
        NSLog(@"-------1------%@",[NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"-------2------%@",[NSThread currentThread]);
    }];
    
    
    [queue addOperationWithBlock:^{
        NSLog(@"-------3------%@",[NSThread currentThread]);
    }];
    
    
    [queue addOperationWithBlock:^{
        NSLog(@"-------14------%@",[NSThread currentThread]);
    }];
}

- (void)customOperation
{
    //创建一个队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    RYFOperation *op = [[RYFOperation alloc]init];
    [queue addOperation:op];
}

- (void)OperationQueue1
{
    //创建一个队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //创建一个任务
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download1) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(download1) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block----%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"block----%@",[NSThread currentThread]);
    }];
    
    //把任务添加到队列当中去，相当于调用了任务的start方法
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)BlockOperation
{
    //不加入队列中默认在主线程中
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%111111@",[NSThread currentThread]);
    }];
    //addExecutionBlock加入的任务会开启一条新的线程
    [op addExecutionBlock:^{
        NSLog(@"2222222%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"333333%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"444444%@",[NSThread currentThread]);
    }];
    [op start];
}

- (void)InvocationOperation
{
    //不加入队列中默认在主线程中
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run) object:nil];
    [op start];
}
- (void)run
{
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)download1
{
    NSLog(@"%123456@",[NSThread currentThread]);
}

- (void)download2
{
    NSLog(@"654321%@",[NSThread currentThread]);
}
@end

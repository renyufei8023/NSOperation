//
//  ViewController.m
//  线程安全(互斥锁)
//
//  Created by 任玉飞 on 16/5/4.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@property (nonatomic, strong) NSThread *thread3;
@property (nonatomic, assign) NSInteger tacketCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tacketCount = 100;
    self.thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    self.thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    self.thread3 = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}

- (void)run {
    while (1) {
        @synchronized(self) {
            // 先取出总数
            NSInteger count = self.tacketCount;
            if (count > 0) {
                self.tacketCount = count - 1;
                NSLog(@"%@卖了一张票，还剩下%zd张", [NSThread currentThread], self.tacketCount);
            } else {
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
    
}

@end

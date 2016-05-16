//
//  ViewController.m
//  线程状态
//
//  Created by 任玉飞 on 16/5/4.
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
    [NSThread detachNewThreadSelector:@selector(hehe) toTarget:self withObject:@"hehe"];
}

- (void)hehe:(NSString *)str
{
    for (NSInteger i = 0; i<100; i++) {
        NSLog(@"-----%zd", i);
        
        if (i == 49) {
            [NSThread exit]; // 直接退出线程
        }
    }
}

- (void)hehe
{
    NSLog(@"---------");
    
//    [NSThread sleepForTimeInterval:2.0];// 让线程睡眠2秒（阻塞2秒）
    
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
    NSLog(@"---------");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

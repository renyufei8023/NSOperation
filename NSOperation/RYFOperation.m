//
//  RYFOperation.m
//  NSOperation
//
//  Created by 任玉飞 on 16/5/9.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFOperation.h"

@implementation RYFOperation

/**
 *  需要重写这个方法，把想做的事情放到这方法里面即可
 */
- (void)main
{
    for (NSInteger i = 0; i<5000; i++) {
        NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
    }
    //官方建议在执行耗时操作的时候需要这样设置
    if (self.isCancelled) return;
        
    for (NSInteger i = 0; i<5000; i++) {
        NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
    }
    
    if (self.isCancelled) return;
    
    for (NSInteger i = 0; i<5000; i++) {
        NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
    }
    NSLog(@"------------%@",[NSThread currentThread]);
}
@end

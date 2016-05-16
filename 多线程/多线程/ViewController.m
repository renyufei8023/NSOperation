//
//  ViewController.m
//  多线程
//
//  Created by 任玉飞 on 16/5/4.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

void * run(void *param)
{
    for (NSInteger i = 0; i<50000; i++) {
        NSLog(@"------buttonClick---%zd--%@", i, [NSThread currentThread]);
    }
    return NULL;
}

- (IBAction)btnClick:(id)sender {
    pthread_t thread;
    pthread_create(&thread, NULL, run, NULL);
}

@end

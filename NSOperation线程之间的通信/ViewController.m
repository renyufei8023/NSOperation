//
//  ViewController.m
//  NSOperation线程之间的通信
//
//  Created by 任玉飞 on 16/5/9.
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
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    __block UIImage *image1 = nil;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://thumb.takefoto.cn/wp-content/uploads/2016/03/201603222328428366.png"];
        image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    }];
    
    __block UIImage *image2 = nil;
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://www.52tq.net/uploads/allimg/160325/1339122J5-1.jpg"];
        image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        image1 = nil;
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        image2 = nil;
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];
        
        
        UIGraphicsEndImageContext();
        
    }];
    
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
}

- (void)test
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"http://thumb.takefoto.cn/wp-content/uploads/2016/03/201603222328428366.png"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    
    [queue addOperation:op1];
}
@end

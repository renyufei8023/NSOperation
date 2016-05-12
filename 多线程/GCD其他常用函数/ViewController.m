//
//  ViewController.m
//  GCD其他常用函数
//
//  Created by 任玉飞 on 16/5/8.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_queue_t queue = dispatch_queue_create("renyufei.com", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=6fb4569492eef01f591910978197f240/94cad1c8a786c917a405bdc9cf3d70cf3bc75738.jpg"];
        self.image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
    });
    
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=6ed64c51b1b7d0a26fc40ccfaa861d6c/50da81cb39dbb6fd9184c5c50a24ab18962b3771.jpg"];
        self.image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    });
    
    dispatch_group_notify(group, queue, ^{
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        
        [self.image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        [self.image2 drawInRect:CGRectMake(0, 50, 50, 100)];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        
        UIGraphicsEndImageContext();
    });
}

- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("com.renyufe", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"嘿嘿");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    
    NSLog(@"结束le");
}
@end

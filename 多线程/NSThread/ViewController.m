//
//  ViewController.m
//  NSThread
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
    
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(heihei:) object:@"heihei"];
//    thread.name = @"子线程";
//    [thread start];//必须调用start方法，不然线程不会执行
    
    
    [NSThread detachNewThreadSelector:@selector(heihei:) toTarget:self withObject:@"heihei"];
    
//    [self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)heihei:(NSString *)str
{
    NSLog(@"------%@------%@",[NSThread currentThread],str);
}
@end

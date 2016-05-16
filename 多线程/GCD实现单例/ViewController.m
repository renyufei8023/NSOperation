//
//  ViewController.m
//  GCD实现单例
//
//  Created by 任玉飞 on 16/5/8.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p1 = [Person sharePerson];
    Person *p2 = [Person sharePerson];
    Person *p3 = [[Person alloc]init];
    Person *p4 = [p3 copy];
    
    NSLog(@"%@  %@  %@",p1,p2,p3);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

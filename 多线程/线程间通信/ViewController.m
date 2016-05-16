//
//  ViewController.m
//  线程间通信
//
//  Created by 任玉飞 on 16/5/4.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelectorInBackground:@selector(downImage) withObject:nil];
//    [NSThread detachNewThreadSelector:@selector(downImage) toTarget:self withObject:nil];
}


- (void)downImage {
    
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
//    [self performSelectorOnMainThread:@selector(hehe:) withObject:image waitUntilDone:YES];
}

- (void)hehe:(UIImage *)image
{
    self.imageView.image = image;
}
@end

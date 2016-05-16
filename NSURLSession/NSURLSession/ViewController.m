//
//  ViewController.m
//  NSURLSession
//
//  Created by 任玉飞 on 16/5/16.
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
- (IBAction)start:(id)sender {
}
- (IBAction)goOn:(id)sender {
}
- (IBAction)pause:(id)sender {
}
- (IBAction)start:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self download];
}

- (void)download
{
    // 获得NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 获得下载任务
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //location是沙盒中的temp文件夹的一个路径，response包含了请求头等一些信息
        NSLog(@"location%@----response%@-----",location,response);
        // 文件将来存放的真实路径
        NSString *fileURL = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:response.suggestedFilename];//response.suggestedFilename表示文件的文件名
        
        // 剪切location的临时文件到真实路径
        NSFileManager *mg = [NSFileManager defaultManager];
        [mg moveItemAtURL:location toURL:[NSURL fileURLWithPath:fileURL] error:nil];
    }];
    
    [task resume];
}

- (void)post
{
    // 获得NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login"]];
    // 请求方法
    request.HTTPMethod = @"POST";
    // 请求体
    request.HTTPBody = [@"username=123&pwd=4324" dataUsingEncoding:NSUTF8StringEncoding];
    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"------%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    // 启动任务
    [task resume];
}

- (void)get2
{
    // 获得NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=4324"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"------%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    // 启动任务
    [task resume];

}

- (void)get1
{
    // 获得NSURLSession对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=4324"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"------%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    // 启动任务
    [task resume];
}
@end

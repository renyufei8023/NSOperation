//
//  ViewController.m
//  NSURLSession代理方法
//
//  Created by 任玉飞 on 16/5/16.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获得NSURLSession对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=4324"]]];
    
    // 启动任务
    [task resume];
}

#pragma mark - <NSURLSessionDataDelegate>
/**
 *  接受到服务器的响应
 *
 *  @param session           <#session description#>
 *  @param dataTask          <#dataTask description#>
 *  @param response          <#response description#>
 *  @param completionHandler <#completionHandler description#>
 */
- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"----%@------%@------%@------%@",session,dataTask,response,completionHandler);
}

/**
 * 2.接收到服务器的数据（可能会被调用多次）
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
}


/**
 * 3.请求成功或者失败（如果失败，error有值）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
}
@end

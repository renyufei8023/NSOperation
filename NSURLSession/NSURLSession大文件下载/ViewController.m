//
//  ViewController.m
//  NSURLSession大文件下载
//
//  Created by 任玉飞 on 16/5/16.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];
    
    [task resume];
    
}

#pragma mark -  <NSURLSessionDownloadDelegate>
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"didCompleteWithError%@",error);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"didResumeAtOffset");
}

/**
 *  每当写入数据到临时文件时，就会调用一次这个方法
 *  @param totalBytesWritten         已经写入的大小
 *  @param totalBytesExpectedToWrite 总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"进度%f",progress);
}

/**
 *  下载完毕之后会调用一次这个方法
 *
 *  @param session      <#session description#>
 *  @param downloadTask <#downloadTask description#>
 *  @param location     <#location description#>
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    //fileURLWithPath不是urlWithString
    [mgr moveItemAtURL:location toURL:[NSURL fileURLWithPath:file] error:nil];
    NSLog(@"--------%@",file);
    NSLog(@"--------%@",location);
}
@end

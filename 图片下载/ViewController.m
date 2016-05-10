//
//  ViewController.m
//  图片下载
//
//  Created by 任玉飞 on 16/5/9.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *datas;
/**
 *  内存中的图片
 */
@property (nonatomic, strong) NSMutableDictionary *imageCahe;

/**
 *  所有操作的对象
 */
@property (nonatomic, strong) NSMutableDictionary *operations;

/**
 *  队列对象
 */
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}

- (NSMutableDictionary *)operations
{
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSMutableDictionary *)imageCahe
{
    if (!_imageCahe) {
        _imageCahe = [NSMutableDictionary dictionary];
    }
    return _imageCahe;
}

- (NSArray *)datas
{
    if (!_datas) {
        NSArray *apps = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        NSMutableArray *appArray = [NSMutableArray array];
        for (NSDictionary *dict in apps) {
            [appArray addObject:[AppModel appWithDict:dict]];
        }
        _datas = appArray;
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"appCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    AppModel *model = self.datas[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
    
    //先从内存缓存中取出图片
    UIImage *image = self.imageCahe[model.icon];
    if (image) {//内存缓存中有图片的情况
        
        cell.imageView.image = image;
        
    }else{//内存缓存中没有图片的情况
        
        //获得Library/Caches文件夹
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //获得url中图片名字
        NSString *filename = [model.icon lastPathComponent];
        //拼接路径
        NSString *file = [cachesPath stringByAppendingPathComponent:filename];
        //将沙盒里面的图片转换为data
        NSData *data = nil;//[NSData dataWithContentsOfFile:file];
        
        if (data) {//沙盒中有的话会执行这里
            UIImage *image = [UIImage imageWithData:data];
            cell.imageView.image = image;
            self.imageCahe[model.icon] = image;
            
        }else{//沙盒中没有图片，需要进行下载
            /**
               先设置一个占位图，避免网络卡顿(主要是阻挡下载线程的操作)造成cell图片错误而非本行应该显示的图片，还有就是使用系统自带的cell的时候刚开始不显示图片，需要滑动才会显示的问题(造成该问题的原因是刚开始系统无法知道图片的大小尺寸从而无法正常的显示出来),不过这个占位图尺寸不要太大，不然会影响显示的图片
             */
            cell.imageView.image = [UIImage imageNamed:@"猫.jpg"];
            
            //从内存中取出当前所对应的任务
            NSOperation *operation = self.operations[model.icon];
            
            if (operation == nil) {//任务不存在
                operation = [NSBlockOperation blockOperationWithBlock:^{
                    //下载图片
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]];
                    
                    if (imageData == nil) {//这里判断从网络上面下载失败的时候，如果不进行判断的话后面可能会崩溃
                        [self.operations removeObjectForKey:model.icon];//这里移除这个任务，是为了下次可以继续下载，如果不移除那么这个图片以后永远都不会再下载了
                        return ;
                    }
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    //存到字典中去
                    self.imageCahe[model.icon] = image;
                    
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                        cell.imageView.image = image;
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];//使用这个方法而不使用cell.imageView.image = image;是为了让他重新调用- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath从而不会造成cell从缓存池中取造成的缓存问题(就是当这一行从屏幕上离开进入缓存池的时候，然后最下面的一行就是刚放入缓存池的那个图片的问题)
                    }];
                    
                    //写入沙盒中
                    [imageData writeToFile:file atomically:YES];
                    
                    //移除操作(优化性能)，因为写入之后这个操作就没什么用了，移除是为了内存着想
                    [self.operations removeObjectForKey:model.icon];
                    
                }];
                
                //添加到队列中去
                [self.queue addOperation:operation];
                
                //存放到字典中
                self.operations[model.icon] = operation;
            }
        }
       
    }
    
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.imageCahe = nil;
    self.operations = nil;
    [self.queue cancelAllOperations];
    // Dispose of any resources that can be recreated.
}

@end

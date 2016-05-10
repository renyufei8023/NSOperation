//
//  AppModel.h
//  NSOperation
//
//  Created by 任玉飞 on 16/5/9.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject
/** 图标 */
@property (nonatomic, strong) NSString *icon;
/** 下载量 */
@property (nonatomic, strong) NSString *download;
/** 名字 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)appWithDict:(NSDictionary *)dict;

@end

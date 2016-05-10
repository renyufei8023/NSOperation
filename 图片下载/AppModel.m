//
//  AppModel.m
//  NSOperation
//
//  Created by 任玉飞 on 16/5/9.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

+ (instancetype)appWithDict:(NSDictionary *)dict
{
    AppModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end

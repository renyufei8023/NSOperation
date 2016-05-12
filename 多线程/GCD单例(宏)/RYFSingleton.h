//
//  RYFSingleton.h
//  多线程
//
//  Created by 任玉飞 on 16/5/8.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#define RYFSingletonH(name) + (instancetype)share##name;

#define RYFSingletonM(name)\
static id _instance;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
\
+ (instancetype)sharePerson\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc]init];\
    });\
    return _instance;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
    return _instance;\
}

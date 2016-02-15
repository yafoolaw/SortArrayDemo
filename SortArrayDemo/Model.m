//
//  Model.m
//  SortArrayDemo
//
//  Created by FrankLiu on 16/2/15.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (instancetype)name: (NSString*)name age: (NSNumber*)age height: (NSNumber*)height {

    Model *model = [Model new];
    
    model.m_name   = name;
    model.m_age    = age;
    model.m_height = height;
    
    return model;
}

@end

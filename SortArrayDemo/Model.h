//
//  Model.h
//  SortArrayDemo
//
//  Created by FrankLiu on 16/2/15.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, strong) NSString *m_name;
@property (nonatomic, strong) NSNumber *m_age;
@property (nonatomic, strong) NSNumber *m_height;

+ (instancetype)name: (NSString*)name age: (NSNumber*)age height: (NSNumber*)height;

@end

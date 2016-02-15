//
//  NSArray+DescriptorSort.m
//  SortArrayDemo
//
//  Created by FrankLiu on 16/2/15.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "NSArray+DescriptorSort.h"

@implementation NSArray (DescriptorSort)

- (NSArray*)sortedWithKeyPath: (NSString*)keyPath ascending: (BOOL)ascending {

    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:keyPath ascending:ascending];
    
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

@end

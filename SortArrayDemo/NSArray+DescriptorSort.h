//
//  NSArray+DescriptorSort.h
//  SortArrayDemo
//
//  Created by FrankLiu on 16/2/15.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DescriptorSort)

- (NSArray*)sortedWithKeyPath: (NSString*)keyPath ascending: (BOOL)ascending;

@end

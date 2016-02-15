//
//  ViewController.m
//  SortArrayDemo
//
//  Created by FrankLiu on 16/2/14.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "ViewController.h"

#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 源数组
    NSArray *alphabeticArray  = @[@"b", @"a", @"x", @"o", @"g", @"o"];
    NSArray *numberArray      = @[@2, @4, @12, @1, @9];
    NSArray *modelArray       = @[[Model name:@"LiuDaShuai"  age:@26 height:@171],
                                  [Model name:@"XiaoQiu"     age:@27 height:@170],
                                  [Model name:@"HaoQuShi"    age:@28 height:@172],
                                  [Model name:@"JunGang"     age:@24 height:@171],
                                  [Model name:@"KongMing"    age:@30 height:@175],
                                  [Model name:@"GaoFuShuai"  age:@22 height:@180]];
    
    // ----------- 用Function排序
    
    NSArray *funcitonSortedArray = [numberArray sortedArrayUsingFunction:intSort context:NULL];
    NSLog(@" funcitonSortedArray = %@",funcitonSortedArray);
    
    // 注: Function排序还有一个方法 – sortedArrayUsingFunction:context:hint:,这个方法用在这样的情景:
    // 假设你有一个经常要排序的大数组,即使轻微的改变(比如添加或删除一个元素),也需要重新对数组排序,这样排序成本很高
    // [anArray sortedArrayHint],此方法应该被已排序好的数组调用,来获得一个私有的data来加速轻微改变的数组的排序
    // 参考1:http://stackoverflow.com/questions/7023291/sortedarrayhint-method-of-nsarray-class-what-is-the-purpose-of-using-and-how
    // 参考2:https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Collections/Articles/Arrays.html
    // 下面是简单用法,由于数组不够大,所以,体现不出此方法的优势.
    
    [self hintFunctionDemo];
    
    // ----------- 用Selector排序
    
    NSArray *selectorSortedArray = [alphabeticArray sortedArrayUsingSelector:@selector(compare:)];
    
    // 注: NSString,NSNumber都有和排序相关的方法,如NSString有
    // - (NSComparisonResult)compare:(NSString *)string;
    // - (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask;
    // - (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask range:(NSRange)compareRange;
    // - (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask range:(NSRange)compareRange locale:(nullable id)locale;
    // - (NSComparisonResult)caseInsensitiveCompare:(NSString *)string;
    // - (NSComparisonResult)localizedCompare:(NSString *)string;
    // - (NSComparisonResult)localizedCaseInsensitiveCompare:(NSString *)string;
    
    NSLog(@"selectorSortedArray = %@",selectorSortedArray);
    
    // ----------- 用Descriptor排序
    // NSSortDescriptor只是一个获取keyPath的工具,它能根据keyPath进行排序
    
    // 排序描述信息
    NSSortDescriptor *sortDescriptor        = [[NSSortDescriptor alloc] initWithKey:@"m_age" ascending:YES];
    NSArray          *sortDescriptors       = [NSArray arrayWithObject:sortDescriptor];
    NSArray          *descriptorSortedArray = [modelArray sortedArrayUsingDescriptors:sortDescriptors];
    
    // 把以上封装成类目,更加便于使用
    
    // 打印排序信息
    [descriptorSortedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Model *tmp = obj;
        NSLog(@"descriptorSortedArray model = %@", tmp.m_name);
    }];
    
    // ----------- 用Comparator排序
    // 最简单易用
    
    NSArray *comparatorSortedArray = [modelArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        Model *model1 = obj1;
        Model *model2 = obj2;
        
        return [model1.m_name compare:model2.m_name];
    }];
    
    // 打印排序信息
    [comparatorSortedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Model *tmp = obj;
        NSLog(@"comparatorSortedArray model = %@", tmp.m_name);
    }];
}

NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    if (*(BOOL *)reverse == YES) {
        
        return [string2 localizedCaseInsensitiveCompare:string1];
    }
    
    return [string1 localizedCaseInsensitiveCompare:string2];
}

- (void)hintFunctionDemo {

    NSMutableArray *anArray =
    [NSMutableArray arrayWithObjects:@"aa", @"ab", @"ac", @"ad", @"ae", @"af", @"ag",
     @"ah", @"ai", @"aj", @"ak", @"al", @"am", @"an", @"ao", @"ap", @"aq", @"ar", @"as", @"at",
     @"au", @"av", @"aw", @"ax", @"ay", @"az", @"ba", @"bb", @"bc", @"bd", @"bf", @"bg", @"bh",
     @"bi", @"bj", @"bk", @"bl", @"bm", @"bn", @"bo", @"bp", @"bq", @"br", @"bs", @"bt", @"bu",
     @"bv", @"bw", @"bx", @"by", @"bz", @"ca", @"cb", @"cc", @"cd", @"ce", @"cf", @"cg", @"ch",
     @"ci", @"cj", @"ck", @"cl", @"cm", @"cn", @"co", @"cp", @"cq", @"cr", @"cs", @"ct", @"cu",
     @"cv", @"cw", @"cx", @"cy", @"cz", nil];
    
    // note: anArray is sorted
    NSData *sortedArrayHint = [anArray sortedArrayHint];
    
    [anArray insertObject:@"be" atIndex:5];
    
    // sort with a hint
    BOOL reverseSort = NO;
    NSArray *sortedArray = [anArray sortedArrayUsingFunction:alphabeticSort
                                                     context:&reverseSort
                                                        hint:sortedArrayHint];
    
    NSLog(@"hintFunctionSortedArray = %@",sortedArray);
}

NSInteger intSort(id num1, id num2, void *context) {
    
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    
    if (v1 < v2) {
    
        return NSOrderedAscending;
        
    } else if (v1 > v2) {
    
       return NSOrderedDescending;
        
    } else {
    
        return NSOrderedSame;
    }
}


@end

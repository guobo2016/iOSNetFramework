


//
//  IB_FileManager.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 16/1/19.
//  Copyright © 2016年 XX_Company. All rights reserved.
//
#import "IBCacheManager.h"
#import "NSString+IBEncrypt.h"
#import "IBError.h"

@implementation IBCacheManager

+ (NSDictionary*)readCacheDiskByUrl:(NSString*)url params:(NSDictionary*)parametersDic
{
    NSMutableString *urlString;
    urlString = [self getUrlMulStringByUrl:url params:parametersDic];
    NSString *floderPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Caches/IBCacheFinder"];
    
    NSString* filePath = [floderPath stringByAppendingPathComponent:[urlString md5]];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    return dict;
}

+ (NSMutableString *)getUrlMulStringByUrl:(NSString*)url params:(NSDictionary*)parametersDic
{
    NSMutableString* urlString = [NSMutableString stringWithString:url];
    for (NSString* key in parametersDic.allKeys) {
        if (key && parametersDic[key]) {
            [urlString appendString:key];
            [urlString appendString:@"_"];
            [urlString appendString:[NSString stringWithFormat:@"%@",parametersDic[key]]];
        }
    }
    return urlString;
}

+ (void)writeCacheDisk:(NSMutableDictionary*)resultDict url:(NSString*)url params:(NSDictionary*)parametersDic
{
    if(!resultDict[@"Code"] || [resultDict[@"Code"]intValue]!=kErrorCode_Success){
        NSLog(@"错误信息：信息异常，无法写入缓存");

        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableString *urlString;
        urlString = [self getUrlMulStringByUrl:url params:parametersDic];
        NSString *floderPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Caches/IBCacheFinder"];
        BOOL isForder = NO;
        if (![[NSFileManager defaultManager]fileExistsAtPath:floderPath isDirectory:&isForder]) {
            if (!isForder) {
                [[NSFileManager defaultManager]createDirectoryAtPath:floderPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
        NSString* filePath = [floderPath stringByAppendingPathComponent:[urlString md5]];
        [resultDict writeToFile:filePath atomically:YES];
        //        DLog(@"缓存状态：%zd",isSucc);
    });
}
@end

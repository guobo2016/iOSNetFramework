//
//  ViewController.m
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/14.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

#import "ViewController.h"
#import "IB_ExampleModel.h"
#import "IB_DemoRequest.h"
#import "NSString+IB_Encrypt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* encodeString = [@"123" encrypt];
    NSLog(@"%@",encodeString);
    
    NSString* decodeString = [encodeString decrypt];
    NSLog(@"%@",decodeString);
    
    [self setNavTitle:@"测试"];
    NSDictionary* dict1 = @{@"key1":@"key",@"key2":@{@"key21":@"222"}};
    NSDictionary* dict2 = @{@"key1":@"key",@"key2":@{@"key21":@"222"}};
    NSLog(@"%zd",dict1 == dict2);
    NSLog(@"%zd",[dict1 isEqualToDictionary: dict2]);

    [[[IB_DemoRequest alloc]init]sendRequestSuccessBlock:^(IB_BaseResponseModel *baseModel) {
        IB_BaseDataModel* dataModel = baseModel.data;
        NSLog(@"成功ResponseModel####%@",baseModel);
        NSLog(@"成功ResponseDataModel####%@",dataModel);

    } requestFailBlock:^(IB_Error *error) {
        DLog(@"%@",error);
    } finalBlock:^(IB_BaseResponseModel *baseModel, IB_Error *error) {
        
    }];
    
    [IB_DemoRequest cancel];
    /**
     *  测试发起网路请求
     */
//    [IB_ApiOperation post:Example_URL params:@{@"pageNumber":@"1",@"pageSize":@"200",@"userId":@"3121051"} cache:YES successBlock:^(IBBaseModel *resultModel) {
    //        NSMutableArray* resultArray = [NSMutableArray array];
    //        for (NSDictionary* dict in resultModel.data) {
    //            IBExampleModel* model = [IBExampleModel objectFromDictionary:dict];
    //            [resultArray addObject:model];
    //        }
    //        NSLog(@"成功####%@",resultArray);
//    } requestFailBlock:^(IB_Error *error) {
//        NSLog(@"失败####%@",error);
//    } finalBlock:^(IBBaseModel *resultModel, IB_Error *error) {
//        NSLog(@"这是缓存数据吗？%@",resultModel.isCache?@"是":@"不是");
//    }];
    /**
     *  测试关闭网络请求
     */
//    [IBApiOperation cancel:Example_URL];
//    [IBApiOperation get:Example_URL params:nil cache:NO successBlock:^(IBBaseModel *resultModel) {
//        
//    } requestFailBlock:^(IBError *error) {
//        
//    } finalBlock:^(IBBaseModel *resultModel, IBError *error) {
//        
//    }];
}


@end

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
    
    [[[IB_DemoRequest alloc]init]sendRequestSuccessBlock:^(IB_BaseResponseModel *baseModel) {
        IB_BaseDataModel* dataModel = baseModel.data;
        NSLog(@"成功ResponseModel####%@",baseModel);
        NSLog(@"成功ResponseDataModel####%@",dataModel);

    } requestFailBlock:^(IB_Error *error) {
        DLog(@"%@",error);
    } finalBlock:^() {
        
    }];
    
//    [IB_DemoRequest cancel];
}
/********************************
 <IB_BaseResponseModel: id = (null) {
 code = 200;
 data =     (
 {
 name = "2015年福建省中小学教师信息技术应用能力提升工程网络研修演示平台";
 userCount = 31;
 },
 {
 name = "和威哥一起学手绘";
 userCount = 1349;
 },
 {
 name = "时间管理";
 userCount = 14870;
 },
 {
 name = "懒人PPT宝典";
 userCount = 2504;
 },
 {
 name = "职场语言艺术";
 userCount = 6747;
 },
 {
 name = "宋词";
 userCount = 6587;
 }
 );
 isCache = 0;
 message = "";
 pageIndex = 0;
 totalCount = 6;
 }>
 */

@end

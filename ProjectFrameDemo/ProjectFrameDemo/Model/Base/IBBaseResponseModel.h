//
//  IBBaseModel.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/15.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
/**
 * 网络请求返回结果的Model
 */
@interface IBBaseResponseModel : Jastor
/**
 *  消息描述
 */
@property (strong,nonatomic) NSString* message;
/**
 *  结果码
 */
@property (assign,nonatomic) NSInteger code;
/**
 *  结果体
 */
@property (strong,nonatomic) id data;
/**
 *  是否是缓存数据
 */
@property (assign,nonatomic) BOOL isCache;
/**
 *  当前页码
 */
@property (assign,nonatomic) NSInteger pageIndex;
/**
 *  总共的数据条数
 */
@property (assign,nonatomic) NSInteger totalCount;

@end

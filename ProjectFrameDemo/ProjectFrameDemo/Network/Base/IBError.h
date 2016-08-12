//
//  IBError.h
//  ProjectFrameDemo
//
//  Created by 郭波 on 15/12/15.
//  Copyright © 2015年 XX_Company. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,kErrorCode) {
    /**
     *  请求成功
     */
    kErrorCode_Success = 200,
    /**
     *  数据失败
     */
    kErrorCode_Data_Error = 601,
    /**
     *  请求关闭
     */
    kErrorCode_Cancel = 602,
    /**
     *  网络异常
     */
    kErrorCode_Internet_Error = 603,
    /**
     *  超时
     */
    kErrorCode_TimeOut_Error = 604
};

@interface IBError : NSError

@end

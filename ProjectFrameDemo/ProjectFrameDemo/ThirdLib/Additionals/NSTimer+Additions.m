//
//  NSTimer+LSAdditions.m
//  timerBlock
//
//  Created by T on 14-7-4.
//  Copyright (c) 2014年 com.hollance. All rights reserved.
//

#import "NSTimer+Additions.h"

@implementation NSTimer(LSBLocks)

+(NSTimer*) lsScheduleTimerWithTimerInternal:(NSTimeInterval)interval
                                       block:(void(^)())block
                                     repeats:(BOOL)repeats
{
    NSTimer* timer = [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(lsTimerBlockInvoke:) userInfo:[block copy] repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    //保留NSTimer类对象，可忽略
    return timer;
}
+(void)lsTimerBlockInvoke:(NSTimer*)timer
{
    void(^block)() = timer.userInfo;

    if(block){
        block();
    }
}
@end

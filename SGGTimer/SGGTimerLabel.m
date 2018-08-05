//
//  SGGTimerLabel.m
//  SGGTimer
//
//  Created by yrf on 2018/1/17.
//  Copyright © 2018年 hnrrcar. All rights reserved.
//

#import "SGGTimerLabel.h"

@implementation SGGTimerLabel

-(void)setTime:(NSInteger)time
{
    _time = time;
    NSInteger miniter = time/60;
    NSInteger second = time %60;
    self.text = [NSString stringWithFormat:@"%02ld : %02ld",miniter,second];
    
    
}
@end

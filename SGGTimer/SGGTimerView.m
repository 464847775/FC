//
//  SGGTimerView.m
//  SGGTimer
//
//  Created by yrf on 2018/1/17.
//  Copyright © 2018年 hnrrcar. All rights reserved.
//

#import "SGGTimerView.h"
#import "SGGTimerLabel.h"

@interface SGGTimerView()
@property (nonatomic,strong)UILabel *miniteLabel;
@property (nonatomic,strong)SGGTimerLabel *secondLabel;

@end

@implementation SGGTimerView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UILabel *miniteLabel = [[UILabel alloc]init];
        miniteLabel.text = @"00";
        miniteLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:miniteLabel];
        self.miniteLabel = miniteLabel;
        SGGTimerLabel *secondLabel = [[SGGTimerLabel alloc]init];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(miniteChanged:) name:@"NSLabelValueChanged" object:secondLabel];
        secondLabel.text = @"00";
        secondLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:secondLabel];
        self.secondLabel = secondLabel;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            int i = self.secondLabel.text.intValue;
            i++;
            self.secondLabel.text = [NSString stringWithFormat:@"%02i",i];
        }];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)miniteChanged:(NSNotification *)noti
{
    NSString *text = noti.userInfo[@"text"];
    if (text.intValue >59) {
        int i = self.miniteLabel.text.intValue;
        i++;
        self.miniteLabel.text = [NSString stringWithFormat:@"%02i",i];
        self.secondLabel.text = @"00";
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat  miniteX = 0;
    CGFloat  miniteY = 0;
    CGFloat  miniteW = self.frame.size.width *0.5;
    CGFloat  miniteH = self.frame.size.height;
    self.miniteLabel.frame = CGRectMake(miniteX, miniteY, miniteW, miniteH);
    CGFloat  secondX= self.frame.size.width *0.5;
    CGFloat  secondY = 0;
    CGFloat  secondW = self.frame.size.width *0.5;
    CGFloat  secondH = self.frame.size.height;
    self.secondLabel.frame = CGRectMake(secondX, secondY, secondW, secondH);
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
@end

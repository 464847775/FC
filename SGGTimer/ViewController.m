//
//  ViewController.m
//  SGGTimer
//
//  Created by yrf on 2018/1/17.
//  Copyright © 2018年 hnrrcar. All rights reserved.
//

#import "ViewController.h"
#import "SGGTimerLabel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet SGGTimerLabel *timeLabel;
@property(nonatomic,assign)NSInteger time;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSDate *firstDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterForeground:) name:@"NSAppEnterForeground" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterBackgroud:) name:@"NSAppEnterBackground" object:nil];
    self.time = 0;
    self.firstDate = [NSDate date];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun)userInfo:nil repeats:YES];
    self.timer = timer;
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)timerRun{
        self.time ++;
        NSLog(@"time = %ld",self.time);
//        self.timeLabel.time = self.time;

}
-(void)enterForeground:(NSNotification *)noti
{
    NSDate *now = [NSDate date];
    self.time = [now timeIntervalSinceDate:self.firstDate];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun)userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}
-(void)enterBackgroud:(NSNotification *)noti
{
    [self.timer invalidate];
    self.timer = nil;
    
}
-(void)setTime:(NSInteger)time
{
    _time = time;
    self.timeLabel.time = time;
    if (_time >60*60) {
        [self.timeLabel removeFromSuperview];
        [self.timer invalidate];
        self.timer = nil;
        self.time = 0;
    }
}
-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    
}

@end

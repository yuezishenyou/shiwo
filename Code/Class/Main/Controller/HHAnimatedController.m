//
//  HHAnimatedController.m
//  shiwo
//
//  Created by maoziyue on 2017/11/8.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHAnimatedController.h"

@interface HHAnimatedController ()



@end

@implementation HHAnimatedController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点标注平滑移动";
    
    [self initData];
    
    [self initSubViews];
    
    [self locateMapViewInView:self.view frame:self.view.bounds completion:nil];
    
    self.mapView.showsUserLocation = NO;
    
    
}

- (void)initData
{
    
}

- (void)initSubViews
{
    
}










@end

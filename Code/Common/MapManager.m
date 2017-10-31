//
//  MapManager.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "MapManager.h"

@implementation MapManager

+ (instancetype)manager
{
    static MapManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[MapManager alloc]init];
        }
    });
    return _manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}


//---------------------------------------------------
//-MARK
//---------------------------------------------------

- (void)initMapView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.mapView = [[MAMapView alloc]initWithFrame:rect];
}








//---------------------------------------------------
//-MARK
//---------------------------------------------------

- (void)setup
{
    
}

































@end

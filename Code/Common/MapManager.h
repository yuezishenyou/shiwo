//
//  MapManager.h
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapManager : NSObject

@property (nonatomic, strong) MAMapView *mapView;

+ (instancetype)manager;

- (void)initMapView;






@end

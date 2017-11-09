//
//  HHAnimatedController.m
//  shiwo
//
//  Created by maoziyue on 2017/11/8.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHAnimatedController.h"
#import "HHMovingAnnotation.h"
#import "TimerManager.h"


#define kTimerName @"持续定位"


@interface HHAnimatedController ()
///车头方向跟随转动
@property (nonatomic, strong) MAAnimatedAnnotation *car1;
///车头方向不跟随转动
@property (nonatomic, strong) HHMovingAnnotation *car2;

///全轨迹overlay
@property (nonatomic, strong) MAPolyline *fullTraceLine;
///走过轨迹的overlay
@property (nonatomic, strong) MAPolyline *passedTraceLine;
@property (nonatomic, assign) int passedTraceCoordIndex;

@property (nonatomic, strong) NSArray *distanceArray;
@property (nonatomic, assign) double sumDistance;

@property (nonatomic, weak) MAAnnotationView *car1View;
@property (nonatomic, weak) MAAnnotationView *car2View;

@property (nonatomic, strong) NSMutableArray *carsArray;





@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, copy)   NSArray  *fivePoints;
@property (nonatomic, copy)   NSString *lastPoint;
@property (nonatomic, assign) NSInteger index;



@end

@implementation HHAnimatedController

- (void)mapInitComplete:(MAMapView *)mapView
{
    NSLog(@"-----mapInit-----");
    //[self initRoute];
    [self addAnnotation];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点标注平滑移动";
    
  
    
    [self initData];
    
    [self initSubViews];
    
    [self locateMapViewInView:self.view frame:self.view.bounds completion:nil];
    
    self.mapView.showsUserLocation = NO;
    
    int count = sizeof(s_coords) / sizeof(s_coords[0]);
    
    double sum = 0;
 
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    
    for(int i = 0; i < count - 1; ++i)
    {
        CLLocation *begin = [[CLLocation alloc] initWithLatitude:s_coords[i].latitude longitude:s_coords[i].longitude];
        
        CLLocation *end = [[CLLocation alloc] initWithLatitude:s_coords[i+1].latitude longitude:s_coords[i+1].longitude];
        
        CLLocationDistance distance = [end distanceFromLocation:begin];
        
        [arr addObject:[NSNumber numberWithDouble:distance]];
        
        sum += distance;
    }
    
    self.distanceArray = arr;
    self.sumDistance = sum;
    
    NSLog(@"-----viewDidLoad-----");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"-----viewWillAppear-----");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
     NSLog(@"-----viewDidAppear-----");
}



- (void)addAnnotation
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(39.97617053371078, 116.3499049793749);
    
    self.car1 = [[MAAnimatedAnnotation alloc] init];
    self.car1.coordinate = coord;
    self.car1.title = @"Car1";
    
    
    
    __weak typeof(self) weakSelf = self;
    self.car2 = [[HHMovingAnnotation alloc] init];
    self.car2.coordinate = coord;
    self.car2.stepCallback = ^() {
        [weakSelf updatePassedTrace];
    };
    self.car2.title = @"Car2";
    
    
    [self.mapView addAnnotation:self.car1];
    [self.mapView addAnnotation:self.car2];
    
    
    [self.mapView setCenterCoordinate:coord animated:YES];
    
    self.mapView.zoomLevel = 16.5;

}


- (void)stopTimer
{
    TimerManager *manager = [TimerManager manager];
    
    [manager deleteTimerWithName:kTimerName];
}

//一定时间得到一个经纬度
- (void)startTimer
{

    TimerManager *manager = [TimerManager manager];
    [manager addTimerWithName:kTimerName timerSpace:60*2 timercb:^{
        
        int count = sizeof(s_coords) / sizeof(s_coords[0]);
        if (count <= self.index){
            return;
        }
        
        if (self.points.count == 5)
        {
            self.fivePoints = [NSArray arrayWithArray:self.points];
            
            [self.points removeAllObjects];
            
            [self carMove:self.fivePoints];
            
            NSLog(@"----points:%@----five:%@---",self.points,self.fivePoints);
        }
        
        
        CLLocationCoordinate2D coord = s_coords[_index];
        NSString * lat = [NSString stringWithFormat:@"%f",coord.latitude];
        NSString * lon = [NSString stringWithFormat:@"%f",coord.longitude];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              lat,@"lat",
                              lon,@"lon", nil];
        [self.points addObject:dict];
        
        NSLog(@"-----计时器:%ld-----",self.points.count);
        
        _index ++;
        
    }];
}


- (void)carMove:(NSArray *)array
{
    NSInteger count = array.count;
    
    CLLocationCoordinate2D coords[count];
    
    for (int i = 0; i < count; i++)
    {
        NSDictionary *dcit = array[i];
        
        CGFloat lat = [dcit[@"lat"] floatValue];
        
        CGFloat lon = [dcit[@"lon"] floatValue];
        
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat,lon);
        
        coords[i] = coor;
    }
  
    
    //NSLog(@"-----coords:%@-----",coords);
    
    
    //double speed = 120 / 3.6;
    
    self.car2.coordinate = coords[0];
    
    [self.car2 addMoveAnimationWithKeyCoordinates:coords count:count withDuration:count withName:nil completeCallback:^(BOOL isFinished) {
        
    }];
    
    
    
    
//    double speed_car1 = 120.0 / 3.6; //80 km/h
//
//    int count = sizeof(s_coords) / sizeof(s_coords[0]);
//
//    [self.car1 setCoordinate:s_coords[0]];
//
//    [self.car1 addMoveAnimationWithKeyCoordinates:s_coords count:count withDuration:self.sumDistance / speed_car1 withName:nil completeCallback:^(BOOL isFinished) {
//        ;
//    }];


    //小车2走过的轨迹置灰色, 采用添加多个动画方法
//    double speed_car2 = 100.0 / 3.6; //60 km/h
//    __weak typeof(self) weakSelf = self;
//    [self.car2 setCoordinate:s_coords[0]];
//    self.passedTraceCoordIndex = 0;
//    for(int i = 1; i < count; ++i) {
//        NSNumber *num = [self.distanceArray objectAtIndex:i - 1];
//        [self.car2 addMoveAnimationWithKeyCoordinates:&(s_coords[i]) count:1 withDuration:num.doubleValue / speed_car2 withName:nil completeCallback:^(BOOL isFinished) {
//            weakSelf.passedTraceCoordIndex = i;
//        }];
//    }
}





























- (void)initRoute
{
    int count = sizeof(s_coords) / sizeof(s_coords[0]);
    
    //self.fullTraceLine = [MAPolyline polylineWithCoordinates:s_coords count:count];
    //[self.mapView addOverlay:self.fullTraceLine];
    
    NSMutableArray * routeAnno = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        MAPointAnnotation * a = [[MAPointAnnotation alloc] init];
        a.coordinate = s_coords[i];
        a.title = @"route";
        [routeAnno addObject:a];
    }
    [self.mapView addAnnotations:routeAnno];
    [self.mapView showAnnotations:routeAnno animated:NO];
    
    self.car1 = [[MAAnimatedAnnotation alloc] init];
    [self.car1 setCoordinate:s_coords[0]];
    self.car1.title = @"Car1";
    
    
    __weak typeof(self) weakSelf = self;
    self.car2 = [[HHMovingAnnotation alloc] init];
    [self.car2 setCoordinate:s_coords[0]];
    self.car2.stepCallback = ^() {
        [weakSelf updatePassedTrace];
    };
    self.car2.title = @"Car2";
   
    
  
    [self.mapView addAnnotation:self.car1];
    [self.mapView addAnnotation:self.car2];
    
    
#if 0
    
    const int carCount = 100;
    self.carsArray = [NSMutableArray arrayWithCapacity:carCount];
    for(int i = 0; i < carCount; ++i) {
        MAAnimatedAnnotation *car = [[MAAnimatedAnnotation alloc] init];
        car.title = [NSString stringWithFormat:@"car_%d", i];
        float deltaX = ((float)(rand() % 100)) / 1000.0;
        float deltaY = ((float)(rand() % 100)) / 1000.0;
        car.coordinate = CLLocationCoordinate2DMake(39.97617053371078 + deltaX, 116.3499049793749 + deltaY);
        [self.carsArray addObject:car];
    }
    [self.mapView addAnnotations:self.carsArray];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        int temp = rand() % 10;
        for(int i = 0; i < carCount; ++i) {
            if(i % temp == 0) {
                MAAnimatedAnnotation *car = [self.carsArray objectAtIndex:i];
                float deltaX = ((float)(rand() % 10)) / 1000.0;
                float deltaY = ((float)(rand() % 10)) / 1000.0;
                CLLocationCoordinate2D coord = car.coordinate;
                if(i % 2 == 0) {
                    coord.latitude += deltaX;
                    coord.longitude += deltaY;
                } else {
                    coord.latitude -= deltaX;
                    coord.longitude -= deltaY;
                }
                [car addMoveAnimationWithKeyCoordinates:&coord count:1 withDuration:1 withName:nil completeCallback:^(BOOL isFinished) {
                    ;
                }];
            }
        }
    }];
#endif
    
}






- (void)initData
{
    self.points = [[NSMutableArray alloc]init];
    self.fivePoints = [[NSArray alloc]init];
    self.lastPoint = nil;
    self.index = 0;
}

- (void)initSubViews
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开" style:UIBarButtonItemStyleDone target:self action:@selector(startTimer)];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 100, 60, 40);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"move" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(mov) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(0, 200, 60, 40);
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 setTitle:@"stop" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
}


#pragma mark - Action


- (void)mov {
    double speed_car1 = 120.0 / 3.6; //80 km/h
    int count = sizeof(s_coords) / sizeof(s_coords[0]);
    [self.car1 setCoordinate:s_coords[0]];
    [self.car1 addMoveAnimationWithKeyCoordinates:s_coords count:count withDuration:self.sumDistance / speed_car1 withName:nil completeCallback:^(BOOL isFinished) {
        ;
    }];
    
    
    //小车2走过的轨迹置灰色, 采用添加多个动画方法
    double speed_car2 = 100.0 / 3.6; //60 km/h
    __weak typeof(self) weakSelf = self;
    [self.car2 setCoordinate:s_coords[0]];
    self.passedTraceCoordIndex = 0;
    for(int i = 1; i < count; ++i) {
        NSNumber *num = [self.distanceArray objectAtIndex:i - 1];
        [self.car2 addMoveAnimationWithKeyCoordinates:&(s_coords[i]) count:1 withDuration:num.doubleValue / speed_car2 withName:nil completeCallback:^(BOOL isFinished) {
            weakSelf.passedTraceCoordIndex = i;
        }];
    }
}

- (void)stop {
    for(MAAnnotationMoveAnimation *animation in [self.car1 allMoveAnimations]) {
        [animation cancel];
    }
    self.car1.movingDirection = 0;
    [self.car1 setCoordinate:s_coords[0]];
    
    for(MAAnnotationMoveAnimation *animation in [self.car2 allMoveAnimations]) {
        [animation cancel];
    }
    self.car2.movingDirection = 0;
    [self.car2 setCoordinate:s_coords[0]];
    
    if(self.passedTraceLine) {
        [self.mapView removeOverlay:self.passedTraceLine];
        self.passedTraceLine = nil;
    }
}



//小车2走过的轨迹置灰色
- (void)updatePassedTrace
{
    if(self.car2.isAnimationFinished) {
        return;
    }
    
    if(self.passedTraceLine) {
        [self.mapView removeOverlay:self.passedTraceLine];
    }
    
    int needCount = self.passedTraceCoordIndex + 2;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * needCount);
    
    memcpy(coords, s_coords, sizeof(CLLocationCoordinate2D) * (self.passedTraceCoordIndex + 1));
    coords[needCount - 1] = self.car2.coordinate;
    self.passedTraceLine = [MAPolyline polylineWithCoordinates:coords count:needCount];
    [self.mapView addOverlay:self.passedTraceLine];
    
    if(coords) {
        free(coords);
    }
}













- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if (annotation == self.car1 || [self.carsArray containsObject:annotation]) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier1";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout = YES;
            
            UIImage *imge  =  [UIImage imageNamed:@"car1"];
            annotationView.image =  imge;
            
            if(annotation == self.car1) {
                self.car1View = annotationView;
            }
        }
        
        return annotationView;
    } else if(annotation == self.car2) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier2";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout = YES;
            
            UIImage *imge  =  [UIImage imageNamed:@"car2"];
            annotationView.image =  imge;
            
            self.car2View = annotationView;
        }
        
        return annotationView;
    } else if([annotation isKindOfClass:[MAPointAnnotation class]]) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier3";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout = YES;
        }
        
        if ([annotation.title isEqualToString:@"route"]) {
            annotationView.enabled = NO;
            annotationView.image = [UIImage imageNamed:@"trackingPoints"];
        }
        
        [self.car1View.superview bringSubviewToFront:self.car1View];
        [self.car2View.superview bringSubviewToFront:self.car2View];
        
        return annotationView;
    }
    
    return nil;
}

- (MAPolylineRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if(overlay == self.fullTraceLine) {
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0.47 blue:1.0 alpha:0.9];
        
        return polylineView;
    } else if(overlay == self.passedTraceLine) {
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor grayColor];
        
        return polylineView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"cooridnate :%f, %f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
}






































- (void)dealloc
{
    [self stopTimer];
    NSLog(@"----释放---");
}



@end

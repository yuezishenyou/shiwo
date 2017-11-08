//
//  HHMainController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMainController.h"
#import "HHSlideView.h"
#import "HHLoginController.h"
#import "HHUserController.h"
#import <AFNetworking.h>
#import "UIView+animated.h"
#import "Global.h"
#import "HHMenuView.h"

#import "MANaviRoute.h"
#import "YDStartAnnotationView.h"
#import "YDStartPointAnnotation.h"


@interface HHMainController ()<AMapSearchDelegate>

@property (nonatomic, strong) HHSlideView *slideView;//侧滑面

@property (nonatomic, strong) HHMenuView *menuView;//底部

@property (nonatomic, strong) YDStartPointAnnotation *start;
@property (nonatomic, strong) MAPointAnnotation *end;

@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic, assign) NSInteger currentCourst;
@property (nonatomic, strong) MANaviRoute * naviRoute;




@property (nonatomic,strong)AMapDrivingRouteSearchRequest *drivingRouteSearchRequest;//驾车路径规划查询;



@end

@implementation HHMainController

- (void)backClick
{
    [self leftAction];
}
- (void)leftAction
{
    [self.slideView showAnimated:YES];
    [self.slideView setHeaderImageWithFirstLoad:YES];
}

- (void)loadView
{
    [super loadView];
    self.view.frame = [[UIScreen mainScreen]bounds];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleString = @"main";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initSubViews];
    
    [self addBlock];
    
    [self locateMapViewInView:self.view frame:self.view.bounds completion:nil];
    
}
















- (void)addBlock
{
    
    __weak typeof(self) weakSelf = self;
    
    
    [self.slideView setBlock:^(NSString *str) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        HHLoginController *vc = [[HHLoginController alloc]init];
        
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [self.slideView setSlideUserCtrolBlock:^(NSString *str) {

        HHUserController *vc = [[HHUserController alloc]init];
    
        
        [vc setChangeHeaderImage:^{
            NSLog(@"-----事件响应-----");
            [weakSelf.slideView setHeaderImageWithFirstLoad:NO];
        }];

        [weakSelf.navigationController pushViewController:vc animated:YES];

    }];
    
    
    //
    [self.menuView setSubmitOrderBlock:^{
        
        NSLog(@"---提交订单---");
        //lat:31.232080,lon:121.365597
        //lat:31.232080,lon:121.365597
        [weakSelf submitOrder];
        
    }];
    
    
    [self.menuView setCancelOrderBlock:^{
        [weakSelf cancelOrder];
    }];
    
    
}


- (void)submitOrder
{
    
    [self clearMap];
    
    self.start = [[YDStartPointAnnotation alloc]init];
    self.start.coordinate = CLLocationCoordinate2DMake(31.232080, 121.365597);

    self.end = [[MAPointAnnotation alloc]init];
    self.end.coordinate = CLLocationCoordinate2DMake(31.232580, 121.313597);
    
    [self.mapView addAnnotation:self.start];
    [self.mapView addAnnotation:self.end];
    
     [self.mapView setCenterCoordinate:self.start.coordinate animated:YES];

    
    [self searchDriveRouteWithStartAnnotation:self.start destinationAnnotation:self.end];//发起路选规划

}

- (void)cancelOrder
{
    [self clearMap];
}



//路线回调
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    NSLog(@"-----路线规划回调-----");
    if (response.route == nil) {
        return ;
    }

    self.route = response.route;
    self.currentCourst = 0;
    
    if (response.count > 0) {
        [self presentCurrentCourse];
    }
}

- (void)presentCurrentCourse
{
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
    
    AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:self.start.coordinate.latitude longitude:self.start.coordinate.longitude];
    
    AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:self.end.coordinate.latitude longitude:self.end.coordinate.longitude];
    
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourst] withNaviType:type
                                       showTraffic:YES
                                        startPoint:startPoint
                                          endPoint:endPoint];
    
     [self.naviRoute addToMapView:self.mapView];
    
    
    /* 缩放地图使其适应polylines的展示. */
    
    
    
//    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
//                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
//                           animated:YES];
   
    
}


- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    
    NSLog(@"---------- abc -------------");
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDash = YES;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {//自定义的线
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 10;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    
    return nil;
}


#pragma mark -----------大头针生成-------------
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {//定位点
        static NSString *transparentuserLocationStyleReuseIndetifier = @"asuserLocationStyleReuseIndetifier1";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:transparentuserLocationStyleReuseIndetifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:transparentuserLocationStyleReuseIndetifier];
            UIImage *userLocation;
            userLocation = [UIImage imageNamed:@"scheduellist_end_icon"];
            annotationView.image = userLocation;
            annotationView.zIndex = 1;
        }
        
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[YDStartPointAnnotation class]]) {
        static NSString *startIdentifier = @"startIdentifier";
        
        YDStartAnnotationView *annotationView = (YDStartAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:startIdentifier];
        if (annotationView == nil) {
            annotationView = [[YDStartAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:startIdentifier];
        }
        annotationView.portrait = [UIImage imageNamed:@"scheduellist_end_icon"];
        
        return annotationView;
        
    }
    
    
    
    return nil;
}























#pragma mark - 初始化侧栏按钮
-(void)initSubViews
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"侧滑" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    self.menuView = [[HHMenuView alloc]initWithFrame:CGRectMake(0, kScreenH - 80, kScreenW, 80)];
    
    [self.view addSubview:self.menuView];
    
    
    
    
    
    
    
    
    
    
    self.slideView = [[HHSlideView alloc]initWithSupView:self.view];
    [self.view bringSubviewToFront:self.slideView];
    
}




@end

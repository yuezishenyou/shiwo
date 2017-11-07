//
//  HHAMapHelper.h
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHBaseController.h"
//基础定位类
#import <AMapFoundationKit/AMapFoundationKit.h>
//高德地图基础类
#import <MAMapKit/MAMapKit.h>
//搜索基础类
#import <AMapSearchKit/AMapSearchKit.h>
//高德导航类
#import <AMapNaviKit/AMapNaviKit.h>



typedef void(^HYBUserLocationCompletion)(BOOL finish);

@interface HHAMapHelper : HHBaseController

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) AMapSearchAPI *search;

@property (nonatomic,copy)   HYBUserLocationCompletion locationCompletion;

@property (nonatomic,strong) CLLocation *currentLocation;

@property (nonatomic,weak)   UIView *supView;




//------------------------------------------------------------------



/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@property (nonatomic, strong) MAPointAnnotation *startAnnotation;

@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;




- (void)locateMapViewInView:(UIView *)mapSuerView
                      frame:(CGRect)frame
             completion:(HYBUserLocationCompletion)completion;


- (void)viewDidDeallocOrReceiveMemoryWarning;





// ----------------------------------------------------------------------------------------
// MARK: - 大头针生成
// ----------------------------------------------------------------------------------------

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation;















// ----------------------------------------------------------------------------------------
// MARK: - 用户定位
// ----------------------------------------------------------------------------------------

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error;


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation;











// ----------------------------------------------------------------------------------------
// MARK: - 查询、请求
// ----------------------------------------------------------------------------------------

- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate;


- (void)searchDriveRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                      destinationCoordinate:(CLLocationCoordinate2D)destinationCoordinate;

- (void)searchPOIKeywords:(NSString *)keywords;







// ----------------------------------------------------------------------------------------
// MARK: - 查询、请求 回调
// ----------------------------------------------------------------------------------------

-(void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error;

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response;

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response;

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response;






// ----------------------------------------------------------------------------------------
// MARK: - 地图接口调用
// ----------------------------------------------------------------------------------------

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction;

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated;


















// ----------------------------------------------------------------------------------------
// MARK: - Util
// ----------------------------------------------------------------------------------------

- (CGFloat)mapDistanceBetweenCoordinate:(CLLocationCoordinate2D )coordinateA AndCoordinate:(CLLocationCoordinate2D)coordinateB;












@end


























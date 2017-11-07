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

@interface HHMainController ()<AMapSearchDelegate>

@property (nonatomic, strong) HHSlideView *slideView;//侧滑面

@property (nonatomic, strong) HHMenuView *menuView;//底部

@property (nonatomic, strong) MAPointAnnotation *start;
@property (nonatomic, strong) MAPointAnnotation *end;




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
    
    
}


- (void)submitOrder
{
    [self clearMap];
    
    self.start = [[MAPointAnnotation alloc]init];
    self.start.coordinate = CLLocationCoordinate2DMake(31.232080, 121.365597);

    self.end = [[MAPointAnnotation alloc]init];
    self.end.coordinate = CLLocationCoordinate2DMake(31.232580, 121.313597);
    
    [self.mapView addAnnotation:self.start];
    [self.mapView addAnnotation:self.end];
    
     [self.mapView setCenterCoordinate:self.start.coordinate animated:YES];

    
    
    
    
    
    //[self searchDriveRouteWithStartAnnotation:self.start destinationAnnotation:self.end];
    
    //[self searchReGeocodeWithCoordinate:self.start.coordinate];
}











- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    [super mapView:mapView viewForAnnotation:annotation];
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

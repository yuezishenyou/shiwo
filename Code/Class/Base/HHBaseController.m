//
//  HHBaseController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHBaseController.h"



@interface HHBaseController ()

@property (nonatomic, strong) UILabel *titleLab;


@end

@implementation HHBaseController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //[self setNavigationController];
    
}

- (void)setNavigationController
{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, KNavigationH)];
    
    _navView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_navView];
    
    
    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *BlurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    ((UIVisualEffectView *)BlurView).frame = _navView.bounds;
    
    BlurView.alpha = 1;
    
    [_navView addSubview:BlurView];

    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, KNavigationH - 1, kScreenW, 0.5)];
    
    line.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    [_navView addSubview:line];
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, kStatusH, kNavH + 10 , kNavH);
    self.leftBtn.backgroundColor = [UIColor redColor];
    [self.leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:self.leftBtn];
    
    

}


- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    self.titleLab.text = titleString;
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        CGRect rect = CGRectMake((kScreenW - 200)/2, kStatusH, 200, kNavH);
        _titleLab = [[UILabel alloc]initWithFrame:rect];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:18];
        [_navView addSubview:_titleLab];
    }
    return _titleLab;
}





- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}








- (instancetype)initWithNibVCName:(NSString *)vcName
{
    NibType type;
    if ([[UIDevice currentDevice]userInterfaceIdiom]== UIUserInterfaceIdiomPhone) {
        type = NibTypeiPhone;
    }else{
        type = NibTypeiPad;
    }
    return [self initWithVCName:vcName nibType:type];
}

- (instancetype)initWithVCName:(NSString *)vcName nibType:(NibType)type
{
    NSString *xib_name ;
    
    if(type == NibTypeiPhone){
        xib_name = [NSString stringWithFormat:@"%@_iPhone",vcName];
    }
    else if (type == NibTypeiPad ){
        xib_name = [NSString stringWithFormat:@"%@_iPad",vcName];
    }
    self = [super initWithNibName:xib_name bundle:nil];

    return self;
}



























- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"--xxx--");
}









@end

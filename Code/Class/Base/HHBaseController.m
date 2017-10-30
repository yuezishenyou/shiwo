//
//  HHBaseController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHBaseController.h"



@interface HHBaseController ()

@end

@implementation HHBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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

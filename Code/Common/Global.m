//
//  Global.m
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (instancetype)manager
{
    static Global *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[Global alloc]init];
        }
    });
    return _manager;
}

- (void)readChangeHeaderImage:(ChangeHeaderImageBlock)block{
    _changeHeaderImageBlock = [block copy];
}
- (void)setChangeHeaderImage:(UIImage *)image{
    if (_changeHeaderImageBlock) {
        _changeHeaderImageBlock();
    }
    
}





@end

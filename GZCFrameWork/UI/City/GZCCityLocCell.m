//
//  GZCCityLocCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/28.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCCityLocCell.h"
#import <AMapLocationKit/AMapLocationKit.h>

@implementation GZCCityLocCell{
    AMapLocationManager *locationManager;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        
        _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 1, size.width-30, size.height-1)];
        _cityLabel.font = [UIFont systemFontOfSize:16];
        _cityLabel.text = @"正在定位...";
        [self.contentView addSubview:_cityLabel];
        
        UILabel *placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width-15, size.height)];
        placeLabel.font = [UIFont systemFontOfSize:14];
        placeLabel.textColor = [UIColor lightGrayColor];
        placeLabel.text = @"定位城市";
        placeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:placeLabel];
        
        [self beginLocation];
    }
    return self;
}

-(void)beginLocation{
    //设置定位的key
    [AMapLocationServices sharedServices].apiKey =LocationKey;
    locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，可修改，最小2s
    locationManager.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    locationManager.reGeocodeTimeout = 3;
    
    // 带逆地理（返回坐标和地址信息）
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            GZCLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                _cityLabel.text = @"定位失败";
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSString *cityStr = regeocode.city ;
            NSRange range = [cityStr rangeOfString:@"市"];
            if (range.length>0) {
                cityStr = [cityStr substringToIndex:range.location];
            }
            _cityLabel.text = cityStr;
            GZCLog(@"%@",regeocode);
        }
    }];
}

@end

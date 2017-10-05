//
//  CityListViewController.h
//  citylistdemo
//
//  Created by BW on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

/**
 info.plist中添加
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 及
 NSLocationAlwaysUsageDescription
 或者
 NSLocationWhenInUseUsageDescription //推荐
 
 设置enable bitcode 为no
 */

#import "GZCViewController.h"


@protocol CityListViewControllerDelegate
- (void) citySelectionUpdate:(NSString*)selectedCity;
- (NSString*) getDefaultCity;
- (NSArray <__kindof NSString*>*) getHotCity;
@end


@interface CityListViewController : GZCViewController {
    NSDictionary *cities;  
    NSArray *keys;
    UITableView *tbView;
}
@property (nonatomic, retain) IBOutlet UITableView *tbView;

@property (nonatomic, retain) NSDictionary *cities;  
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, assign) id<CityListViewControllerDelegate> delegate;

//- (IBAction)pressReturn:(id)sender;
@end


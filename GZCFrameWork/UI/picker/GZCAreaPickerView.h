//
//  GZCAreaPickerView.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZCLocation.h"
#import "GZCFramework.h"

typedef enum {
    GZCAreaPickerWithStateAndCity,
    GZCAreaPickerWithStateAndCityAndDistrict
} GZCAreaPickerStyle;

@class GZCAreaPickerView;

@protocol GZCAreaPickerDatasource <NSObject>

- (NSArray *)areaPickerData:(GZCAreaPickerView *)picker;

@end

@protocol GZCAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(GZCAreaPickerView *)picker;

@end

@interface GZCAreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (assign, nonatomic) id <GZCAreaPickerDelegate> delegate;
@property (assign, nonatomic) id <GZCAreaPickerDatasource> datasource;
@property (strong, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (strong, nonatomic) GZCLocation *locate;
@property (nonatomic) GZCAreaPickerStyle pickerStyle;

- (id)initWithStyle:(GZCAreaPickerStyle)pickerStyle withDelegate:(id <GZCAreaPickerDelegate>)delegate andDatasource:(id <GZCAreaPickerDatasource>)datasource;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end

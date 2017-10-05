//
//  CustomIrregularGridViewCell.m
//  IrregularGridCollectionView
//
//  Created by YouXianMing on 16/8/30.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "CustomIrregularGridViewCell.h"

@implementation CustomIrregularGridViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupCell];
        
        [self buildSubview];
        
        [self configLayout];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)configLayout{
    
}

- (void)loadContent {
    
}

- (void)willDisplay {

}

- (void)didEndDisplay {

}

+(float)cellHeight{
    return 0;
}

- (void)selectedEvent:(id)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customIrregularGridViewCell:event:)]) {
        [self.delegate customIrregularGridViewCell:self event:event];
    }
}

+ (IrregularGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type itemWidth:(CGFloat)itemWidth itemHeight:(CGFloat)itemHeight{
    
    NSString *identifierString = nil;
    reuseIdentifier.length    <= 0 ? (identifierString = NSStringFromClass([self class])) : (identifierString = reuseIdentifier);
    
    return [IrregularGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:identifierString data:data cellType:type itemWidth:itemWidth itemHeight:itemHeight];
}

+ (IrregularGridCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data itemWidth:(CGFloat)itemWidth itemHeight:(CGFloat)itemHeight{
    
    NSString *identifierString = nil;
    reuseIdentifier.length    <= 0 ? (identifierString = NSStringFromClass([self class])) : (identifierString = reuseIdentifier);
    
    return [IrregularGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:identifierString data:data cellType:0 itemWidth:itemWidth itemHeight:itemHeight];
}

+ (IrregularGridCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type itemWidth:(CGFloat)itemWidth itemHeight:(CGFloat)itemHeight{
    
    return [IrregularGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:type itemWidth:itemWidth itemHeight:itemHeight];
}

+ (IrregularGridCellDataAdapter *)dataAdapterWithData:(id)data itemWidth:(CGFloat)itemWidth itemHeight:(CGFloat)itemHeight{
    
    return [IrregularGridCellDataAdapter collectionGridCellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:data cellType:0 itemWidth:itemWidth itemHeight:itemHeight];
}

@end

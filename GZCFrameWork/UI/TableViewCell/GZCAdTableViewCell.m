//
//  GZCAddTableViewCell.m
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCAdTableViewCell.h"
#import "JxbAdPageView.h"

@implementation GZCAdModel

@end

@interface GZCAdTableViewCell()<JxbAdPageViewDelegate>{
}

@end

@implementation GZCAdTableViewCell{
    JxbAdPageView      *adPage;
    NSArray            *adArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 150)]) {
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        adPage = [[JxbAdPageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        adPage.delegate = self;
        [self.contentView addSubview:adPage];
    }
    return self;
}

-(void)setBlock:(AdTaped)block{
    self.tapBlock = block;
}

-(void)setAdModels:(NSArray<__kindof GZCAdModel *> *)adModels{
    adArray = adModels;
    NSMutableArray *imageArray = [NSMutableArray array];
    for (GZCAdModel *ad in adArray) {
        [imageArray addObject:ad.url];
    }
    [adPage setAds:imageArray];
    [adPage setPageTintColor:[UIColor whiteColor]];
    [adPage setPageCurrentColor:mainColor];
}

-(void)setAdUrls:(NSArray<__kindof NSString *> *)adModels{
    [adPage setAds:adModels];
    [adPage setPageTintColor:[UIColor whiteColor]];
    [adPage setPageCurrentColor:mainColor];
}

-(void)setHeight:(float)height{
    adPage.frame = CGRectMake(0, 0, WIDTH(adPage), height);
}

#pragma mark - ImagePlayerDelegate
- (void)click:(int)index
{
    if (_tapBlock) {
        _tapBlock([adArray objectAtIndex:index],index);
    }
}

@end

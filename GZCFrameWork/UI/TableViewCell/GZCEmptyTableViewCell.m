//
//  GZCEmptyTableViewCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/17.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCEmptyTableViewCell.h"

@implementation GZCEmptyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)cellWithHeight:(float)height onTableView:(UITableView *)tableview{
    static NSString *emptyCell = @"GZCEmptyTableViewCell";
    GZCEmptyTableViewCell *cell = (GZCEmptyTableViewCell*)[tableview  dequeueReusableCellWithIdentifier:emptyCell];
    if(cell == nil)
    {
        cell = [[GZCEmptyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emptyCell size:CGSizeMake(mainWidth, height)];
    }
    return cell;
}

@end

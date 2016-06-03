//
//  GZCMenuTopPopView.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCMenuMultileTableView.h"
#import "GZCConstant.h"
#import "GZCMenuLeftCell.h"
#import "GZCMenuRightCell.h"

@interface GZCMenuMultileTableView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;


@end

@implementation GZCMenuMultileTableView{
    GZCMenuLeftCell *selectedLeftCell;
    GZCMenuRightCell *selectedRightCell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:.2f alpha:.3f];
        
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.bounces = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTaped)];
        tap.delegate = self;
        [_leftTableView addGestureRecognizer:tap];
        [self addSubview:_leftTableView];
        
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.bounces = NO;
        [self addSubview:_rightTableView];
        
        //设置默认值
        self.leftBgColor = [UIColor clearColor];
        self.leftSelectBgColor = [UIColor whiteColor];
        self.rightBgColor = [UIColor clearColor];
        self.rightSelectBgColor = [UIColor whiteColor];
        self.leftSelectColor = mainColor;
        self.rightSelectColor = mainColor;
        self.leftUnSelectColor = mainFontColor;
        self.rightUnSelectColor = mainFontColor;
        self.leftUnSelectBgColor = [UIColor whiteColor];
        self.rightUnSelectBgColor = [UIColor whiteColor];
        self.separatorColor = mainLineColor;
        self.leftWidth = mainWidth;
        self.menuColumn = 1;
    }
    return self;
}

-(void)setLeftData:(NSArray<__kindof NSString *> *)leftData{
    _leftData = leftData;
    [self.leftTableView reloadData];
}

-(void)setRightData:(NSArray<__kindof NSString *> *)rightData{
    _rightData = rightData;
    [self.rightTableView reloadData];
}

-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor = leftBgColor;
    _leftTableView.backgroundColor = _leftBgColor;
}

-(void)setRightBgColor:(UIColor *)rightBgColor{
    _rightBgColor = rightBgColor;
    _rightTableView.backgroundColor = _rightBgColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.menuColumn == 1) {
        _leftTableView.frame = CGRectMake(0, 0, WIDTH(self), HEIGHT(self));
        _rightTableView.frame = CGRectZero;
    }else{
        _leftTableView.frame = CGRectMake(0, 0, self.leftWidth, HEIGHT(self));
        _rightTableView.frame = CGRectMake(self.leftWidth, 0, WIDTH(self)-self.leftWidth, HEIGHT(self));
    }
}

-(void)setLeftSelectedAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedLeftCell) {
        [selectedLeftCell setSelected:NO];
    }
    GZCMenuLeftCell *cell = (GZCMenuLeftCell*)[_leftTableView  cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES];
    selectedLeftCell = cell;
}

-(void)setRightSelectedAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedLeftCell) {
        [selectedLeftCell setSelected:NO];
    }
    GZCMenuLeftCell *cell = (GZCMenuLeftCell*)[_rightTableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES];
    selectedLeftCell = cell;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}

-(void)bgTaped{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GZCMenuMultileTableViewBackgoundTaped:)]) {
        [self.delegate GZCMenuMultileTableViewBackgoundTaped:self];
    }
}

#pragma mark - tableview Delegate/Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_leftTableView]) {
        return [_leftData count];
    }else{
        return [_rightData count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTableView]) {
        static NSString *leftId = @"GZCMenuLeftCell";
        GZCMenuLeftCell *cell = (GZCMenuLeftCell*)[tableView  dequeueReusableCellWithIdentifier:leftId];
        if(cell == nil)
        {
            cell = [[GZCMenuLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftId];
            cell.size = CGSizeMake(self.leftWidth, 40);
            cell.selctedColor = self.leftSelectColor;
            cell.normalColor = self.leftUnSelectColor;
            cell.lineColor = self.separatorColor;
            cell.selctedBgColor = self.leftSelectBgColor;
            cell.normalBgColor = self.leftUnSelectBgColor;
            [cell setSelected:NO];
        }
        cell.titleLabel.text = _leftData[indexPath.row];
        return cell;
    }else{
        static NSString *rightId = @"GZCMenuRightCell";
        GZCMenuRightCell *cell = (GZCMenuRightCell*)[tableView  dequeueReusableCellWithIdentifier:rightId];
        if(cell == nil)
        {
            cell = [[GZCMenuRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightId];
            cell.size = CGSizeMake(mainWidth - self.leftWidth, 40);
            cell.selctedColor = self.rightSelectColor;
            cell.normalColor = self.rightUnSelectColor;
            cell.lineColor = self.separatorColor;
            cell.selctedBgColor = self.rightSelectBgColor;
            cell.normalBgColor = self.rightUnSelectBgColor;
            [cell setSelected:NO];
        }
        cell.titleLabel.text = _rightData[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTableView]) {
        if (selectedLeftCell) {
            [selectedLeftCell setSelected:NO];
        }
        GZCMenuLeftCell *cell = (GZCMenuLeftCell*)[tableView  cellForRowAtIndexPath:indexPath];
        [cell setSelected:YES];
        selectedLeftCell = cell;
        if (self.delegate && [self.delegate respondsToSelector:@selector(GZCMenuMultileTableView:leftTableCellTaped:atIndex:)]) {
            [self.delegate GZCMenuMultileTableView:self leftTableCellTaped:cell.titleLabel.text atIndex:indexPath];
        }
    }else{
        if (selectedRightCell) {
            [selectedRightCell setSelected:NO];
        }
        GZCMenuRightCell *cell = (GZCMenuRightCell*)[tableView  cellForRowAtIndexPath:indexPath];
        [cell setSelected:YES];
        selectedRightCell = cell;
        if (self.delegate && [self.delegate respondsToSelector:@selector(GZCMenuMultileTableView:rightTableCellTaped:atIndex:)]) {
            [self.delegate GZCMenuMultileTableView:self rightTableCellTaped:cell.titleLabel.text atIndex:indexPath];
        }
    }
}

@end

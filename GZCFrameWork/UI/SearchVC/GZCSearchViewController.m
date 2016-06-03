//
//  SearchViewController.m
//  MeiJiaXiu
//
//  Created by GuoZhongCheng on 16/2/19.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCSearchViewController.h"
#import "UIImage+RenderedImage.h"
#import "SearchButtonsView.h"

@interface GZCSearchViewController ()<UISearchBarDelegate,SearchButtonsViewDelegate>{
    UISearchBar *_searchBar;
    UIScrollView *searchScroll;
    SearchButtonsView *hotsView;
    SearchButtonsView *historysView;
}

@end

@implementation GZCSearchViewController
@synthesize segmentControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    [self setNavBar];
    [_searchBar becomeFirstResponder];
    [self.view setBackgroundColor:[UIColor hexFloatColor:@"f1f2f3"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)endEdit{
    [_searchBar endEditing:YES];
}

-(void)setSearchPlaceHolder:(NSString *)searchPlaceHolder{
    _searchPlaceHolder = searchPlaceHolder;
    _searchBar.placeholder = searchPlaceHolder;
    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    searchField.textColor=NAVBAR_TITLE_COLOR;
    [searchField setValue:NAVBAR_TITLE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setSearchBar{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 44)];
    _searchBar.tintColor = NAVBAR_TITLE_COLOR;
    _searchBar.delegate = self;
    _searchBar.backgroundImage = [UIImage imageWithRenderColor:[UIColor clearColor] renderSize:CGSizeMake(10, 40)];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithRenderColor:mainColor renderSize:CGSizeMake(mainWidth-65-40, 30) radius:15] forState:UIControlStateNormal];
    [_searchBar setImage:[UIImage imageNamed:@"ic_search_shop_drawable_left"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_searchBar setSearchTextPositionAdjustment:UIOffsetMake(10, 0)];
    [_searchBar setPositionAdjustment:UIOffsetMake(10, 0) forSearchBarIcon:UISearchBarIconSearch];
    _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    self.navigationItem.titleView = _searchBar;
}

-(void)setNavBar{
    self.navigationItem.hidesBackButton = YES;
    [self setSearchBar];
    [self actionCustomRightBtnWithNrlImage:nil htlImage:nil title:@"取消" action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navRightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navRightBtn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateNormal];
    [self.navRightBtn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateHighlighted];
}

-(void)setSegmentTitles:(NSArray *)segmentTitles{
    _segmentTitles = segmentTitles;
    if (segmentControl!=nil) {
        [segmentControl removeFromSuperview];
        segmentControl = nil;
    }
    segmentControl = [[UISegmentedControl alloc]initWithItems:segmentTitles];
    segmentControl.tintColor = [UIColor grayColor];
    segmentControl.frame = CGRectMake(20,10, mainWidth-40, 30);
    [segmentControl addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
}

-(void)segmentChange:(UISegmentedControl *)s{
    _searchBar.placeholder = [NSString stringWithFormat:@"搜索%@",self.segmentTitles[segmentControl.selectedSegmentIndex]];
}

-(void)setSearchedHots:(NSArray*)hots historys:(NSArray*)historys{
    if (searchScroll!= nil) {
        for (UIView *view in [searchScroll subviews]) {
            [view removeFromSuperview];
        }
        [searchScroll removeFromSuperview];
        searchScroll = nil;
    }
    searchScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, mainWidth, mainHeight - 44-50)];
    [self.view addSubview:searchScroll];
    
    float offsetY = 0;
    if([hots count]>0){
        hotsView = [[SearchButtonsView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 0) icon:@"icon_hot_search_activity" title: @"热门搜索" items:hots];
        [hotsView setDelegate:self];
        [searchScroll addSubview:hotsView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hotsView.frame), mainWidth, 1)];
        line.backgroundColor = [UIColor hexFloatColor:@"e6e6e6"];
        [searchScroll addSubview:line];
        offsetY += CGRectGetMaxY(line.frame)+10;
    }
    
    if ([historys count]>0) {
        historysView = [[SearchButtonsView alloc]initWithFrame:CGRectMake(0, offsetY, mainWidth, 0) icon:@"icon_history_search_activity" title: @"历史搜索" items:historys];
        
        [historysView setDelegate:self];
        [searchScroll addSubview:historysView];
        
        [self setClearView];
    }
    
}

-(void)setClearView{
    UIView *clearBg = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(historysView.frame)+10, mainWidth, 55)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 1)];
    line.backgroundColor = [UIColor hexFloatColor:@"e6e6e6"];
    [clearBg addSubview:line];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitle:@"清空历史纪录" forState:UIControlStateNormal];
    [clearButton setImage:[[UIImage imageNamed:@"icon_clear_all_search_activity"] reSizeToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [clearButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [clearButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:14];
    clearButton.frame = CGRectMake(0, 1, mainWidth, 54);
    [clearBg addSubview:clearButton];
    
    [searchScroll addSubview:clearBg];
}

-(void)showSearchResoult:(NSString *)searchText{
    [self endEdit];
}

#pragma mark - searchButtonsDelegate
-(void)searchButtonsView:(SearchButtonsView *)searchbuttonsview titleDidTaped:(NSString *)title atIndex:(NSInteger)index{
    [self showSearchResoult:title];
}

#pragma mark - searchbarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self showSearchResoult:searchBar.text];
}

@end

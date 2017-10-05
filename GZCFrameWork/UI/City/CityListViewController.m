//
//  CityListViewController.m
//
//  Created by Big Watermelon on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CityListViewController.h"
#import "UIImage+RenderedImage.h"
#import "GZCCityLocCell.h"
#import "GZCCityHotCell.h"

@interface CityListViewController ()<UITableViewDelegate,UITableViewDataSource,GZCCityHotCellDelegate>
@property NSUInteger curSection;
@property NSUInteger curRow;
@property NSUInteger defaultSelectionRow;
@property NSUInteger defaultSelectionSection;
@end

@implementation CityListViewController
@synthesize tbView;

@synthesize cities, keys, curSection, curRow, delegate;
@synthesize defaultSelectionRow, defaultSelectionSection;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    
    [self setTableView];
    
    [self getCitys];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.keys = nil;
    self.cities = nil;
    self.tbView = nil;
}

-(void)setNavigation{
    if (self.navigationController==nil) {
        //创建navbar
        UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, mainWidth, 44)];
        //创建navbaritem
        [nav setBackgroundImage:[UIImage imageWithRenderColor:NAVBAR_COLOR renderSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
        UINavigationItem *NavTitle = [[UINavigationItem alloc] init];
        UILabel *titleL = [[UILabel alloc]init];
        titleL.text = @"选择城市";
        titleL.font = [UIFont systemFontOfSize:17];
        titleL.textColor = NAVBAR_TITLE_COLOR;
        [titleL sizeToFit];
        NavTitle.titleView = titleL;
        [nav pushNavigationItem:NavTitle animated:YES];
        [self.view addSubview:nav];
        
        [self actionCustomLeftBtnWithNrlImage:nil htlImage:nil title:@"取消" action:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [self.navLeftBtn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateNormal];
        NavTitle.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
        
//        [self actionCustomRightBtnWithNrlImage:nil htlImage:nil title:@"确定" action:^{
//            [self pressReturn:self.navRightBtn];
//        }];
//        [self.navRightBtn setTitleColor:mainColor forState:UIControlStateNormal];
//        NavTitle.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.navRightBtn];
    }else{
        self.title = @"选择城市";
        [self actionCustomLeftBtnWithNrlImage:nil htlImage:nil title:@"取消" action:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self.navLeftBtn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateNormal];
        
//        [self actionCustomRightBtnWithNrlImage:nil htlImage:nil title:@"确定" action:^{
//            [self pressReturn:self.navRightBtn];
//        }];
//        [self.navRightBtn setTitleColor:mainColor forState:UIControlStateNormal];
    }
}

-(void)setTableView{
    float offY = 0;
    if (self.navigationController==nil) {
        offY = 64;
    }
    self.tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, offY, mainWidth, mainHeight-64) style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.tintColor = mainColor;
    [self.view addSubview:self.tbView];
}

-(void)getCitys{
    curRow = NSNotFound;
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [[NSDictionary alloc]
                   initWithContentsOfFile:path];
    
    self.keys = [[cities allKeys] sortedArrayUsingSelector:
                 @selector(compare:)];
    
    
    //get default selection from delegate
    NSString* defaultCity = [delegate getDefaultCity];
    if (defaultCity) {
        NSArray *citySection;
        self.defaultSelectionRow = NSNotFound;
        //set table index to this city if it existed
        for (NSString* key in keys) {
            citySection = [cities objectForKey:key];
            self.defaultSelectionRow = [citySection indexOfObject:defaultCity];
            if (NSNotFound == defaultSelectionRow)
                continue;
            //found match recoard position
            self.defaultSelectionSection = [keys indexOfObject:key];
            break;
        }
        
        if (NSNotFound != defaultSelectionRow) {
            
            self.curSection = defaultSelectionSection;
            self.curRow = defaultSelectionRow;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:defaultSelectionRow inSection:defaultSelectionSection];
            [self.tbView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
        }
    }
}

-(void)dissMiss{
    if (self.navigationController==nil) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - cellDelegate
-(void)hotCell:(GZCCityHotCell *)cell tapedCity:(NSString *)city{
    [delegate citySelectionUpdate:city];
    GZCLog(@"%@",city);
    [self dissMiss];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [keys count]+3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return 170;
    }
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section<3) {
        return 1;
    }
    NSString *key = [keys objectAtIndex:section-3];
    NSArray *citySection = [cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *loctionCell = @"LOCTIONCELL";
        GZCCityLocCell *cell = (GZCCityLocCell*)[tableView  dequeueReusableCellWithIdentifier:loctionCell];
        if(cell == nil)
        {
            cell = [[GZCCityLocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loctionCell size:CGSizeMake(mainWidth, 45)];
        }
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *hotCell = @"HOTCELL";
        GZCCityHotCell *cell = (GZCCityHotCell*)[tableView  dequeueReusableCellWithIdentifier:hotCell];
        if(cell == nil)
        {
            cell = [[GZCCityHotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotCell size:CGSizeMake(mainWidth, 170)];
            cell.delegate = self;
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    // Configure the cell...
    if (indexPath.section == 1) {
        cell.textLabel.text = @"全部城市";
    }else
    {
        NSString *key = [keys objectAtIndex:indexPath.section-3];
        cell.textLabel.text = [[cities objectForKey:key] objectAtIndex:indexPath.row];
    }
    if (indexPath.section == curSection && indexPath.row == curRow)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section<3) {
        return nil;
    }
    NSString *key = [keys objectAtIndex:section-3];
    return key;  
}  

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView  
{  
    return keys;  
} 


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return;
    }
    //clear previous
//    NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:curRow inSection:curSection];
//    UITableViewCell* cell = [tableView cellForRowAtIndexPath:prevIndexPath];
//    cell.accessoryType = UITableViewCellAccessoryNone;
    
//    curSection = indexPath.section;
//    curRow = indexPath.row;
//    
//    //add new check mark
//    cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSString* city = nil;
    if (indexPath.section == 0) {
        NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        GZCCityLocCell* cell = [tbView cellForRowAtIndexPath:prevIndexPath];
        city = cell.cityLabel.text;
    }else
    if(indexPath.section == 1){
        city = @"全部城市";
    }else
    if (indexPath.section > 2) {
        if (indexPath.row != NSNotFound) {
            city =[[cities objectForKey:[keys objectAtIndex:indexPath.section-3]] objectAtIndex:indexPath.row];
        }
    }
    if (city != nil) {
        GZCLog(@"%@",city);
        [delegate citySelectionUpdate:city];
    }
    
    [self dissMiss];
}

//- (IBAction)pressReturn:(id)sender {
//    //notify delegate user selection if it different with default
//     NSString* city = nil;
//    if (curSection == 0) {
//        NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        GZCCityLocCell* cell = [tbView cellForRowAtIndexPath:prevIndexPath];
//        city = cell.cityLabel.text;
//    }else
//    if(curSection == 1){
//        city = @"全部城市";
//    }else
//    if (curSection > 2) {
//        if (curRow != NSNotFound) {
//            city =[[cities objectForKey:[keys objectAtIndex:curSection-3]] objectAtIndex:curRow];
//        }
//    }
//    if (city != nil) {
//        GZCLog(@"%@",city);
//        [delegate citySelectionUpdate:city];
//    }
//    
//    [self dissMiss];
//}


@end

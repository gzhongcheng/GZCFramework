//
//  GZCTableViewController.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/13.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCViewController.h"

@interface GZCTableViewController : GZCViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, null_resettable) UITableView *tableView;

@end

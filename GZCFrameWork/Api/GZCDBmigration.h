//
//  GZCDBmigration.h
//  LXJLB
//
//  Created by GuoZhongCheng on 16/9/27.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#ifndef GZCDBmigration_h
#define GZCDBmigration_h

@protocol GZCDBMigrationProtocol

@required

/**
 *  返回该类数据的版本
 *
 *  @param
 *
 *  @return 版本 - unsigned int 的 NSNumber  加入没有实现protocol默认为0, 第一个版本的class也请写为0.
 */
- (NSNumber *) dataVersionOfClass;

/**
 *  返回该类数据的primaryKey
 *
 *  @param
 *
 *  @return
 */
- (NSString *) primaryKey;

/**
 *  返回该版本相对上版本增加的字段
 *
 *  @param version - unsigned int的NSNumber 表示目标版本
 *
 *  @return 增加字段名(NSString)的数组
 */
- (NSArray *) addedKeysForVersion: (NSNumber *) version;

/**
 *  返回该版本相对上版本删除的字段
 *
 *  @param version - unsigned int的NSNumber 表示目标版本
 *
 *  @return 删除字段名(NSString)的数组
 */
- (NSArray *) deletedKeysForVersion: (NSNumber *) version;

/**
 *  返回该版本相对上版本重命名的字段
 *
 *  @param version - unsigned int的NSNumber 表示目标版本
 *
 *  @return 重命名字段的字典对象， key是上个版本的名字(NSString)  value是这个版本的名字(NSString)
 *  remove this due to sqlite doesn't support the column change
 */
- (NSDictionary *) renamedKeysForVersion: (NSNumber *) version;

@end



#endif /* GZCDBmigration_h */

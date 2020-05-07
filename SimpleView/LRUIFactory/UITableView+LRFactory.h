//
//  UITableView+LRFactory.h
//  SimpleView
//
//  Created by leo on 2019/11/23.
//  Copyright © 2019 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary LRFCellInfo;
typedef NSDictionary LRFSectionInfo;
typedef NSDictionary LRFHeaderFooterInfo;

@protocol LRF_UITableViewDataSource <NSObject>

@required

- (UITableViewCell *)lrf_tableView:(UITableView *)tableView cellWithInfo:(NSDictionary *)info cellID:(NSString *)cellID;

@optional

- (void)lrf_tableView:(UITableView *)tableView didSelectCellWithInfo:(NSDictionary *)info cellID:(NSString *)cellID;

- (UITableViewHeaderFooterView *)lrf_tableView:(UITableView *)tableView viewForHeaderWithInfo:(NSDictionary *)info headerFooterID:(NSString *)headerFooterID;
- (UITableViewHeaderFooterView *)lrf_tableView:(UITableView *)tableView viewForFooterWithInfo:(NSDictionary *)info headerFooterID:(NSString *)headerFooterID;

@end

@interface UITableView (LRFactory)

@property (nonatomic, nullable) id lrf_delegate;
@property (nonatomic, nullable) id<LRF_UITableViewDataSource> lrf_dataSource;

- (void)lrf_updateDataSources:(NSArray<LRFSectionInfo *> * _Nullable)dataSources;

- (CGFloat)lrf_contentHeight;

+ (LRFCellInfo *)lrf_cellInfoWithCellID:(NSString *)cellID height:(CGFloat)height info:(NSDictionary * _Nullable)info;

+ (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells;
+ (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells info:(NSDictionary * _Nullable)info headerFooterInfo:(LRFHeaderFooterInfo * _Nullable)headerFooterInfo;

+ (LRFHeaderFooterInfo *)lrf_headerInfoWithHeaderID:(NSString *)headerID height:(CGFloat)height;
+ (LRFHeaderFooterInfo *)lrf_footerInfoWithFooterID:(NSString *)footerID height:(CGFloat)height;
+ (LRFHeaderFooterInfo *)lrf_headerFooterInfoWithHeaderID:(NSString *)headerID headerHeight:(CGFloat)headerHeight footerID:(NSString *)footerID footerHeight:(CGFloat)footerHeight;


- (CGFloat)lrf_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)lrf_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable UIView *)lrf_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (nullable UIView *)lrf_tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)lrf_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)lrf_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

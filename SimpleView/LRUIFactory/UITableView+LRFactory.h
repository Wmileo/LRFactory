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

- (UITableViewCell *)lrf_tableView:(UITableView *)tableView cellWithInfo:(id _Nullable)info cellID:(NSString *)cellID;

@optional

- (void)lrf_tableView:(UITableView *)tableView didSelectCellWithInfo:(id _Nullable)info cellID:(NSString *)cellID;

- (UITableViewHeaderFooterView *)lrf_tableView:(UITableView *)tableView viewForSectionInfo:(id _Nullable)info headerFooterID:(NSString *)headerFooterID;

@end

@interface UITableView (LRFactory)

- (void)lrf_handleDataSource:(id<LRF_UITableViewDataSource>)dataSource canHandleDelegate:(BOOL)canHandel;

- (void)lrf_reloadData:(NSArray<LRFSectionInfo *> * _Nullable)data;

- (CGFloat)lrf_contentHeight;

// section
+ (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells;
+ (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells info:(id _Nullable)info headerFooterInfo:(LRFHeaderFooterInfo * _Nullable)headerFooterInfo;

// cell
+ (LRFCellInfo *)lrf_cellInfoWithCellID:(NSString *)cellID height:(CGFloat)height info:(id _Nullable)info;

// header footer
+ (LRFHeaderFooterInfo *)lrf_headerInfoWithHeaderID:(NSString *)headerID height:(CGFloat)height;
+ (LRFHeaderFooterInfo *)lrf_footerInfoWithFooterID:(NSString *)footerID height:(CGFloat)height;
+ (LRFHeaderFooterInfo *)lrf_headerFooterInfoWithHeaderID:(NSString *)headerID headerHeight:(CGFloat)headerHeight footerID:(NSString *)footerID footerHeight:(CGFloat)footerHeight;

// for delegate
- (CGFloat)lrf_heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)lrf_didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable UIView *)lrf_viewForHeaderInSection:(NSInteger)section;
- (nullable UIView *)lrf_viewForFooterInSection:(NSInteger)section;
- (CGFloat)lrf_heightForHeaderInSection:(NSInteger)section;
- (CGFloat)lrf_heightForFooterInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

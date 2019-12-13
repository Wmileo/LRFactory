//
//  UITableView+LRFactory.m
//  SimpleView
//
//  Created by leo on 2019/11/23.
//  Copyright © 2019 ileo. All rights reserved.
//

#import "UITableView+LRFactory.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

#define kLrfCellID @"kLrfCellID"
#define kLrfCellHeight @"kLrfCellHeight"
#define kLrfCellInfo @"kLrfCellInfo"

#define kLrfCells @"kLrfCells"

#define kLrfSectionInfo @"kLrfSectionInfo"
#define kLrfHeaderHeight @"kLrfHeaderHeight"
#define kLrfFooterHeight @"kLrfFooterHeight"
#define kLrfHeaderID @"kLrfHeaderID"
#define kLrfFooterID @"kLrfFooterID"


@interface LRFTabViewImplement : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *lrf_tableView;

@end


@interface UITableView ()

@property (nonatomic) LRFTabViewImplement<UITableViewDelegate, UITableViewDataSource> *lrf_implement;

@property (nonatomic) NSArray<LRFSectionInfo *> *lrf_sectionInfos;

@end

@implementation UITableView (LRFactory)

- (void)lrf_updateDataSources:(NSArray<LRFSectionInfo *> *)dataSources{
    self.lrf_sectionInfos = dataSources;
    [self reloadData];
}

- (LRFCellInfo *)lrf_cellInfoWithCellID:(NSString *)cellID height:(CGFloat)height info:(NSDictionary *)info{
    if (!cellID) {
        cellID = @"cell";
    }
    if (!height) {
        height = 0;
    }
    if (!info) {
        info = @{};
    }
    return @{
        kLrfCellID: cellID,
        kLrfCellHeight: @(height),
        kLrfCellInfo: info
    };
}

- (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells{
    return [self lrf_sectionInfoWithCells:cells info:@{} headerFooterInfo:[self lrf_headerInfoWithHeaderID:@"header" height:0]];
}

- (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells info:(NSDictionary *)info headerFooterInfo:(LRFHeaderFooterInfo *)headerFooterInfo{
    if (!cells) {
        cells = @[];
    }
    if (!info) {
        info = @{};
    }
    if (!headerFooterInfo) {
        headerFooterInfo = @{};
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:headerFooterInfo];
    [dic addEntriesFromDictionary:@{
        kLrfCells: cells,
        kLrfSectionInfo: info
    }];
    return [dic copy];
}

- (LRFHeaderFooterInfo *)lrf_headerInfoWithHeaderID:(NSString *)headerID height:(CGFloat)height{
    return [self lrf_headerFooterInfoWithHeaderID:headerID headerHeight:height footerID:@"footer" footerHeight:0];
}

- (LRFHeaderFooterInfo *)lrf_footerInfoWithFooterID:(NSString *)footerID height:(CGFloat)height{
    return [self lrf_headerFooterInfoWithHeaderID:@"header" headerHeight:0 footerID:footerID footerHeight:height];
}

- (LRFHeaderFooterInfo *)lrf_headerFooterInfoWithHeaderID:(NSString *)headerID headerHeight:(CGFloat)headerHeight footerID:(NSString *)footerID footerHeight:(CGFloat)footerHeight{
    if (!headerID) {
        headerID = @"header";
    }
    if (!footerID) {
        footerID = @"footer";
    }
    if (!headerHeight) {
        headerHeight = 0;
    }
    if (!footerHeight) {
        footerHeight = 0;
    }
    return @{
        kLrfHeaderHeight: @(headerHeight),
        kLrfFooterHeight: @(footerHeight),
        kLrfHeaderID: headerID,
        kLrfFooterID: footerID
    };
}

- (CGFloat)lrf_contentHeight{
    CGFloat height = 0;
    if (self.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections) {
            for (LRFSectionInfo *section in sections) {
                CGFloat headerHeight = [section[kLrfHeaderHeight] floatValue];
                if (headerHeight == UITableViewAutomaticDimension) {
                    headerHeight = self.estimatedSectionHeaderHeight;
                }
                CGFloat footerHeight = [section[kLrfFooterHeight] floatValue];
                if (footerHeight == UITableViewAutomaticDimension) {
                    footerHeight = self.estimatedSectionFooterHeight;
                }
                height += (headerHeight + footerHeight);
                NSArray<LRFCellInfo *> *cells = section[kLrfCells];
                for (LRFCellInfo *cell in cells) {
                    CGFloat rowHeight = [cell[kLrfCellHeight] floatValue];
                    if (rowHeight == UITableViewAutomaticDimension) {
                        rowHeight = self.estimatedRowHeight;
                    }
                    height += rowHeight;
                }
            }
        }
    }
    return height;
}


static char klrf_sectionInfos;

-(NSArray<LRFSectionInfo *> *)lrf_sectionInfos{
    return objc_getAssociatedObject(self, &klrf_sectionInfos);
}

-(void)setLrf_sectionInfos:(NSArray<LRFSectionInfo *> *)lrf_sectionInfos{
    objc_setAssociatedObject(self, &klrf_sectionInfos, lrf_sectionInfos, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


# pragma mark - delegate

static char klrf_implement;
-(LRFTabViewImplement<UITableViewDelegate,UITableViewDataSource> *)lrf_implement{
    LRFTabViewImplement *implement = objc_getAssociatedObject(self, &klrf_implement);
    if (!implement) {
        implement = [[LRFTabViewImplement alloc] init];
        implement.lrf_tableView = self;
        self.lrf_implement = implement;
    }
    return implement;
}

-(void)setLrf_implement:(LRFTabViewImplement<UITableViewDelegate,UITableViewDataSource> *)lrf_implement{
    objc_setAssociatedObject(self, &klrf_implement, lrf_implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char klrf_dataSource;

- (id<LRF_UITableViewDataSource>)lrf_dataSource{
    return objc_getAssociatedObject(self, &klrf_dataSource);
}

- (void)setLrf_dataSource:(id<LRF_UITableViewDataSource>)lrf_dataSource{
    self.dataSource = self.lrf_implement;
    objc_setAssociatedObject(self, &klrf_dataSource, lrf_dataSource, OBJC_ASSOCIATION_ASSIGN);
}

static char klrf_delegate;

- (id)lrf_delegate{
    return objc_getAssociatedObject(self, &klrf_delegate);
}

- (void)setLrf_delegate:(id)lrf_delegate{
    self.delegate = self.lrf_implement;
    objc_setAssociatedObject(self, &klrf_delegate, lrf_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)lrf_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > indexPath.section) {
            NSArray<LRFCellInfo *> *cells = sections[indexPath.section][kLrfCells];
            if (cells && cells.count > indexPath.row) {
                NSNumber *height = cells[indexPath.row][kLrfCellHeight];
                return [height floatValue];
            }
        }
    }
    return 0;
}

- (void)lrf_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.lrf_dataSource && [self.lrf_dataSource respondsToSelector:@selector(lrf_tableView:didSelectCellWithInfo:cellID:)]) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > indexPath.section) {
            NSArray<LRFCellInfo *> *cells = sections[indexPath.section][kLrfCells];
            if (cells && cells.count > indexPath.row) {
                LRFCellInfo *cell = cells[indexPath.row];
                [self.lrf_dataSource lrf_tableView:tableView didSelectCellWithInfo:cell[kLrfCellInfo] cellID:cell[kLrfCellID]];
            }
        }
    }
}

- (UIView *)lrf_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.lrf_dataSource && [self.lrf_dataSource respondsToSelector:@selector(lrf_tableView:viewForHeaderWithInfo:headerFooterID:)]) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            return [self.lrf_dataSource lrf_tableView:tableView viewForHeaderWithInfo:info[kLrfSectionInfo] headerFooterID:info[kLrfHeaderID]];
        }
    }
    return [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
}

- (UIView *)lrf_tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.lrf_dataSource && [self.lrf_dataSource respondsToSelector:@selector(lrf_tableView:viewForFooterWithInfo:headerFooterID:)]) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            return [self.lrf_dataSource lrf_tableView:tableView viewForFooterWithInfo:info[kLrfSectionInfo] headerFooterID:info[kLrfFooterID]];
        }
    }
    return [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
}

-(CGFloat)lrf_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            NSNumber *height = info[kLrfHeaderHeight];
            if (height) {
                return [height floatValue];
            }
        }
    }
    return 0;
}

-(CGFloat)lrf_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            NSNumber *height = info[kLrfFooterHeight];
            if (height) {
                return [height floatValue];
            }
        }
    }
    return 0;
}

@end


@implementation LRFTabViewImplement

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.lrf_tableView lrf_tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.lrf_tableView lrf_tableView:tableView didSelectRowAtIndexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_tableView:tableView viewForHeaderInSection:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_tableView:tableView viewForFooterInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_tableView:tableView heightForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_tableView:tableView heightForFooterInSection:section];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.lrf_tableView.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_tableView.lrf_sectionInfos;
        if (sections) {
            return sections.count;
        }
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.lrf_tableView.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_tableView.lrf_sectionInfos;
        if (sections && sections.count > section) {
            NSArray<LRFCellInfo *> *cells = sections[section][kLrfCells];
            return cells.count;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.lrf_tableView.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_tableView.lrf_sectionInfos;
        if (sections && sections.count > indexPath.section) {
            NSArray<LRFCellInfo *> *cells = sections[indexPath.section][kLrfCells];
            if (cells && cells.count > indexPath.row) {
                LRFCellInfo *cell = cells[indexPath.row];
                return [self.lrf_tableView.lrf_dataSource lrf_tableView:tableView cellWithInfo:cell[kLrfCellInfo] cellID:cell[kLrfCellID]];
            }
        }
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}
@end

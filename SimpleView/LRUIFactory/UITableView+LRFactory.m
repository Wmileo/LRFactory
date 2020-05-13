//
//  UITableView+LRFactory.m
//  SimpleView
//
//  Created by leo on 2019/11/23.
//  Copyright © 2019 ileo. All rights reserved.
//

#import "UITableView+LRFactory.h"
#import "NSObject+LRFactory.h"

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

@property (nonatomic, nullable) LRFTabViewImplement<UITableViewDelegate, UITableViewDataSource> *lrf_implement;

@property (nonatomic, nullable) NSArray<LRFSectionInfo *> *lrf_sectionInfos;

@end

@implementation UITableView (LRFactory)

- (void)lrf_reloadData:(NSArray<LRFSectionInfo *> *)data{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:data.count];
    [data enumerateObjectsUsingBlock:^(LRFSectionInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj[kLrfCells] || obj[kLrfHeaderID] || obj[kLrfFooterID]) {
            [arr addObject:obj];
        }
    }];
    self.lrf_sectionInfos = [arr copy];
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [wself reloadData];
    });
}

+ (LRFCellInfo *)lrf_cellInfoWithCellID:(NSString *)cellID height:(CGFloat)height info:(id)info{
    NSMutableDictionary *mDic = [self lrf_getReuseDictionary];
    mDic[kLrfCellHeight] = @(height);
    mDic[kLrfCellID] = cellID ? cellID : @"cell";
    if (info) {
        mDic[kLrfCellInfo] = info;
    }
    return [self lrf_unuseDictionary:mDic];
}

+ (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells{
    return [self lrf_sectionInfoWithCells:cells info:nil headerFooterInfo:nil];
}

+ (LRFSectionInfo *)lrf_sectionInfoWithCells:(NSArray<LRFCellInfo *> *)cells info:(id)info headerFooterInfo:(LRFHeaderFooterInfo *)headerFooterInfo{
    NSMutableDictionary *mDic = [self lrf_getReuseDictionary];
    if (headerFooterInfo) {
        [mDic addEntriesFromDictionary:headerFooterInfo];
    }
    if (cells) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:cells.count];
        [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[kLrfCellHeight] floatValue] > 0) {
                [arr addObject:obj];
            }
        }];
        if (arr.count > 0) {
            mDic[kLrfCells] = [arr copy];
        }
    }
    if (info) {
        mDic[kLrfSectionInfo] = info;
    }
    return [self lrf_unuseDictionary:mDic];
}

+ (LRFHeaderFooterInfo *)lrf_headerInfoWithHeaderID:(NSString *)headerID height:(CGFloat)height{
    return [self lrf_headerFooterInfoWithHeaderID:headerID headerHeight:height footerID:@"footer" footerHeight:0];
}

+ (LRFHeaderFooterInfo *)lrf_footerInfoWithFooterID:(NSString *)footerID height:(CGFloat)height{
    return [self lrf_headerFooterInfoWithHeaderID:@"header" headerHeight:0 footerID:footerID footerHeight:height];
}

+ (LRFHeaderFooterInfo *)lrf_headerFooterInfoWithHeaderID:(NSString *)headerID headerHeight:(CGFloat)headerHeight footerID:(NSString *)footerID footerHeight:(CGFloat)footerHeight{
    BOOL hasInfo = NO;
    NSMutableDictionary *mDic = [self lrf_getReuseDictionary];
    if (headerHeight > 0) {
        mDic[kLrfHeaderHeight] = @(headerHeight);
        mDic[kLrfHeaderID] = headerID ? headerID : @"header";
        hasInfo = YES;
    }
    if (footerHeight > 0) {
        mDic[kLrfFooterHeight] = @(footerHeight);
        mDic[kLrfFooterID] = footerID ? footerID : @"footerID";
        hasInfo = YES;
    }
    return hasInfo ? [self lrf_unuseDictionary:mDic] : nil;
}

- (CGFloat)lrf_contentHeight{
    [self layoutIfNeeded];
    return self.contentSize.height;
}


static char klrf_sectionInfos;

- (NSArray<LRFSectionInfo *> *)lrf_sectionInfos{
    return [self lrf_getAssociatedObjectWithKeyAdr:&klrf_sectionInfos];
}

- (void)setLrf_sectionInfos:(NSArray<LRFSectionInfo *> *)lrf_sectionInfos{
    [self lrf_setCopyAssociatedObject:lrf_sectionInfos withKeyAdr:&klrf_sectionInfos];
}

NSMutableSet *reuseSet;

+ (NSMutableDictionary *)lrf_getReuseDictionary{
    if (!reuseSet) {
        reuseSet = [[NSMutableSet alloc] initWithCapacity:2];
    }
    NSMutableDictionary *tmp = [reuseSet anyObject];
    if (tmp) {
        [reuseSet removeObject:tmp];
    } else {
        tmp = [NSMutableDictionary dictionaryWithCapacity:6];
    }
    return tmp;
}

+ (NSDictionary *)lrf_unuseDictionary:(NSMutableDictionary *)reuseDictionary{
    NSDictionary *dic = [reuseDictionary copy];
    if (reuseSet.count == 0) {
        [reuseDictionary removeAllObjects];
        [reuseSet addObject:reuseDictionary];
    }
    return dic;
}

# pragma mark - delegate

static char klrf_implement;

- (LRFTabViewImplement<UITableViewDelegate,UITableViewDataSource> *)lrf_implement{
    return objc_getAssociatedObject(self, &klrf_implement);
}

- (void)setLrf_implement:(LRFTabViewImplement<UITableViewDelegate,UITableViewDataSource> *)lrf_implement{
    objc_setAssociatedObject(self, &klrf_implement, lrf_implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LRFTabViewImplement<UITableViewDelegate,UITableViewDataSource> *)lrf_safeImplement{
    if (!self.lrf_implement) {
        self.lrf_implement = [[LRFTabViewImplement alloc] init];
        self.lrf_implement.lrf_tableView = self;
    }
    return self.lrf_implement;
}

static char klrf_dataSource;

- (id<LRF_UITableViewDataSource>)lrf_dataSource{
    return [self lrf_getAssociatedObjectWithKeyAdr:&klrf_dataSource];
}

- (void)lrf_handleDataSource:(id<LRF_UITableViewDataSource>)dataSource canHandleDelegate:(BOOL)canHandel{
    LRFTabViewImplement *imp = self.lrf_safeImplement;
    if (dataSource) {
        self.dataSource = imp;
    }
    [self lrf_setWeakAssociatedObject:dataSource withKeyAdr:&klrf_dataSource];
    if (canHandel) {
        self.delegate = imp;
    }
}

- (CGFloat)lrf_heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (void)lrf_didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.lrf_dataSource && [self.lrf_dataSource respondsToSelector:@selector(lrf_tableView:didSelectCellWithInfo:cellID:)]) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > indexPath.section) {
            NSArray<LRFCellInfo *> *cells = sections[indexPath.section][kLrfCells];
            if (cells && cells.count > indexPath.row) {
                LRFCellInfo *cell = cells[indexPath.row];
                [self.lrf_dataSource lrf_tableView:self didSelectCellWithInfo:cell[kLrfCellInfo] cellID:cell[kLrfCellID]];
            }
        }
    }
}

- (UIView *)lrf_viewForHeaderInSection:(NSInteger)section{
    if (self.lrf_dataSource && [self.lrf_dataSource respondsToSelector:@selector(lrf_tableView:viewForSectionInfo:headerFooterID:)]) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            return [self.lrf_dataSource lrf_tableView:self viewForSectionInfo:info[kLrfSectionInfo] headerFooterID:info[kLrfHeaderID]];
        }
    }
    return nil;
}

- (UIView *)lrf_viewForFooterInSection:(NSInteger)section{
    if (self.lrf_dataSource && [self.lrf_dataSource respondsToSelector:@selector(lrf_tableView:viewForSectionInfo:headerFooterID:)]) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            return [self.lrf_dataSource lrf_tableView:self viewForSectionInfo:info[kLrfSectionInfo] headerFooterID:info[kLrfFooterID]];
        }
    }
    return nil;
}

- (CGFloat)lrf_heightForHeaderInSection:(NSInteger)section{
    if (self.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            return [info[kLrfHeaderHeight] floatValue];
        }
    }
    return 0;
}

- (CGFloat)lrf_heightForFooterInSection:(NSInteger)section{
    if (self.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_sectionInfos;
        if (sections && sections.count > section) {
            LRFSectionInfo *info = sections[section];
            return [info[kLrfFooterHeight] floatValue];
        }
    }
    return 0;
}

@end

@implementation LRFTabViewImplement

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.lrf_tableView lrf_heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.lrf_tableView lrf_didSelectRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self.lrf_tableView lrf_heightForFooterInSection:section];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.lrf_tableView.lrf_dataSource) {
        NSArray<LRFSectionInfo *> *sections = self.lrf_tableView.lrf_sectionInfos;
        if (sections && sections.count > section) {
            NSArray<LRFCellInfo *> *cells = sections[section][kLrfCells];
            return cells.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

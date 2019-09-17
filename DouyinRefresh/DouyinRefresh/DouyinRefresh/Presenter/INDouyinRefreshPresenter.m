//
//  INDouyinRefreshPresenter.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshPresenter.h"

@implementation INDouyinRefreshPresenter

- (void)refreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.teamAnnounceView.tableView reloadData];
        [self.teamAnnounceView endRefreshingSuccess];
    });
}

- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.teamAnnounceConfig addMoreData];
        [self.teamAnnounceView.tableView reloadData];
        [self.teamAnnounceView endRefreshingSuccess];
    });
}

#pragma mark DFMeetUserViewDelegate
/**
 刷新加载数据
 */
- (void)refreshLoadingData {
    [self refreshData];
}

/**
 加载更多数据
 */
- (void)moreLoadingData {
    [self loadMoreData];
}

#pragma mark TableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamAnnounceConfig.groupDatasources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"INDouyinRefreshCell";
    INDouyinRefreshCell *cell = (INDouyinRefreshCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[INDouyinRefreshCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    INDouyinRefreshModel *model = [self.teamAnnounceConfig.groupDatasources objectAtIndex:indexPath.row];
    cell.contentImage = model.contentImage;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0.0, 0.0)];
    } else {
        // 向上拖动，向上拖动的指定位置后加载更多数据
        NSLog(@"向上拖动，向上拖动的指定位置后加载更多数据");
    }
}

#pragma mark - SETTER/GETTER
- (INDouyinRefreshConfig *)teamAnnounceConfig {
    if (!_teamAnnounceConfig) {
        _teamAnnounceConfig = [[INDouyinRefreshConfig alloc] init];
    }
    return _teamAnnounceConfig;
}

- (INDouyinRefreshInteractor *)teamAnnounceInteractor {
    if (!_teamAnnounceInteractor) {
        _teamAnnounceInteractor = [[INDouyinRefreshInteractor alloc] init];
    }
    return _teamAnnounceInteractor;
}

- (INDouyinRefreshView *)teamAnnounceView {
    if (!_teamAnnounceView) {
        _teamAnnounceView = [[INDouyinRefreshView alloc] initWithFrame:CGRectZero];
    }
    return _teamAnnounceView;
}

@end

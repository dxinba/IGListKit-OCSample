//
//  SearchCell.m
//  zues
//
//  Created by v on 17/2/14.
//  Copyright © 2017年 v. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        [self.contentView addSubview:_searchBar];
    }
    return _searchBar;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _searchBar.frame = self.contentView.bounds;
}

@end

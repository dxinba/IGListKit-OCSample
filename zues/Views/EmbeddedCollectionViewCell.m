//
//  EmbeddedCollectionViewCell.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "EmbeddedCollectionViewCell.h"

@implementation EmbeddedCollectionViewCell
- (IGListCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame=self.contentView.frame;
}
@end

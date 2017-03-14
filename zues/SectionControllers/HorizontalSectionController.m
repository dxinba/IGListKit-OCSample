//
//  HorizontalSectionController.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "HorizontalSectionController.h"
#import "EmbeddedCollectionViewCell.h"
#import "EmbeddedSectionController.h"

@implementation HorizontalSectionController

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self.viewController workingRangeSize:0];
        _adapter.dataSource=self;
    }
    return _adapter;
}

-(NSInteger)numberOfItems{
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 100);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    EmbeddedCollectionViewCell *cell=[self.collectionContext dequeueReusableCellOfClass:[EmbeddedCollectionViewCell class] forSectionController:self atIndex:index];
    self.adapter.collectionView = cell.collectionView;
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _number=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

// MARK: IGListAdapterDataSource
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    NSMutableArray *arrM=[NSMutableArray array];
    NSInteger number_int=_number.integerValue;
    
    if (number_int!=0) {
        for (int i = 0; i<number_int; i++) {
            [arrM addObject:@(i)];
        }
    }
    
    return arrM;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    return [EmbeddedSectionController new];
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

@end

//
//  StackedViewController.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "StackedViewController.h"
#import <IGListKit.h>
#import "WorkingRangeSectionController.h"
#import "DisplaySectionController.h"
#import "HorizontalSectionController.h"

@interface StackedViewController ()<IGListAdapterDataSource>
@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation StackedViewController

-(IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:1];
    }
    return _adapter;
}

- (IGListCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    return _collectionView;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray arrayWithObjects:@128,@256,@64, nil];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
    [self.view addSubview:self.collectionView];
    
    self.adapter.collectionView=self.collectionView;
    self.adapter.dataSource=self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _collectionView.frame=self.view.bounds;
}

// MARK: IGListAdapterDataSource
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.data;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    //注意每个子节控制器被设计为处理一个Int（或没有数据）
    IGListSectionController<IGListSectionType> *sectionController = [[IGListStackedSectionController alloc] initWithSectionControllers:
    @[
      [WorkingRangeSectionController new],
      [DisplaySectionController new],
      [HorizontalSectionController new]
    ]];
    sectionController.inset=UIEdgeInsetsMake(0, 0, 20, 0);
    return sectionController;
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

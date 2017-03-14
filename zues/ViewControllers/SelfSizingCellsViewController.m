//
//  SelfSizingCellsViewController.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "SelfSizingCellsViewController.h"
#import <IGListKit.h>
#import "SelectionModel.h"
#import "SelfSizingSectionController.h"

@interface SelfSizingCellsViewController ()<IGListAdapterDataSource>
@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation SelfSizingCellsViewController

-(IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (IGListCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.estimatedItemSize=CGSizeMake(100, 40);
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor colorWithRed:0.831372549 green:0.945098039 blue:0.964705882 alpha:1];
    }
    return _collectionView;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray arrayWithObjects:
                 [[SelectionModel alloc] initWithOptions:@[@"Leverage agile", @"frameworks", @"robust synopsis", @"high level", @"overviews", @"Iterative approaches", @"corporate strategy", @"foster collaborative", @"overall value", @"proposition", @"Organically grow", @"holistic world view", @"disruptive", @"innovation", @"workplace diversity", @"empowerment"] type:SelectionModelTypeNone],
                 [[SelectionModel alloc] initWithOptions:@[@"Bring to the table", @"win-win", @"survival", @"strategies", @"proactive domination", @"At the end of the day", @"going forward", @"a new normal", @"evolved", @"generation X", @"runway heading", @"streamlined", @"cloud solution", @"User generated", @"content", @"in real-time", @"multiple touchpoints", @"offshoring"] type:SelectionModelTypeNib],
                 [[SelectionModel alloc] initWithOptions:@[@"Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mattis consectetur purus sit amet fermentum.", @"Donec sed odio dui. Donec id elit non mi porta gravida at eget metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed posuere consectetur est at lobortis. Cras justo odio, dapibus ac facilisis in, egestas eget quam.", @"Sed posuere consectetur est at lobortis. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum."] type:SelectionModelTypeFullWidth], nil];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
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
    return [SelfSizingSectionController new];
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

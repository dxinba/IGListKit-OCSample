//
//  SingleSectionViewController.m
//  zues
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 v. All rights reserved.
//

#import "SingleSectionViewController.h"
#import <IGListKit.h>
#import "NibCell.h"

@interface SingleSectionViewController ()<IGListAdapterDataSource,IGListSingleSectionControllerDelegate>
@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation SingleSectionViewController

-(IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
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
        _data = [NSMutableArray arrayWithCapacity:20];
        for (int i = 0; i<20; i++) {
            [_data addObject:@(i)];
        }
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    IGListSingleSectionController *sectionController=[[IGListSingleSectionController alloc] initWithNibName:[NibCell nibName] bundle:nil configureBlock:^(id  _Nonnull item, __kindof NibCell * _Nonnull cell) {
        cell.textLabel.text=[NSString stringWithFormat:@"Cell: %zi",[item integerValue]+1];
    } sizeBlock:^CGSize(id  _Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
        return CGSizeMake([collectionContext containerSize].width, 44);
    }];
    sectionController.selectionDelegate=self;
    return sectionController;
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

// MARK: - IGListSingleSectionControllerDelegate
-(void)didSelectSingleSectionController:(IGListSingleSectionController *)sectionController{
    NSInteger section = [self.adapter sectionForSectionController:sectionController]+1;
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Section %zi 被点击 🎉",section] message:[NSString stringWithFormat:@"Cell Object: %@",self.data[section-1]] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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

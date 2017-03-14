//
//  WorkingRangeViewController.m
//  zues
//
//  Created by mac on 2017/2/16.
//  Copyright © 2017年 v. All rights reserved.
//
/**
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "WorkingRangeViewController.h"
#import <IGListKit.h>
#import "WorkingRangeSectionController.h"

@interface WorkingRangeViewController ()<IGListAdapterDataSource>
@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation WorkingRangeViewController

-(IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:2];//预处理当前可视的最大section+2，比如现在可视最大setion为2，则预处理3，4
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
        NSMutableIndexSet *set=[NSMutableIndexSet indexSet];
        while (set.count<20) {
            [set addIndex:arc4random_uniform(200)+200];
        }
        _data = [NSMutableArray array];
        [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [_data addObject:@(idx)];
        }];
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
    return [WorkingRangeSectionController new];
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

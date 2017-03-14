//
//  EmptyViewController.m
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

#import "EmptyViewController.h"
#import <IGListKit.h>
#import "RemoveSectionController.h"

@interface EmptyViewController ()<IGListAdapterDataSource,RemoveSectionControllerDelegate>
@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property (nonatomic,strong) UILabel *emptyLabel;
@property (nonatomic,assign) NSInteger tally;
@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation EmptyViewController

-(IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (IGListCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    }
    return _collectionView;
}

- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.text = @"没有更多的数据！";
    }
    return _emptyLabel;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray arrayWithObjects:@1,@2,@3,@4, nil];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
    _tally=4;
    [self.view addSubview:self.collectionView];
    
    self.adapter.collectionView=self.collectionView;
    self.adapter.dataSource=self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _collectionView.frame=self.view.bounds;
}

-(void)onAdd{
    [self.data addObject:@(_tally+1)];
    _tally += 1;
    [self.adapter performUpdatesAnimated:YES completion:nil];
}

// MARK: IGListAdapterDataSource
/**
 NSNumber的IGListDiffable协议方法IGListKit框架已经帮我们写好了，具体在NSNumber+IGListDiffable.h中，NSString同上
 */
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.data;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    RemoveSectionController *sectionController=[RemoveSectionController new];
    sectionController.delegate=self;
    return sectionController;
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return self.emptyLabel;
}

// MARK: RemoveSectionControllerDelegate
-(void)removeSectionControllerWantsRemoved:(RemoveSectionController *)sectionController{
    //下面两种方法都可以取到index
//    NSInteger index = [self.adapter sectionForObject:sectionController.number];
    NSInteger index = [self.adapter sectionForSectionController:sectionController];
    
    [self.data removeObjectAtIndex:index];
    [self.adapter performUpdatesAnimated:YES completion:nil];
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

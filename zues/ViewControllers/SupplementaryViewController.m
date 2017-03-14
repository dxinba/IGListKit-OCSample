//
//  SupplementaryViewController.m
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

#import "SupplementaryViewController.h"
#import <IGListKit.h>
#import "FeedItem.h"
#import "User.h"
#import "FeedItemSectionController.h"

@interface SupplementaryViewController ()<IGListAdapterDataSource>
@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *feedItems;
@end

@implementation SupplementaryViewController

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

- (NSMutableArray *)feedItems {
    if (!_feedItems) {
        _feedItems = [NSMutableArray arrayWithObjects:
                      [[FeedItem alloc] init:@1 user:[[User alloc] initWithPk:@100 name:@"Jesse" handle:@"jesse_squires"] comments:[NSMutableArray arrayWithObjects:@"你真牛！", @"你确定吗？", nil]],
                      [[FeedItem alloc] init:@2 user:[[User alloc] initWithPk:@101 name:@"Ryan" handle:@"_ryannystrom"] comments:[NSMutableArray arrayWithObjects:@"这个对我太好了",@"😁", @"让我们试试吧！", nil]],
                      [[FeedItem alloc] init:@3 user:[[User alloc] initWithPk:@102 name:@"Ann" handle:@"abaum"] comments:[NSMutableArray arrayWithObjects:@"祝你好运！", nil]],
                      [[FeedItem alloc] init:@4 user:[[User alloc] initWithPk:@103 name:@"Phil" handle:@"phil"] comments:[NSMutableArray arrayWithObjects:@"yoooooooo", @"预计时间多少", nil]], nil];
    }
    return _feedItems;
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

-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.feedItems;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    return [FeedItemSectionController new];
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

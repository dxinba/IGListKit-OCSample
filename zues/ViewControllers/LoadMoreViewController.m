//
//  LoadMoreViewController.m
//  zues
//
//  Created by mac on 2017/2/11.
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

#import "LoadMoreViewController.h"
#import <IGListKit.h>
#import "LabelSectionController.h"
#import "SpinnerCell.h"

@interface LoadMoreViewController ()<IGListAdapterDataSource,UIScrollViewDelegate>
//IGListAdapter来控制collectionView的数据显示
@property (nonatomic,strong) IGListAdapter *adapter;
//IGListCollectionView继承自UICollectionView,用来代替UITableView
@property (nonatomic,strong) IGListCollectionView *collectionView;
//数据源数组
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,assign) BOOL loading;
@property (nonatomic,strong) NSString *spinToken;
@end

@implementation LoadMoreViewController

- (IGListAdapter *)adapter {
    if (!_adapter) {
        /**
         默认初始化IGListAdapter
         参数1：IGListAdapterUpdater，是一个遵循了IGListUpdatingDelegate的对象，它处理每行更新。
         参数2：viewController，是包含IGListAdapter的UIViewController。 可以用来push到其他控制器
         参数3：workingRangeSize是工作范围的大小，它可以让你为刚好在可见范围之外的视图做一些准备工作，暂时没用到给0。
         */
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (IGListCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    return _collectionView;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items=[NSMutableArray array];
        for (int i=0; i<20; i++) {
            [_items addObject:[NSString stringWithFormat:@"%zi",i]];
        }
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _spinToken=@"spinner";
    [self.view addSubview:self.collectionView];
    //给adapter赋值collectionView
    self.adapter.collectionView=self.collectionView;
    //给adapter赋值dataSource
    self.adapter.dataSource=self;
    self.adapter.scrollViewDelegate=self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _collectionView.frame=self.view.bounds;
}

// MARK: IGListAdapterDataSource
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    //给出数据源
    if (_loading) {//判断是否正在加载
        [self.items addObject:_spinToken];//添加字符串spinner
    }
    return self.items;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    //返回一个IGListSectionController实例，在自定义IGListSectionController中将实现cell的创建，赋值。相当于UITableView一个indexPath.setion,根据你数组中object的类型判断返回对应的自定义IGListSectionController
    if ([object isEqualToString:_spinToken]) {//是spinner，则显示加载cell
        return [[IGListSingleSectionController alloc] initWithCellClass:[SpinnerCell class] configureBlock:^(id  _Nonnull item, __kindof SpinnerCell * _Nonnull cell) {
            [cell.activityIndicator startAnimating];
        } sizeBlock:^CGSize(id  _Nonnull item, id<IGListCollectionContext>  _Nullable collectionContext) {
            return CGSizeMake([collectionContext containerSize].width, 100);
        }];
    }
    return [[LabelSectionController alloc] init];
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    //返回一个数据为空时的显示视图
    return nil;
}

// MARK: UIScrollViewDelegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat distance = scrollView.contentSize.height - (targetContentOffset->y  + scrollView.bounds.size.height);
    
    if (!_loading && distance < 200) {
        //开始加载
        _loading = YES;
        //更新列表
        [self.adapter performUpdatesAnimated:YES completion:nil];
        
        //模拟网络加载
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(2);
            
            //加载完成，添加数据
            dispatch_async(dispatch_get_main_queue(), ^{
                _loading = NO;
                NSInteger itemCount = self.items.count;
                //删除spinner
                [_items removeLastObject];
                for (int i=0; i<5; i++) {
                    [_items addObject:[NSString stringWithFormat:@"%zi",i+itemCount]];
                }
                //更新列表
                [self.adapter performUpdatesAnimated:YES completion:nil];
            });
        });
    }
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

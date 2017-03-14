//
//  DemosViewController.m
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

#import "DemosViewController.h"
#import <IGListKit.h>
#import "DemoSectionController.h"
#import "LoadMoreViewController.h"
#import "MixedDataViewController.h"
#import "EmptyViewController.h"
#import "WorkingRangeViewController.h"
#import "SupplementaryViewController.h"
#import "DisplayViewController.h"
#import "SearchViewController.h"
#import "StackedViewController.h"
#import "SelfSizingCellsViewController.h"
#import "NestedAdapterViewController.h"
#import "DiffTableViewController.h"
#import "SingleSectionViewController.h"
#import "SingleSectionStoryboardViewController.h"

@interface DemosViewController ()<IGListAdapterDataSource>
//IGListAdapter来控制collectionView的数据显示
@property (nonatomic,strong) IGListAdapter *adapter;
//IGListCollectionView继承自UICollectionView,用来代替UITableView
@property (nonatomic,strong) IGListCollectionView *collectionView;
//数据源数组
@property (nonatomic,strong) NSMutableArray *demos;
@end

@implementation DemosViewController

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

- (NSMutableArray *)demos {
    if (!_demos) {
        /**
         数据源数组，数组里的model要实现IGListDiffable
         */
        _demos = [NSMutableArray arrayWithObjects:
                  [[DemoItem alloc] init:@"上拉加载" controllerClass:[LoadMoreViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"Search Autocomplete 搜索" controllerClass:[SearchViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"混合数据" controllerClass:[MixedDataViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"嵌套 Adapter" controllerClass:[NestedAdapterViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"空视图" controllerClass:[EmptyViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"Single Section Controller" controllerClass:[SingleSectionViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"Storyboard" controllerClass:[SingleSectionViewController class] controllerIdentifier:@"demo"],
                  [[DemoItem alloc] init:@"Single Section Storyboard" controllerClass:[SingleSectionStoryboardViewController class] controllerIdentifier:@"singleSectionDemo"],
                  [[DemoItem alloc] init:@"working range" controllerClass:[WorkingRangeViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"Diff 算法" controllerClass:[DiffTableViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"补充视图" controllerClass:[SupplementaryViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"自适应cells" controllerClass:[SelfSizingCellsViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"滚动过程中cell的显示或隐藏delegate回调" controllerClass:[DisplayViewController class] controllerIdentifier:nil],
                  [[DemoItem alloc] init:@"Stacked Section Controllers" controllerClass:[StackedViewController class] controllerIdentifier:nil],nil];
    }
    return _demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demos";
    [self.view addSubview:self.collectionView];
    //给adapter赋值collectionView
    self.adapter.collectionView=self.collectionView;
    //给adapter赋值dataSource
    self.adapter.dataSource=self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _collectionView.frame=self.view.bounds;
}

// MARK: IGListAdapterDataSource
/**
 请求数据源的对象在列表中显示。

 @param listAdapter请求此信息的列表适配器。

 @return 列表的对象数组。
*/
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    //给出数据源
    return self.demos;
}

/**
 向数据源请求列表中指定对象的段控制器。

 @param listAdapter请求此信息的列表适配器。
 @param object列表中的一个对象。

 @return 可以在列表中显示的新节控制器实例。

 @note当被请求时，应在这里为对象初始化新的段控制器。 您可以传送任何其他资料至此时段控制器。

 每当创建，更新或重新加载`IGListAdapter`时，将为所有对象初始化控制器。当对象被移动或更新时，段控制器被重用。 维护` - [IGListDiffable diffIdentifier]`保证这一点。
*/
-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    //返回一个IGListSectionController实例，在自定义IGListSectionController中将实现cell的创建，赋值。相当于UITableView一个indexPath.setion,根据你数组中object的类型判断返回对应的自定义IGListSectionController
    return [[DemoSectionController alloc] init];
}

/**
 当列表为空时，要求视图的数据源用作集合视图背景。

 @param listAdapter请求此信息的列表适配器。

 @return一个视图用作集合视图背景，如果你不想要一个背景视图返回'nil'。

 @note 每次更新列表适配器时调用此方法。 您可以随时返回新的意见，但出于性能原因，您可能希望保留视图并在此返回。 以下只负责添加背景视图并保持其可见性。
*/
-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    //返回一个数据为空时的显示视图
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

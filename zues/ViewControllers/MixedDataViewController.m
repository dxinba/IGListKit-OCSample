//
//  MixedDataViewController.m
//  zues
//
//  Created by mac on 2017/2/15.
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

#import "MixedDataViewController.h"
#import <IGListKit.h>
#import "GridSectionController.h"
#import "User.h"
#import "ExpandableSectionController.h"
#import "UserSectionController.h"

@interface MixedDataViewController ()<IGListAdapterDataSource>
//IGListAdapter来控制collectionView的数据显示
@property (nonatomic,strong) IGListAdapter *adapter;
//IGListCollectionView继承自UICollectionView,用来代替UITableView
@property (nonatomic,strong) IGListCollectionView *collectionView;
//数据源数组
@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,strong) NSArray *segments;
@property (nonatomic,strong) NSString *selectedClass;
@end

@implementation MixedDataViewController

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

- (NSMutableArray *)data {
    if (!_data) {
        /**
         数据源数组，数组里的model要实现IGListDiffable
         */
        _data = [NSMutableArray arrayWithObjects:
                  @"Maecenas faucibus mollis interdum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
                 [[GridItem alloc] init:[UIColor colorWithRed: 237/255.0 green: 73/255.0 blue: 86/255.0 alpha: 1] itemCount:6],
                 [[User alloc] initWithPk:@2 name:@"Ryan Olson" handle:@"ryanolsonk"],
                 @"Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
                 [[GridItem alloc] init:[UIColor colorWithRed: 56/255.0 green: 151/255.0 blue: 240/255.0 alpha: 1] itemCount:5],
                 [[User alloc] initWithPk:@4 name:@"Oliver Rickard" handle:@"ocrickard"],
                 @"Nullam quis risus eget urna mollis ornare vel eu leo. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
                 [[GridItem alloc] init:[UIColor colorWithRed: 112/255.0 green: 192/255.0 blue: 80/255.0 alpha: 1] itemCount:3],
                 [[User alloc] initWithPk:@3 name:@"Jesse Squires" handle:@"jesse_squires"],
                 @"Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.",
                 [[GridItem alloc] init:[UIColor colorWithRed: 163/255.0 green: 42/255.0 blue: 186/255.0 alpha: 7] itemCount:7],
                 [[User alloc] initWithPk:@1 name:@"Ryan Nystrom" handle:@"_ryannystrom"], nil];
    }
    return _data;
}

- (NSArray *)segments {
    if (!_segments) {
        _segments = @[@[@"All",@""],@[@"Colors",NSStringFromClass([GridItem class])],@[@"Text",NSStringFromClass([NSString class])],@[@"Users",NSStringFromClass([User class])]];
    }
    return _segments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedClass=self.segments[0][1];
    NSMutableArray *arrM=[NSMutableArray array];
    for (NSArray *arr in self.segments) {
        [arrM addObject:arr.firstObject];
    }
    UISegmentedControl *control=[[UISegmentedControl alloc] initWithItems:arrM];
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(onControl:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = control;
    
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

-(void)onControl:(UISegmentedControl *)control{
    self.selectedClass=self.segments[control.selectedSegmentIndex][1];
    [self.adapter performUpdatesAnimated:YES completion:nil];
}

// MARK: IGListAdapterDataSource
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    if ([self.selectedClass isEqualToString:self.segments[0][1]]) {
        return self.data;
    }
    
    NSMutableArray *arrM=[NSMutableArray array];
    Class class=NSClassFromString(self.selectedClass);
    for (id obj in self.data) {
        if ([obj isKindOfClass:class]) {
            [arrM addObject:obj];
        }
    }
    return arrM;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    if ([object isKindOfClass:[NSString class]]) {
        return [ExpandableSectionController new];
    }
    else if ([object isKindOfClass:[GridItem class]]) {
        return [GridSectionController new];
    }
    else {
        return [UserSectionController new];
    }
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

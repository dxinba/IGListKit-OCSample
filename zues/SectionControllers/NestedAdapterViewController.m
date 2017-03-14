//
//  NestedAdapterViewController.m
//  zues
//
//  Created by v on 17/3/3.
//  Copyright © 2017年 v. All rights reserved.
//
/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
 
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import "NestedAdapterViewController.h"
#import <IGListKit.h>
#import "HorizontalSectionController.h"
#import "LabelSectionController.h"
@interface NestedAdapterViewController ()<IGListAdapterDataSource>
/** IGListAdapter */
@property (strong, nonatomic) IGListAdapter *adapter;
/** IGListCollectionView */
@property (strong, nonatomic) IGListCollectionView *collectionView;
/** data */
@property (strong, nonatomic) NSArray *data;
@end

@implementation NestedAdapterViewController

- (IGListAdapter *)adapter {
    if (!_adapter) {
        /**
         默认初始化IGListAdapter
         参数1：IGListAdapterUpdater，是一个遵循了IGListUpdatingDelegate的对象，它处理每行更新。
         参数2：viewController，是包含IGListAdapter的UIViewController。 可以用来push到其他控制器
         参数3：workingRangeSize是工作范围的大小，它可以让你为刚好在可见范围之外的视图做一些准备工作，暂时没用到给0。
         */
        _adapter = [[IGListAdapter alloc]initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (IGListCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[IGListCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     数据源数组，数组里的model要实现IGListDiffable
     */
    _data = @[@"Ridiculus Elit Tellus Purus Aenean",
              @"Condimentum Sollicitudin Adipiscing",
              @14,
              @"Ligula Ipsum Tristique Parturient Euismod",
              @"Purus Dapibus Vulputate",
              @6,
              @"Tellus Nibh Ipsum Inceptos",
              @2];
    
    [self.view addSubview:self.collectionView];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

// MARK：IGListAdapterDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return _data;
}

- (IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return [HorizontalSectionController new];
    }
    return [LabelSectionController new];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end

//
//  HorizontalSectionController.h
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import <IGListKit/IGListKit.h>

@interface HorizontalSectionController : IGListSectionController<IGListSectionType,IGListAdapterDataSource>
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic,strong) IGListAdapter *adapter;
@end

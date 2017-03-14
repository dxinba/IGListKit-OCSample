//
//  SelfSizingSectionController.h
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit.h>

@class SelectionModel;
@interface SelfSizingSectionController : IGListSectionController<IGListSectionType>
@property (nonatomic,strong) SelectionModel *model;
@end

//
//  StoryboardLabelSectionController.h
//  zues
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 v. All rights reserved.
//

#import <IGListKit/IGListKit.h>

@class StoryboardLabelSectionController,Person;
@protocol StoryboardLabelSectionControllerDelegate <NSObject>

-(void)removeSectionControllerWantsRemoved:(StoryboardLabelSectionController *)sectionController;

@end

@interface StoryboardLabelSectionController : IGListSectionController<IGListSectionType>
@property (nonatomic,strong) Person *object;
@property (nonatomic,weak) id<StoryboardLabelSectionControllerDelegate> delegate;
@end

//
//  StoryboardLabelSectionController.m
//  zues
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 v. All rights reserved.
//

#import "StoryboardLabelSectionController.h"
#import "Person.h"
#import "StoryboardCell.h"

@implementation StoryboardLabelSectionController
-(NSInteger)numberOfItems{
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat size=self.object.name.length*7;
    return CGSizeMake(size, size);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    StoryboardCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:@"cell" forSectionController:self atIndex:index];
    cell.textLabel.text=self.object.name;
    return cell;
}

-(void)didUpdateToObject:(id)object{
    self.object=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    [_delegate removeSectionControllerWantsRemoved:self];
}

@end

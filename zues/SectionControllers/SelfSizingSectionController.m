//
//  SelfSizingSectionController.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "SelfSizingSectionController.h"
#import "SelectionModel.h"
#import "ManuallySelfSizingCell.h"
#import "FullWidthSelfSizingCell.h"
#import "NibSelfSizingCell.h"

@implementation SelfSizingSectionController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.inset=UIEdgeInsetsMake(0, 0, 40, 0);
        self.minimumLineSpacing=4;
        self.minimumInteritemSpacing=4;
    }
    return self;
}

-(NSInteger)numberOfItems{
    return _model.options.count;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 55);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    NSString *text=_model.options[index];
    UICollectionViewCell *cell=nil;
    switch (_model.type) {
        case SelectionModelTypeNone:{
            ManuallySelfSizingCell *manualCell=[self.collectionContext dequeueReusableCellOfClass:[ManuallySelfSizingCell class] forSectionController:self atIndex:index];
            manualCell.label.text=text;
            cell=manualCell;
        }   break;
            
        case SelectionModelTypeFullWidth:{
            FullWidthSelfSizingCell *manualCell=[self.collectionContext dequeueReusableCellOfClass:[FullWidthSelfSizingCell class] forSectionController:self atIndex:index];
            manualCell.label.text=text;
            cell=manualCell;
        }   break;
            
        case SelectionModelTypeNib:{
            NibSelfSizingCell *nibCell=[self.collectionContext dequeueReusableCellWithNibName:@"NibSelfSizingCell" bundle:nil forSectionController:self atIndex:index];
            nibCell.contentLabel.text=text;
            cell=nibCell;
        }   break;
    }
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _model=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

@end

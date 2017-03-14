//
//  EmbeddedSectionController.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "EmbeddedSectionController.h"
#import "CenterLabelCell.h"

@implementation EmbeddedSectionController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.inset=UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return self;
}

-(NSInteger)numberOfItems{
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat height=[self.collectionContext containerSize].height;
    return CGSizeMake(height, height);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    CenterLabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[CenterLabelCell class] forSectionController:self atIndex:index];
    cell.label.text=[NSString stringWithFormat:@"%zi",[_number integerValue]+1];
    cell.backgroundColor=[UIColor colorWithRed:237/255.0f green:73/255.0f blue:86/255.0 alpha:1];
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _number=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}
@end

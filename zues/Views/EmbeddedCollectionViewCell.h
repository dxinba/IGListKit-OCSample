//
//  EmbeddedCollectionViewCell.h
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit.h>

@interface EmbeddedCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) IGListCollectionView *collectionView;
@end

//
//  NibCell.h
//  zues
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 v. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NibCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

+(NSString *)nibName;
@end

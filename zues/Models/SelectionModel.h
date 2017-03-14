//
//  SelectionModel.h
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListDiffable.h>

typedef NS_ENUM(NSUInteger, SelectionModelType) {
    SelectionModelTypeNone,
    SelectionModelTypeFullWidth,
    SelectionModelTypeNib,
};

@interface SelectionModel : NSObject<IGListDiffable>
@property (nonatomic,strong) NSArray *options;
@property (nonatomic,assign) SelectionModelType type;

-initWithOptions:(NSArray *)options type:(SelectionModelType)type;
@end

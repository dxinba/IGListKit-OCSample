//
//  SelectionModel.m
//  zues
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 v. All rights reserved.
//

#import "SelectionModel.h"

@implementation SelectionModel
- (instancetype)initWithOptions:(NSArray *)options type:(SelectionModelType)type
{
    self = [super init];
    if (self) {
        _options = options;
        _type = type;
    }
    return self;
}

-(id<NSObject>)diffIdentifier{
    return self;
}

-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return [self isEqual:object];
}
@end

//
//  Person.m
//  zues
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 v. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithPk:(NSNumber *)pk Name:(NSString *)name
{
    self = [super init];
    if (self) {
        _pk=pk;
        _name=name;
    }
    return self;
}

-(id<NSObject>)diffIdentifier{
    return self.pk;
}

-(BOOL)isEqualToDiffableObject:(Person *)object{
    return [self.name isEqualToString:object.name];
}


@end

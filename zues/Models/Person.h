//
//  Person.h
//  zues
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 v. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListDiffable.h>

@interface Person : NSObject<IGListDiffable>
@property (nonatomic,strong) NSNumber *pk;
@property (nonatomic,strong) NSString *name;

- (instancetype)initWithPk:(NSNumber *)pk Name:(NSString *)name;
@end

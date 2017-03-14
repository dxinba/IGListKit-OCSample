//
//  User.m
//  zues
//
//  Created by v on 17/2/13.
//  Copyright © 2017年 v. All rights reserved.
//
/**
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "User.h"

@implementation User

- (instancetype)initWithPk:(NSNumber *)pk name:(NSString *)name handle:(NSString *)handle {
    if (self=[super init]) {
        self.pk = pk;
        self.name = name;
        self.handle = handle;
    }
    return self;
}

- (id<NSObject>)diffIdentifier {
    return _pk;
}

- (BOOL)isEqualToDiffableObject:(User *)object {
    if (self==object) {//指针地址比较
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [_name isEqualToString:object.name] && [_handle isEqualToString:object.handle];
}

@end

//
//  FeedItem.m
//  zues
//
//  Created by mac on 2017/2/16.
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

#import "FeedItem.h"
#import "User.h"

@implementation FeedItem
- (instancetype)init:(NSNumber *)pk user:(User *)user comments:(NSMutableArray *)comments
{
    self = [super init];
    if (self) {
        _pk=pk;
        _user=user;
        _comments=comments;
    }
    return self;
}

// MARK: IGListDiffable
-(id<NSObject>)diffIdentifier{
    return _pk;
}

-(BOOL)isEqualToDiffableObject:(FeedItem *)object{
    if (self==object) {
        return YES;
    }
    return [_user isEqualToDiffableObject:object.user] && [_comments isEqualToArray:object.comments];
}
@end

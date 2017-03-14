//
//  UserSectionController.m
//  zues
//
//  Created by mac on 2017/2/15.
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

#import "UserSectionController.h"
#import "User.h"
#import "DetailLabelCell.h"

@implementation UserSectionController
-(NSInteger)numberOfItems{
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 55);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    DetailLabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[DetailLabelCell class] forSectionController:self atIndex:index];
    cell.titleLabel.text=_user.name;
    cell.detailLabel.text=[NSString stringWithFormat:@"@%@",_user.handle];
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _user=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

@end

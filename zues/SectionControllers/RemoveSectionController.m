//
//  RemoveSectionController.m
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

#import "RemoveSectionController.h"

@implementation RemoveSectionController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.inset=UIEdgeInsetsMake(0, 0, 10, 0);
    }
    return self;
}

-(NSInteger)numberOfItems{
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 55);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    RemoveCell *cell=[self.collectionContext dequeueReusableCellOfClass:[RemoveCell class] forSectionController:self atIndex:index];
    cell.label.text=[NSString stringWithFormat:@"Cell:%@",_number];
    cell.delegate=self;
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _number=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

// MARK: RemoveCellDelegate
-(void)removeCellDidTapButton:(RemoveCell *)cell{
    _delegate?[_delegate removeSectionControllerWantsRemoved:self]:nil;
}

@end

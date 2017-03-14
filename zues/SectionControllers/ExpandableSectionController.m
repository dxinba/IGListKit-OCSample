//
//  ExpandableSectionController.m
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

#import "ExpandableSectionController.h"
#import "LabelCell.h"

@implementation ExpandableSectionController
-(NSInteger)numberOfItems{
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat width=[self.collectionContext containerSize].width;
    CGFloat height = _expanded ? [LabelCell textHeight:_object?:@"" width:width] : LabelCell.singleLineHeight;
    return CGSizeMake(width, height);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    LabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[LabelCell class] forSectionController:self atIndex:index];
    cell.label.numberOfLines = _expanded ? 0 : 1;
    cell.label.text = _object;
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _object=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    _expanded = !_expanded;
    [self.collectionContext reloadInSectionController:self atIndexes:[NSIndexSet indexSetWithIndex:0]];
}
@end

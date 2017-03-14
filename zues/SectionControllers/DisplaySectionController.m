//
//  DisplaySectionController.m
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

#import "DisplaySectionController.h"
#import "LabelCell.h"

@implementation DisplaySectionController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.displayDelegate=self;
        self.inset=UIEdgeInsetsMake(0, 0, 30, 0);
    }
    return self;
}

// MARK: IGlistSectionType
-(NSInteger)numberOfItems{
    return 4;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 55);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    LabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[LabelCell class] forSectionController:self atIndex:index];
    cell.label.text=[NSString stringWithFormat:@"Section %zi, cell %zi",[self.collectionContext sectionForSectionController:self],index];
    return cell;
}

-(void)didUpdateToObject:(id)object{
    return;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

// MARK: IGListDisplayDelegate
-(void)listAdapter:(IGListAdapter *)listAdapter willDisplaySectionController:(IGListSectionController<IGListSectionType> *)sectionController{
    NSLog(@"将要显示 section:%zi",[self.collectionContext sectionForSectionController:self]);
}

-(void)listAdapter:(IGListAdapter *)listAdapter willDisplaySectionController:(IGListSectionController<IGListSectionType> *)sectionController cell:(UICollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"将要显示 section:%zi 的 cell:%zi",[self.collectionContext sectionForSectionController:self],index);
    
}

-(void)listAdapter:(IGListAdapter *)listAdapter didEndDisplayingSectionController:(IGListSectionController<IGListSectionType> *)sectionController{
    NSLog(@"结束显示 section:%zi",[self.collectionContext sectionForSectionController:self]);
}

-(void)listAdapter:(IGListAdapter *)listAdapter didEndDisplayingSectionController:(IGListSectionController<IGListSectionType> *)sectionController cell:(UICollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"结束显示 section:%zi 的 cell:%zi",[self.collectionContext sectionForSectionController:self],index);
}
@end

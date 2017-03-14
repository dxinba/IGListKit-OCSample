//
//  GridSectionController.m
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

#import "GridSectionController.h"
#import "CenterLabelCell.h"

@implementation GridItem

-(instancetype)init:(UIColor *)color itemCount:(NSInteger)itemCount{
    if (self=[super init]) {
        self.color=color;
        self.itemCount=itemCount;
    }
    return self;
}

-(id<NSObject>)diffIdentifier{
    return self;
}

-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return self==object?YES:[self isEqual:object];
}

@end

@implementation GridSectionController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing=1;
        self.minimumLineSpacing=1;
    }
    return self;
}

// MARK: IGListSectionType
-(NSInteger)numberOfItems{
    //相当于UITableView一个indexPath.setion中有几个row
    return _object.itemCount;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    CGFloat width = [self.collectionContext containerSize].width;
    CGFloat itemSize = floor(width / 4);
    //返回cell大小
    return CGSizeMake(itemSize, itemSize);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    //返回cell
    CenterLabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[CenterLabelCell class] forSectionController:self atIndex:index];
    cell.label.text=[NSString stringWithFormat:@"%zi",index+1];
    cell.backgroundColor=_object.color;
    return cell;
}

-(void)didUpdateToObject:(id)object{
    //绑定model
    _object=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    //一个row的点击事件
    return;
}

@end

//
//  FeedItemSectionController.m
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

#import "FeedItemSectionController.h"
#import "FeedItem.h"
#import "LabelCell.h"
#import "UserHeaderView.h"
#import "User.h"

@implementation FeedItemSectionController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.supplementaryViewSource=self;
    }
    return self;
}

// MARK: IGlistSectionType
-(NSInteger)numberOfItems{
    return _feedItem.comments.count;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 55);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    LabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[LabelCell class] forSectionController:self atIndex:index];
    cell.label.text=_feedItem.comments[index];
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _feedItem=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

// MARK: IGListSupplementaryViewSource
/**
 向SupplementaryViewSource请求支持的元素类型的数组。

 @return 补充源处理的元素类型字符串数组。
*/
-(NSArray<NSString *> *)supportedElementKinds{
    return @[UICollectionElementKindSectionHeader];
}

/**
向SupplementaryViewSource请求指定类型和索引的已配置补充视图。

 @param elementKind请求的补充视图的类型
 @param index正在请求的补充veiw的索引。

 @note 这是您进行任何补充视图设置和配置的机会。

 @warning 你不应该在这个方法中分配新的视图。 而是从“IGListCollectionContext”中取出视图。
*/
-(UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index{
    UserHeaderView *view=[self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:@"UserHeaderView" bundle:nil atIndex:index];
    view.handleLabel.text = [NSString stringWithFormat:@"@%@",_feedItem.user.handle];
    view.nameLabel.text = _feedItem.user.name;
    return view;
}

/**
 向SupplementaryViewSource请求给定类型和索引路径的补充视图的大小。

 @param elementKind补充视图的类型。
 @param index所请求视图的索引。

 @return 补充视图的大小。
*/
-(CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, 40);
}
@end

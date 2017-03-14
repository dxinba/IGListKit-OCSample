//
//  DemoSectionController.m
//  zues
//
//  Created by mac on 2017/2/11.
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

#import "DemoSectionController.h"
#import "LabelCell.h"

@implementation DemoItem
// MARK: INIT
/**
 controllerClass:类名
 
 @return 可用于唯一标识对象的键。
 
 @note
 
 @warning
 */
- (instancetype)init:(NSString *)name controllerClass:(Class)controllerClass controllerIdentifier:(NSString *)controllerIdentifier
{
    self = [super init];
    if (self) {
        self.name=name;
        self.controllerClass=controllerClass;
        self.controllerIdentifier=controllerIdentifier;
    }
    return self;
}

// MARK: IGListDiffable
/**
 返回唯一标识对象的键。
 
 @return 可用于唯一标识对象的键。
 
 @note 两个对象可以共享相同的标识符，但不相等。 一个常见的模式是使用`NSObject`类别自动一致性。 但是这意味着对象将被识别指针值，所以找到更新变得不可能。
 
 @warning 此值不应该改变。
 */
-(id<NSObject>)diffIdentifier{
    return _name;
}

/**
 返回接收器和给定对象是否相等。
 
 @param object要与接收器进行比较的对象。
 
 @return 如果接收器和对象是相等的`YES`，否则为`NO`。
 */
-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    if (self==object) {
        return YES;
    }
//    DemoItem *item = object;
//    if ([item isEqual:object]) {
//        return NO;
//    }
    // TODO: guard let object = object as? DemoItem else { return false }
    return _controllerClass == [(DemoItem *)object controllerClass] && _controllerIdentifier == [(DemoItem *)object controllerIdentifier];
}

@end

@implementation DemoSectionController

// MARK: IGListSectionType
/**
 返回节中的项目数。

 @return 列表中的单元格数。

 @note 返回的计数用于显示此列表的单元格数。 您可以在数据加载过程随意更改这个值。
*/
-(NSInteger)numberOfItems{
    //相当于UITableView一个indexPath.setion中有几个row
    return 1;
}

/**
 指定索引处的项目的特定大小。

 @param index项目的行索引。

 @return 索引处的单元格的大小。

 @note 返回的大小不是一定要使用。 实现可以查询它们的部分布局信息，或使用其自己的布局度量。 例如，考虑动态文本大小的列表与固定大小高度和宽度网格。 前者会询问每个部分的大小，后者可能不会。
*/
-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    //返回cell大小
   return CGSizeMake([self.collectionContext containerSize].width, 55);
}

/**
 要求段控制器在指定索引处完全配置的单元。

 @param index所请求的行的索引。

 @return `UICollectionViewCell`子类。

 @note 这是您进行任何单元设置和配置的地方。 基础架构请求单元时将在屏幕上使用。 您不要在这方法中创建新的单元格，而应使用提供的适配器来调用`-dequeCellClass：forIndexPath：`它从集合视图中指定一个单元格，或为您创建一个新的单元格。
*/
-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    //返回cell
    LabelCell *cell=[self.collectionContext dequeueReusableCellOfClass:[LabelCell class] forSectionController:self atIndex:index];
    cell.label.text=_object.name;
    return cell;
}

/**
 告诉部分控制器已更新为一个新的对象。

 @param object映射到此控制器的对象。

 @note 当调用此方法时，已为该部分设置了所有可用的上下文和配置控制器。 此外，根据使用的更新策略，您的项目模型可能已更改内存中的对象，所以你可以使用此事件更新存储在段控制器上的对象。

 此方法将仅在对象实例已更改（包括“nil”或上一个对象）时调用。
*/
-(void)didUpdateToObject:(id)object{
    //绑定model
    _object=object;
}

/**
 单元格的选择事件回调。

 @param index所选单元格的索引。
*/
-(void)didSelectItemAtIndex:(NSInteger)index{
    //一个row的点击事件
    if (_object.controllerIdentifier) {//跳转sb
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Demo" bundle:nil];
        UIViewController *controller=[storyboard instantiateViewControllerWithIdentifier:_object.controllerIdentifier];
        controller.title=_object.name;
        [self.viewController.navigationController pushViewController:controller animated:YES];
    }
    else if (_object.controllerClass) {
        UIViewController *controller=[[_object.controllerClass alloc] init];
        controller.title=_object.name;
        [self.viewController.navigationController pushViewController:controller animated:YES];
    }
}

@end

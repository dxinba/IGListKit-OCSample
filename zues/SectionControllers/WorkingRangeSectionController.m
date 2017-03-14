//
//  WorkingRangeSectionController.m
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

#import "WorkingRangeSectionController.h"
#import "LabelCell.h"
#import "ImageCell.h"

@implementation WorkingRangeSectionController

- (NSString *)urlString {
    if (!_urlString) {
        _urlString=[NSString stringWithFormat:@"https://unsplash.it/%zi/%@/",(int)[self.collectionContext containerSize].width,_height];
    }
    return _urlString;
}

-(void)dealloc{
    [_task cancel];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.workingRangeDelegate=self;
    }
    return self;
}

-(NSInteger)numberOfItems{
    return 2;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake([self.collectionContext containerSize].width, index==0?55:_height.floatValue);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    UICollectionViewCell *cell=[self.collectionContext dequeueReusableCellOfClass:index==0?[LabelCell class]:[ImageCell class] forSectionController:self atIndex:index];
    if (index==0) {
        [(LabelCell *)cell label].text = [NSString stringWithFormat:@"%@ sec:%zi",self.urlString,[self.collectionContext sectionForSectionController:self]];
    }
    else{
        [(ImageCell *)cell setImage:self.downloadedImage];
    }
    return cell;
}

-(void)didUpdateToObject:(id)object{
    _height=object;
}

-(void)didSelectItemAtIndex:(NSInteger)index{
    return;
}

/**
 实现此协议以接收列表的工作范围事件。

 工作范围是可视视图『附近』的范围，您可以在其中开始准备显示内容。 例如，
 您可以开始解码图像，或加热文本缓存。
*/
// MARK: IGListWorkingRangeDelegate

/**
 通知代表控制器将进入工作范围。

 @param listAdapter控制列表的适配器。
 @param sectionController段控制器输入范围。
*/
-(void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController<IGListSectionType> *)sectionController{
    if (_downloadedImage!=nil || _task!=nil) {
        return;
    }
    
    NSString *urlString = self.urlString;
    NSURL *url=[NSURL URLWithString:urlString];
    
    NSInteger section = [self.collectionContext sectionForSectionController:self];
    NSLog(@"section %zi 正在下载 %@ 图片",section,urlString);
    _task=[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"下载 %@ 出错了：%@",urlString,error.localizedDescription);
            return;
        }
        UIImage *image=[UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _downloadedImage=image;
            [(ImageCell *)[self.collectionContext cellForItemAtIndex:1 sectionController:self] setImage:image];
        });
    }];
    [_task resume];
}

/**
 通知代表部分控制器退出工作范围。

 @param listAdapter控制列表的适配器。
 @param sectionController退出范围的段控制器。
*/
-(void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController<IGListSectionType> *)sectionController{
    
}

@end

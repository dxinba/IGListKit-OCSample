//
//  GridSectionController.h
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

#import <IGListKit/IGListKit.h>

@interface GridItem : NSObject<IGListDiffable>
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) NSInteger itemCount;

-(instancetype)init:(UIColor *)color itemCount:(NSInteger)itemCount;
@end

@interface GridSectionController : IGListSectionController<IGListSectionType>
@property (nonatomic,strong) GridItem *object;
@end

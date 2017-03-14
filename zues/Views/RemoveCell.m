//
//  RemoveCell.m
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

#import "RemoveCell.h"

@interface RemoveCell ()
@property (nonatomic,strong) UIButton *button;
@end

@implementation RemoveCell

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"移除" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return _button;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    CGRect slice,remainder;
    CGRectDivide(self.bounds, &slice, &remainder, 100, CGRectMaxXEdge);
    _label.frame = CGRectInset(slice, 15, 0);
    self.button.frame = remainder;
}

-(void)onButton:(UIButton *)button{
    _delegate?[_delegate removeCellDidTapButton:self]:nil;
}

@end

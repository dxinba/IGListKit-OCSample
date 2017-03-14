//
//  ImageCell.m
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

#import "ImageCell.h"

@interface ImageCell ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@end

@implementation ImageCell
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds=YES;
        _imageView.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView startAnimating];
    }
    return _activityView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.activityView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    _activityView.center=CGPointMake(bounds.size.width/2, bounds.size.height/2);
    _imageView.frame=bounds;
}

-(void)setImage:(UIImage *)image{
    _imageView.image=image;
    if (image!=nil) {
        [_activityView stopAnimating];
    }
    else{
        [_activityView startAnimating];
    }
}

@end

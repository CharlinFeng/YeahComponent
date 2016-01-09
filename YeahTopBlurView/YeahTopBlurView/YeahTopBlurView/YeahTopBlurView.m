//
//  YeahTopBlurView.m
//  YeahTopBlurView
//
//  Created by 冯成林 on 16/1/9.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "YeahTopBlurView.h"
#import "FXBlurView.h"


@interface YeahTopBlurView ()

@property (nonatomic,weak) UIImageView *imageView,*gradientImageView;


@end


@implementation YeahTopBlurView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}



/*
 *  视图准备
 */
-(void)viewPrepare{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIImageView *gradientImageView = [[UIImageView alloc] init];
    gradientImageView.image = [UIImage imageNamed:@"YeahTopBlurView.bundle/gradient.png"];
    gradientImageView.contentMode = UIViewContentModeCenter;
    gradientImageView.clipsToBounds = YES;
    gradientImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:gradientImageView];
    self.gradientImageView = gradientImageView;
    
    self.clipsToBounds = YES;
}



-(void)setImage:(UIImage *)image{

    _image = image;
    
    if(image == nil) return;
    
    self.imageView.image = [image blurredImageWithRadius:60 iterations:5 tintColor:[UIColor clearColor]];
}



-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat h = 100;
    CGFloat w = self.bounds.size.width;
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height - h;
    
    self.gradientImageView.frame = CGRectMake(x, y, w, h);
}




@end

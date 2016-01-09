//
//  ViewController.m
//  YeahTopBlurView
//
//  Created by 冯成林 on 16/1/9.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "YeahTopBlurView.h"
#import "UIImageView+CoreYYWebImage.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet YeahTopBlurView *yeahTopBlurView;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"http://img.netbian.com/file/20131220/cd39faa3b64d51fb8c63838e2bc9ce01.jpg";
    
    [self.imageV imageWithUrl:url placeHolderImage:nil compeleteBlock:^(UIImage *image) {
        
        self.yeahTopBlurView.image = image;
        
    }];
    
    
}

@end

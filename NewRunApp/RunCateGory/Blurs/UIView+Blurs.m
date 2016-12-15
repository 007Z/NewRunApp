//  UIView+Blurs.m
//  frameTest
//  Created by zhao on 15/2/3.
//  Copyright (c) 2015年 zhao. All rights reserved.

#import "UIView+Blurs.h"
#import <CoreImage/CoreImage.h>

@implementation UIView (Blurs)
-(void)viewBlur
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage  *viewimg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CIContext  *context = [CIContext contextWithOptions:nil];
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewimg.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat:15] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    CGImageRef cgImage = [context createCGImage:resultImage fromRect:self.bounds];
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.tag = -1;
    imageView.image = blurredImage;
    
    UIView *overlay = [[UIView alloc] initWithFrame:self.bounds];
    overlay.tag = -2;
    overlay.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [self addSubview:imageView];
    [self addSubview:overlay];
}

-(void)viewUnBlur
{
    [[self viewWithTag:-1] removeFromSuperview];
    [[self viewWithTag:-2] removeFromSuperview];
}

@end

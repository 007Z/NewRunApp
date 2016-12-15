//
//  RunSettingCell.m
//  Runapp
//
//  Created by 耿用强 on 15/8/30.
//  Copyright (c) 2015年 gyq. All rights reserved.
//

#import "RunPerSonCell.h"

@implementation RunPerSonCell
{
    UIImageView*_leftImage;
    UILabel*_name;
    UIView*_line;
    UIImageView*_rightImage;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _leftImage=[[UIImageView alloc]init];
        [self addSubview:_leftImage];
        
        
        _name=[[UILabel alloc]init];
        _name.backgroundColor=[UIColor clearColor];
        _name.font=FONT_(15);
        _name.textColor=[UIColor darkGrayColor];
        [self.contentView addSubview:_name];
        
        _line=[[UIView alloc]init];
        _line.backgroundColor=RGBColor(223, 223, 221, 1);
        [self.contentView addSubview:_line];
        
        _rightImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pers_open_ico"]];
        _rightImage.hidden=YES;
        [self.contentView addSubview:_rightImage];
    }
    return self;
}


- (void)showInfo:(NSDictionary*)dic andIndex:(NSIndexPath*)index
{
    _leftImage.image=[UIImage imageNamed:dic[@"image"]];
    _name.text=dic[@"text"];
    if (index.row==0) {
        _rightImage.hidden=YES;
    }
    else
    {
        _rightImage.hidden=NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _leftImage.frame=CGRectMake(RESIZE_UI(8), (self.height-RESIZE_UI(50/2))/2, RESIZE_UI(50/2), RESIZE_UI(50/2));
    _name.frame=CGRectMake(_leftImage.right+RESIZE_UI(8), 0, RESIZE_UI(200), self.height);
    _rightImage.frame=CGRectMake(self.width-RESIZE_UI(17/2)-RESIZE_UI(10), (self.height-RESIZE_UI(30/2))/2, RESIZE_UI(17/2), RESIZE_UI(30/2));
    _line.frame=CGRectMake(0, self.height-0.5, self.width,0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

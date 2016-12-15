//
//  RunBottomView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunBottomView.h"

@interface RunBottomView ()

/**文字订单按钮*/
@property(nonatomic,strong)UIButton  *RunWordBrn;
/**语音订单按钮*/
@property(nonatomic,strong)UIButton  *RunVoiceBtn;

@end

@implementation RunBottomView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    _RunWordBrn = [UIButton createBtnWithnorImage:@"key1" selectedImage:@"key1" target:self action:@selector(WordOrderMethod)];
    [self addSubview:_RunWordBrn];
    
    _RunVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_RunVoiceBtn setBackgroundImage:[UIImage imageNamed:@"初始"] forState:UIControlStateNormal];
    [_RunVoiceBtn addTarget:self action:@selector(recordStart) forControlEvents:UIControlEventTouchDown];
    [_RunVoiceBtn addTarget:self action:@selector(recordEnd) forControlEvents:UIControlEventTouchUpInside];
    [_RunVoiceBtn addTarget:self action:@selector(recordDrag) forControlEvents:UIControlEventTouchDragExit];
    [self addSubview:_RunVoiceBtn];
}

-(void)layoutSubviews
{
    _RunWordBrn.frame = CGRectMake(RESIZE_UI(15),(self.height-RESIZE_UI(75/2))/2, RESIZE_UI(75/2), RESIZE_UI(75/2));
    _RunVoiceBtn.frame = CGRectMake(SCREEN_WIDTH-RESIZE_UI(15)-RESIZE_UI(568/2),(self.height-RESIZE_UI(92/2))/2,RESIZE_UI(568/2), RESIZE_UI(92/2));
}

//文字下单
-(void)WordOrderMethod
{
    if (self.wordOrderBlock) {
        self.wordOrderBlock();
    }
}

//语音下单
-(void)recordStart
{
    [_RunVoiceBtn setImage:[UIImage imageNamed:@"按下"] forState:UIControlStateHighlighted];
    if (self.voiceOrderBlock) {
        self.voiceOrderBlock(1);
    }
}

-(void)recordEnd
{
    [_RunVoiceBtn setImage:[UIImage imageNamed:@"初始"] forState:UIControlStateNormal];
    if (self.voiceOrderBlock) {
        self.voiceOrderBlock(2);
    }
}

-(void)recordDrag
{
    if (self.voiceOrderBlock) {
        self.voiceOrderBlock(3);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

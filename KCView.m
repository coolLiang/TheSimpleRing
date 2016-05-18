//
//  KCView.m
//  test
//
//  Created by noci on 16/5/18.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "KCView.h"

@interface KCView()

@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)UILabel * scoreLabel;

@property(nonatomic,strong)UILabel * fenLabel;

@end

@implementation KCView

-(instancetype)initWithTotalScore:(float)score
{
    self = [super init];
    
    if (self) {
        
        _totalScore = score;
        [self buildUI];
        [self buildCS];
    }
    
    return self;
}

-(void)buildUI
{
    self.contentView = [[UIView alloc]init];
    [self addSubview:self.contentView];
    
    self.scoreLabel = [[UILabel alloc]init];
    self.scoreLabel.text = @"4.3";
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.textAlignment = 1;
    [self.contentView addSubview:self.scoreLabel];
    
    self.fenLabel = [[UILabel alloc]init];
    self.fenLabel.text = @"分";
    self.fenLabel.textColor  = [UIColor whiteColor];
    self.fenLabel.textAlignment = 1;
    [self.contentView addSubview:self.fenLabel];
    
}

-(void)buildCS
{
    //计算下 2个label 一共需要多少高.
    
    CGSize scoreSize =  [self.scoreLabel.text sizeWithAttributes:@{NSFontAttributeName:self.scoreLabel.font}];
    CGSize fenSize = [self.fenLabel.text sizeWithAttributes:@{NSFontAttributeName:self.fenLabel.font}];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(ceil(scoreSize.height) + ceil(fenSize.height));
        
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(self.contentView.mas_width);
        
    }];
    
    [self.fenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(self.mas_width);
        
    }];
}

//赋值时 刷新圆环数据。
-(void)setScoreValue:(float)scoreValue
{
    _scoreValue = scoreValue;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f",scoreValue];
    [self setNeedsDisplay];
    
    
}

-(void)drawRect:(CGRect)rect
{
    if (_scoreValue == 0) {
        
        _scoreValue = _totalScore;
        
    }
    
    //计算当前得分占总得分的比例。
    float percent  = _scoreValue / _totalScore ;
    //当前得分比例 跟 总分 
    float result = 1 - percent;
    //计算当前得出比例需要从哪个位置开始
    float start = M_PI * 1.5 + 2 * M_PI * result / 2;
    //计算当前得出比例需要从哪个位置结束
    float end = M_PI * 3.5 - 2 * M_PI * result / 2;
    //计算self的中心点。
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    //半径。
    float r = (rect.size.width - 4) / 2;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:center radius:r startAngle:M_PI * 1.5 endAngle: M_PI * 3.5 clockwise:YES];
    [path1 setLineWidth:2];
    [[UIColor lightGrayColor]setStroke];
    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:center radius:r startAngle:start endAngle:end clockwise:YES];
    [path2 setLineWidth:2];
    [[UIColor yellowColor]setStroke];
    [path2 stroke];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

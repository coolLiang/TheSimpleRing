//
//  KCView.h
//  test
//
//  Created by noci on 16/5/18.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCView : UIView

{
    float _totalScore;
}

-(instancetype)initWithTotalScore:(float)score;


@property(nonatomic,assign)float  scoreValue;


@end

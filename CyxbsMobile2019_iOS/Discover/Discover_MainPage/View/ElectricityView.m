//
//  ElectricityView.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/6/8.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ElectricityView.h"
@interface ElectricityView()
@property NSUserDefaults *defaults;
@end

@implementation ElectricityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUserDefaults];//加载缓存用作视图的初始化
        [self addNoBindingView];
        [self addClearButton];//添加透明按钮用来在被点击后设置宿舍
    }
    return self;
}
-(void)addNoBindingView {
     if (@available(iOS 11.0, *)) {
        self.backgroundColor = [UIColor colorNamed:@"colorLikeWhite&#1D1D1D" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    } else {
        // Fallback on earlier versions
    }
    self.layer.shadowOpacity = 0.16f;
    self.layer.shadowColor = [UIColor colorWithRed:174/255.0 green:182/255.0 blue:211/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.cornerRadius = 25;
    self.clipsToBounds = YES;
    [self addTitle];
    [self addHintLabel];
}
-(void)removeUnbindingView {
//    [self.electricFeeTitle removeFromSuperview];
    [self.hintLabel removeFromSuperview];
}
-(void) addClearButton {
    UIButton * button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(touchSelf) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}
//被点击时调用的方法
-(void)touchSelf {
    if ([self.delegate respondsToSelector:@selector(touchElectrictyView)]) {
        [self.delegate touchElectrictyView];
    }
}

-(void)refreshViewIfNeeded {
    [self removeUnbindingView];
    [self addBindingView];
}

- (void)loadUserDefaults {
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    self.defaults = defualts;
}


//MARK: 公共部分
- (void)addTitle {
    UILabel *title = [[UILabel alloc]init];//左上角标题
    self.electricFeeTitle = title;
    title.text = @"电费查询";
    title.font = [UIFont fontWithName:PingFangSCBold size: 18];
    if (@available(iOS 11.0, *)) {
        title.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:title];
    [self.electricFeeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self).offset(23);
    }];
    
    
}


//MARK: 未绑定部分
- (void)addHintLabel {
    UILabel *hintLabel = [[UILabel alloc]init];
    self.hintLabel = hintLabel;
    hintLabel.text = @"还未绑定账号哦～";
    hintLabel.font = [UIFont fontWithName:PingFangSCLight size: 15];
    if (@available(iOS 11.0, *)) {
        hintLabel.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeTitle.mas_bottom).offset(38);
        make.left.equalTo(self.electricFeeTitle.mas_right).offset(41);
    }];
}

//MARK: 绑定部分
- (void) addBindingView {
//    [self addSubview:self.electricFee];

    [self addChildViewToElectricFeeButton];//给按钮添加子视图
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.16f;
    self.layer.shadowColor = [UIColor colorWithRed:174/255.0 green:182/255.0 blue:211/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    
}

- (void)addChildViewToElectricFeeButton {
    //其中涉及网络请求的有time,money,degree
//    [self addTitle];
    [self addTime];
    [self addMoney];
    [self addDegree];
    [self addYuan];
    [self addDu];
    [self addHintLeft];
    [self addHintRight];
}



- (void)addTime {
    UILabel *time = [[UILabel alloc]init];//右上角抄表时间
    self.electricFeeTime = time;
    if ([self.defaults objectForKey:@"ElectricFee_time"]!= NULL) {
        time.text = [self.defaults objectForKey:@"ElectricFee_time"];
    }else {
        time.text = @"加载失败";
    }
    if (@available(iOS 11.0, *)) {
        time.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    time.alpha = 0.54;
    time.font = [UIFont fontWithName:PingFangSCLight size: 10];
    [self addSubview:time];
    [self.electricFeeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.electricFeeTitle);
        make.right.equalTo(self).offset(-15);
    }];
}

- (void)addMoney {
    UIButton *money = [[UIButton alloc]init];//左边数字
    self.electricFeeMoney = money;
    if ([self.defaults objectForKey:@"ElectricFee_money"] != NULL) {
        [money setTitle:[self.defaults objectForKey:@"ElectricFee_money"] forState:UIControlStateNormal];
    }else {
        [money setTitle:@"0" forState:UIControlStateNormal];
    }
//    money.text = @"0";
    if (@available(iOS 11.0, *)) {
        [money setTitleColor:Color42_78_132 forState:UIControlStateNormal];
    } else {
        // Fallback on earlier versions
    }
    money.titleLabel.font = [UIFont fontWithName:ImpactMedium size: 36];
    [self addSubview:money];
    [self.electricFeeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeTitle.mas_bottom).offset(17);
        make.centerX.equalTo(self).offset(-self.width / 4.0);
        make.height.equalTo(@44);
    }];
}

- (void)addDegree {
    UILabel *degree = [[UILabel alloc]init];//右边数字
    self.electricFeeDegree = degree;
    NSLog(@"%@",[self.defaults objectForKey:@"ElectricFee_degree"]);
    if ([self.defaults objectForKey:@"ElectricFee_degree"]){
        degree.text = [NSString stringWithFormat:@"%@", [self.defaults objectForKey:@"ElectricFee_degree"]];
    }else {
        degree.text = @"0";
    }
    
    if (@available(iOS 11.0, *)) {
        degree.textColor = Color42_78_132;
    } else {
        // Fallback on earlier versions
    }
    degree.font = [UIFont fontWithName: ImpactMedium size: 36];
    [self addSubview:degree];
    [self.electricFeeDegree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeMoney);
        make.centerX.equalTo(self).offset(self.width / 4.0);
        make.height.equalTo(@44);
    }];
}

- (void)addYuan {
    UILabel *yuan = [[UILabel alloc]init];//汉字“元”
    self.electricFeeYuan = yuan;
        yuan.text = @"元";
    if (@available(iOS 11.0, *)) {
        yuan.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    yuan.font = [UIFont fontWithName:PingFangSCMedium size: 13];
    [self addSubview:yuan];
    [self.electricFeeYuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.electricFeeMoney.mas_right).offset(9);
        make.bottom.equalTo(self.electricFeeMoney).offset(-6);
    }];
}

- (void)addDu {
    UILabel *du = [[UILabel alloc]init];//汉字“度”
    self.electricFeeDu = du;
        du.text = @"度";
    if (@available(iOS 11.0, *)) {
        du.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    du.font = [UIFont fontWithName:PingFangSCMedium size: 13];
    [self addSubview:du];
    [self.electricFeeDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.electricFeeDegree.mas_right).offset(9);
        make.bottom.equalTo(self.electricFeeDegree).offset(-6);
    }];
}

- (void)addHintLeft {
    UILabel *hintLeft = [[UILabel alloc]init];//汉字“费用、本月”
    self.electricFeeHintLeft = hintLeft;
    hintLeft.text = @"费用/本月";
    hintLeft.font = [UIFont fontWithName:PingFangSCLight size: 13];
    if (@available(iOS 11.0, *)) {
        hintLeft.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    hintLeft.alpha = 0.6;
    [self addSubview:hintLeft];
    [self.electricFeeHintLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeMoney.mas_bottom);
        make.centerX.equalTo(self.electricFeeMoney);
    }];
}

- (void)addHintRight {
    UILabel *hintRight = [[UILabel alloc] init];//汉字“使用度数，本月”
    self.electricFeeHintRight = hintRight;
        hintRight.text = @"使用度数/本月";
    hintRight.font = [UIFont fontWithName:PingFangSCLight size: 13];
    if (@available(iOS 11.0, *)) {
        hintRight.textColor = Color21_49_91_F0F0F2;
    } else {
        // Fallback on earlier versions
    }
    hintRight.alpha = 0.6;
    [self addSubview:hintRight];
    [self.electricFeeHintRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeDegree.mas_bottom);
        make.centerX.equalTo(self.electricFeeDegree);
    }];
}

@end

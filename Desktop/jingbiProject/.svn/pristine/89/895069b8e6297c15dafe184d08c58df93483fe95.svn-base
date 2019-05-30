//
//  BFEXReChartWayTableViewCell.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXReChartWayTableViewCell.h"
#import "ManagerSocket.h"



@interface BFEXReChartWayTableViewCell()
//支付方式img
@property (nonatomic, strong) UIImageView *imgTitle;
//支付name
@property (nonatomic, strong) UILabel *weChatLabel;
//支付详情
@property (nonatomic, strong) UILabel *messageLabel;
//修改按钮
@property (nonatomic, strong) UIButton *changedBtn;
//开关
@property (nonatomic, strong) UIButton *switchButton;

@property (nonatomic, strong) NSDictionary *dataDic;
@end

@implementation BFEXReChartWayTableViewCell

//+(instancetype)getCellFromTable:(UITableView *)table indexPath:(NSIndexPath *)path
//{
//    BFEXReChartWayTableViewCell *cell  = [table dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
//    if (!cell)
//    {
//        cell = [[BFEXReChartWayTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),path.row]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    return cell;
//};
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = kMainBackgroundColor;
        [self viewConfigs];
    }
    return self;
}

-(void)viewConfigs
{
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 114, Screen_Width, 1.f)];
//    lineView.backgroundColor = RGBCOLOR16(0xeeeeee);
//    [self.contentView addSubview:lineView];
    [self imgTitle];
    [self weChatLabel];
    [self messageLabel];
    [self switchButton];
    [self changedBtn];
}
-(UIImageView *)imgTitle
{
    if (!_imgTitle) {
        _imgTitle = [[UIImageView alloc]init];
        _imgTitle.image = [UIImage imageNamed:@"weixin-icon"];
        [self.contentView addSubview:_imgTitle];
        [_imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
//            make.height.equalTo(@(ScaleW(33)));
            make.top.equalTo(@(ScaleW(20)));
        }];
    }
    return _imgTitle;
}

-(UILabel *)weChatLabel{
    if (!_weChatLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:ScaleW(15)];
        label.text = SSKJLocalized(@"微信", nil);
        label.textColor = kMainWihteColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgTitle.mas_centerY);
            make.left.equalTo(_imgTitle.mas_right).offset(ScaleW(15));
        }];
        _weChatLabel = label;
    }
    return _weChatLabel;
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:ScaleW(12)];
        label.text = @"郭爱鹏    187128347237";
        label.textColor = kMainWihteColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_weChatLabel.mas_bottom).offset(ScaleW(13));
            make.left.equalTo(_weChatLabel.mas_left);
        }];
        _messageLabel = label;
    }
    return _messageLabel;
}
-(UIButton *)changedBtn{
    if (!_changedBtn) {
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
        [button setTitle:SSKJLocalized(@"修改", nil) forState:UIControlStateNormal];
        [button setTitleColor:kMainTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.weChatLabel.mas_left);
            make.top.equalTo(self.messageLabel.mas_bottom).offset(ScaleW(10));
            make.height.equalTo(@(ScaleW(30)));
        }];
        _changedBtn = button;
    }
    return _changedBtn;
}

-(void)buttonClicked:(UIButton *)sender
{
    !self.edtingBlock?:self.edtingBlock(_dataDic);
}

-(UIButton *)switchButton
{
    if (!_switchButton) {
        _switchButton = [[UIButton alloc]init];
        [_switchButton setImage:[UIImage imageNamed:@"switch_on"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"switch_off"] forState:UIControlStateSelected];
        [self.contentView addSubview:_switchButton];
        [_switchButton addTarget:self action:@selector(swithAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.changedBtn.mas_right).offset(ScaleW(15));
            make.centerY.equalTo(self.changedBtn.mas_centerY);
            make.height.equalTo(self.changedBtn.mas_height);
        }];
    }
    return _switchButton;
}
-(void)swithAction:(UIButton *)swith
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//
//    [HttpTool postWithURL:KchangePaystatus params:@{@"type":_dataDic[@"type"],@"account":KAccount,@"val":[NSString stringWithFormat:@"%d",swith.selected]} success:^(id json) {
//        [hud hideAnimated:YES];
//        
//        WL_NetWork_Model *model = [WL_NetWork_Model mj_objectWithKeyValues:json];
//        if (model.status.integerValue == 200) {
//            [MBProgressHUD showError:ZBLocalized(@"操作成功", nil)];
//            swith.selected = !swith.selected;
//        }else{
//            [MBProgressHUD showError:ZBLocalized(@"操作失败", nil)];
//        }
//        
//    } failure:^(NSError *error) {
//        [hud hideAnimated:YES];
//    }];
}
-(void)setValueData:(id)data
{
    _dataDic = data;
    NSString *img = nil;
    if ([_dataDic[@"type"] isEqualToString:@"backcard"]) {
      //银行卡
        img = @"yinlian-icon";
    }
    if ([_dataDic[@"type"] isEqualToString:@"wx"]) {
      img = @"weixin-icon";
    }
//wei-xin yinhang-ka zhifu-bao
    if ([_dataDic[@"type"] isEqualToString:@"alipay"]) {
      img = @"zhifubao-icon";
    }
    if ([_dataDic[@"type"] isEqualToString:@"paypal"]) {
        img = @"IOAEX_paypai";
    }
    _imgTitle.image = [UIImage imageNamed:img];
    _weChatLabel.text = SSKJLocalized(data[@"tip"], nil) ;
//    _messageLabel.text = [NSString stringWithFormat:@"%@  %@  %@",data[@"number"],[ManagerSocket sharedManager].model.realname,SSKJLocalized(data[@"tip"], nil)];
    self.switchButton.selected = ![NSString stringWithFormat:@"%@",data[@"status"]].integerValue;
};
@end

//
//  GroupDetailViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/17.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "GroupDetailViewController.h"
#import <WebKit/WebKit.h>

@interface GroupDetailViewController ()<WKNavigationDelegate, UITextFieldDelegate>
/** h5页面*/
@property (nonatomic, strong) WKWebView *webView;

/** 收藏按钮*/
@property (nonatomic, strong) UIButton *favoriteBtn;
/** 分享按钮*/
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) TravelCommentView *commentView;//评论组件

/** 详情model*/
@property (nonatomic, strong) GroupProModel *detailModel;

/** 上半部*/
@property (nonatomic, strong) UIView *upView;
/** 头视图*/
@property (nonatomic, strong) UIImageView *headIv;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 购买按钮*/
@property (nonatomic, strong) UIButton *buyBtn;
/** 价格视图*/
@property (nonatomic, strong) UIView *priceView;
/** 详情背景view*/
@property (nonatomic, strong) UIView *downView;
/** 查看评论*/
@property (nonatomic, strong) UIButton *lookCommentBtn;

/** 详情模块*/
@property (nonatomic, strong) UIView *contentInView;
/** 详情标题*/
@property (nonatomic, strong) UILabel *contentTitleLb;
/** 详情图标*/
@property (nonatomic, strong) UIView *contentIv;
/** 详情内容*/
@property (nonatomic, strong) UILabel *contentLb;

/** 当前价格*/
@property (nonatomic, strong) UILabel *disPriceLb;
/** 原价*/
@property (nonatomic, strong) UILabel *priceLb;
/** 折扣*/
@property (nonatomic, strong) UILabel *disCountLb;
/** 钟表标志*/
@property (nonatomic, strong) UIImageView *timeIv;
/** 团购状态*/
@property (nonatomic, strong) UILabel *groupStyleLb;




@end

@implementation GroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"详情页面";
    [self.contentView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- NaviBar_HEIGHT - 50)];
    [self.contentView addSubview:self.upView];
    [self.contentView setBackgroundColor:BACKGROUNDCOLOR];
    [self.contentView addSubview:self.lookCommentBtn];
    [self.contentView addSubview:self.contentInView];
    [self.view addSubview:self.commentView];
    [self setNavi];
    [self loadData];
    
    [NotificationCenter addObserver:self selector:@selector(keyBoardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [NotificationCenter addObserver:self selector:@selector(keyBoardHideAction:) name:UIKeyboardWillHideNotification object:nil];
//    [SVProgressHUD show];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _upView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(425);
    _lookCommentBtn.sd_layout
    .topSpaceToView(_upView, 5)
    .leftSpaceToView(self.contentView, 5)
    .rightSpaceToView(self.contentView, 5)
    .heightIs(50);
    
    _contentInView.sd_layout
    .topSpaceToView(_lookCommentBtn, 15)
    .leftSpaceToView(self.contentView, 7)
    .rightSpaceToView(self.contentView, 7);
    [_contentInView setSd_cornerRadius:@5];
    
    _contentIv.sd_layout
    .topSpaceToView(_contentInView, 17)
    .leftSpaceToView(_contentInView, 10)
    .heightIs(5)
    .widthEqualToHeight();
    [_contentIv setSd_cornerRadiusFromWidthRatio:@0.5];
    
    _contentTitleLb.sd_layout
    .centerYEqualToView(_contentIv)
    .leftSpaceToView(_contentIv, 5)
    .autoHeightRatio(0);
    [_contentTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    
    _contentLb.sd_layout
    .topSpaceToView(_contentTitleLb, 15)
    .leftSpaceToView(_contentInView, 15)
    .rightSpaceToView(_contentInView, 15)
    .autoHeightRatio(0);
    [_contentInView setupAutoHeightWithBottomView:_contentLb bottomMargin:15];
    
    [self.contentView setupAutoHeightWithBottomView:_contentInView bottomMargin:20];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [NotificationCenter removeObserver:self];
}

- (void)setNavi{
    UIBarButtonItem *itmeShare = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    UIBarButtonItem *itmeFavo = [[UIBarButtonItem alloc] initWithCustomView:self.favoriteBtn];
    self.navigationItem.rightBarButtonItems = @[itmeShare, itmeFavo];
    
    
}

- (void)loadData{
    /*********************************************************************
     函数名称 : getGroupProDetailWithDictionary:
     函数描述 : 团购商品详情接口（Group_Json）
     输入参数 : id ：商品id
     返回值 : success（GroupProModel），responseFailure（errCode、errorMsg）
     作者   : 张永亮
     *********************************************************************/

    WeakObj(self);
    [ShareBusinessManager.groupManager getGroupProDetailWithDictionary:@{@"id":_model.gid}
                                                               success:^(GroupProModel *groupProModel) {
                                                                   weakself.detailModel = groupProModel;
                                                                   [weakself updateUI];
                                                               } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                   [SVProgressHUD showErrorWithStatus:errorMsg];
                                                               }];
}

- (void)updateUI{
    [_headIv sd_setImageWithURL:LOGOURL(_detailModel.logo) placeholderImage:Placeholder_big];
    _titleLb.text = _detailModel.title;
    _contentLb.text = _detailModel.content;
//    _detailModel.
    _disPriceLb.text = [NSString stringWithFormat:@"%@ 元",_detailModel.price2];
    NSString *str = [NSString stringWithFormat:@"%@ 元",_detailModel.price1];
    _priceLb.attributedText = [[NSAttributedString alloc] initWithString:str attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSStrokeColorAttributeName:LIGHTTEXTCOLOR}];
    
    CGFloat price = _detailModel.price1.floatValue;
    CGFloat disPrice = _detailModel.price2.floatValue;
    CGFloat discount = disPrice / price;
    _disCountLb.text = [NSString stringWithFormat:@"%.1f折", discount *10];
    if ([self intervalSinceNow:_detailModel.endtime] < 0) {
        _groupStyleLb.text = @"活动已结束";
        _buyBtn.enabled = NO;
    }else{
        _groupStyleLb.text = @"活动进行中";
        _buyBtn.enabled = YES;
    }
}

/** 计算时间*/
- (double)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=late-now;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString=[NSString stringWithFormat:@"%@小时", timeString];
        
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天", timeString];
        
    }
    return cha;
}
#pragma mark ----------------收藏和分享

- (void)collectAction{
    
    if (!IsLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    
    [SVProgressHUD show];
    
    [ShareBusinessManager.userManager addFavWithDictionary:@{@"obj.uid":UserID,
                                                             @"obj.infotype":@"group",
                                                             @"obj.infoid":_model.gid}
                                                   success:^(id object) {
                                                       [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                       [SVProgressHUD showErrorWithStatus:@"已收藏"];
                                                   }];
}

- (void)shareAction{
    
    WeakObj(self);
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        [weakself shareDataWithPlatform:platformType];
    }];
    
}

- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType{
    // 创建UMSocialMessageObject实例进行分享
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = @"分享高尔夫";
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        
    }];
    
}
/** 发表评论*/
- (void)postComment{
    //发送评论
    /*********************************************************************
     函数名称 : addDiscussWithDictionary:
     函数描述 : 发布评论接口（DisAll_Add）
     输入参数 : obj.linkid：信息链接ID，obj.type：信息类型，obj.title：信息标题，obj.logo：图片，obj.content：信息内容
     obj.regtime：发布时间，obj.examin：检测，obj.uid：发布人ID，obj.cid：应用ID
     返回值 : success：1，responseFailure：0
     作者   : 张永亮
     *********************************************************************/
    if (!IsLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    
    
    [_commentView.commentTf resignFirstResponder];
    if (_commentView.commentTf.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    NSString *time = [NSDate jk_stringWithDate:[NSDate date] format:[NSDate jk_ymdHmsFormat]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:_model.gid forKey:@"obj.linkid"];
    [dict setValue:@"group" forKey:@"obj.type"];
    [dict setValue:_commentView.commentTf.text forKey:@"obj.content"];
    [dict setValue:time forKey:@"obj.regtime"];
    [dict setValue:APPCID forKey:@"obj.cid"];
    [dict setValue:UserID forKey:@"obj.uid"];
    [dict setValue:_model.title forKey:@"obj.title"];
    [dict setValue:[UserDefault objectForKey:@"userLogo"] forKey:@"obj.logo"];
    
    WeakObj(self);
    [ShareBusinessManager.newsManager addDiscussWithDictionary:dict
                                                       success:^(id object) {
                                                           [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                                                           [weakself loadData];
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:@"评论失败"];
                                                       }];
    _commentView.commentTf.text = @"";//评论完成后清空输入框
    
}
/** 查看评论*/
- (void)lookCommnetAction{
    CommentListViewController *com = [[CommentListViewController alloc] init];
    com.titleText = _detailModel.title;
    com.type = @"group";
    com.ID = _detailModel.gid;
    [self.navigationController pushViewController:com animated:YES];
}

- (void)buyAction{
    //先执行加入购物车操作。再执行跳转购物车界面操作
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil]
        ;
        return;
    }
    WeakObj(self);
    [ShareBusinessManager.mallManager addCartWithDictionary:@{@"obj.uid":UserID,
                                                              @"obj.cid":APPCID,
                                                              @"obj.proid":_detailModel.gid,
                                                              @"obj.isGroup":@1,
                                                              @"obj.num":@1}
                                                    success:^(id object) {
                                                        ProductCarViewController *carVc = [[ProductCarViewController alloc] init];
                                                        [weakself.navigationController pushViewController:carVc animated:YES];
                                                    } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                        //购物车已经存在
                                                        [CommenIdea alertWithTarget:self Title:@"购物车内已存在此商品" message:@"是否跳转购物车" action_0:@"否" action_1:@"是" block_0:nil block_1:^{
                                                            ProductCarViewController *carVc = [[ProductCarViewController alloc] init];
                                                            [weakself.navigationController pushViewController:carVc animated:YES];
                                                        }];
                                                    }];
}
#pragma mark ----------------监听输入框弹出和隐藏

- (void)keyBoardShowAction:(NSNotification *)fication{
    NSDictionary *info = [fication userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    WeakObj(self);
    [UIView animateWithDuration:0.15 animations:^{
        weakself.commentView.transform = CGAffineTransformMakeTranslation(0, -keyboardSize.height);
    }];
    
}

- (void)keyBoardHideAction:(NSNotification *)fication{
    WeakObj(self);
    
    [UIView animateWithDuration:0.15 animations:^{
        weakself.commentView.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([[[UITextInputMode currentInputMode] primaryLanguage]isEqualToString:@"emoji"]) {
        [SVProgressHUD showErrorWithStatus:@"暂不支持表情符号，请重新输入"];
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark ----------------输入代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_commentView.commentTf resignFirstResponder];
    [self postComment];
    return YES;
}


#pragma mark ----------------实例化


- (UIButton *)favoriteBtn{
    if (!_favoriteBtn) {
        _favoriteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_favoriteBtn setImage:IMAGE(@"dt_collect") forState:UIControlStateNormal];
        [_favoriteBtn addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoriteBtn;
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_shareBtn setImage:IMAGE(@"dt_share") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (TravelCommentView *)commentView{
    if (_commentView == nil) {
        _commentView = [[TravelCommentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - NaviBar_HEIGHT, SCREEN_WIDTH, 50)];
        _commentView.backgroundColor = WHITECOLOR;
        WeakObj(self);
        _commentView.block = ^(){
            [weakself postComment];
        };
        _commentView.commentLb.text = @"发表";
        _commentView.commentTf.delegate = self;
    }
    return _commentView;
    
    
}

- (UIView *)upView{
    if (!_upView) {
        _upView = [[UIView alloc] init];
        _upView.backgroundColor = WHITECOLOR;
        [_upView addSubview:self.headIv];
        [_upView addSubview:self.titleLb];
        [_upView addSubview:self.buyBtn];
        [_upView addSubview:self.priceView];
        [_upView addSubview:self.timeIv];
        [_upView addSubview:self.groupStyleLb];
        
        _headIv.sd_layout
        .topSpaceToView(_upView, 0)
        .leftSpaceToView(_upView, 0)
        .rightSpaceToView(_upView, 0)
        .heightIs(280);
        
        _priceView.sd_layout
        .topSpaceToView(_headIv, 0)
        .leftSpaceToView(_upView, 0)
        .rightSpaceToView(_upView, 0)
        .heightIs(45);
        
        _titleLb.sd_layout
        .topSpaceToView(_priceView, 25)
        .leftSpaceToView(_upView, 5)
        .rightSpaceToView(_upView, 5)
        .autoHeightRatio(0);
        
        _buyBtn.sd_layout
        .bottomSpaceToView(_upView, 5)
        .rightSpaceToView(_upView, 5)
        .heightIs(35)
        .widthIs(165);
        [_buyBtn setSd_cornerRadius:@3];
        
        _timeIv.sd_layout
        .centerYEqualToView(_buyBtn)
        .leftSpaceToView(_upView, 7)
        .heightIs(30)
        .widthIs(26);
        
        _groupStyleLb.sd_layout
        .centerYEqualToView(_timeIv)
        .leftSpaceToView(_timeIv, 5)
        .autoHeightRatio(0);
        [_groupStyleLb setSingleLineAutoResizeWithMaxWidth:300];
        
        
    }
    return _upView;

}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(20);
        _titleLb.textColor = BLACKTEXTCOLOR;
    }
    return _titleLb;
}

- (UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] init];
        _buyBtn.titleLabel.font = FONT(20);
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:IMAGE(@"dt_buttonBuyNow") forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:IMAGE(@"dt_buttonBuyNowDisabled") forState:UIControlStateDisabled];
        [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UIView *)priceView{
    if (!_priceView) {
        _priceView = [[UIView alloc] init];
        _priceView.backgroundColor = RGBColor(237, 240, 242);
        UIImageView *iv = [[UIImageView alloc] init];
        iv.image = IMAGE(@"dt_lowPrise");
        [_priceView addSubview:iv];
        [_priceView addSubview:self.disPriceLb];
        [_priceView addSubview:self.priceLb];
        [_priceView addSubview:self.disCountLb];
        iv.sd_layout
        .topSpaceToView(_priceView, -2)
        .leftSpaceToView(_priceView, 0)
        .bottomSpaceToView(_priceView, -3)
        .widthIs(100);
        
        _disPriceLb.sd_layout
        .centerYEqualToView(_priceView)
        .leftSpaceToView(_priceView, 5)
        .autoHeightRatio(0);
        [_disPriceLb setSingleLineAutoResizeWithMaxWidth:300];
        
        _priceLb.isAttributedContent = YES;
        _priceLb.sd_layout
        .centerYEqualToView(_priceView)
        .leftSpaceToView(iv, 30)
        .autoHeightRatio(0);
        [_priceLb setSingleLineAutoResizeWithMaxWidth:300];

        _disCountLb.sd_layout
        .centerYEqualToView(_priceView)
        .leftSpaceToView(_priceLb, 25)
        .autoHeightRatio(0);
        [_disCountLb setSingleLineAutoResizeWithMaxWidth:300];
        
    }
    return _priceView;
}

- (UIButton *)lookCommentBtn{
    if (!_lookCommentBtn) {
        _lookCommentBtn = [[UIButton alloc] init];
        [_lookCommentBtn setBackgroundImage:IMAGE(@"IMG_0288 2") forState:UIControlStateNormal];
        [_lookCommentBtn addTarget:self action:@selector(lookCommnetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookCommentBtn;
}

- (UIView *)contentInView{
    if (!_contentInView) {
        _contentInView = [[UIView alloc] init];
        [_contentInView addSubview:self.contentTitleLb];
        [_contentInView addSubview:self.contentIv];
        [_contentInView addSubview:self.contentLb];
        _contentInView.layer.borderColor = BLACKTEXTCOLOR.CGColor;
        _contentInView.layer.borderWidth =1;
    }
    return _contentInView;
}

- (UILabel *)contentTitleLb{
    if (!_contentTitleLb) {
        _contentTitleLb = [[UILabel alloc] init];
        _contentTitleLb.font = FONT(20);
        _contentTitleLb.textColor = BLACKTEXTCOLOR;
        _contentTitleLb.text = @"商品介绍";
    }
    return _contentTitleLb;
}

- (UIView*)contentIv{
    if (!_contentIv) {
        _contentIv = [[UIView alloc] init];
        _contentIv.backgroundColor = [UIColor blueColor];
    }
    return _contentIv;
}

- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = FONT(18);
        _contentLb.textColor = BLACKTEXTCOLOR;
    }
    return _contentLb;
}

- (UILabel *)disPriceLb{
    if (!_disPriceLb) {
        _disPriceLb = [[UILabel alloc] init];
        _disPriceLb.font = FONT(18);
        _disPriceLb.textColor = WHITECOLOR;
    }
    return _disPriceLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(18);
        _priceLb.textColor = LIGHTTEXTCOLOR;
    }
    return _priceLb;
}

- (UILabel *)disCountLb{
    if (!_disCountLb) {
        _disCountLb = [[UILabel alloc] init];
        _disCountLb.font = FONT(18);
        _disCountLb.textColor = LIGHTTEXTCOLOR;
    }
    return _disCountLb;
}

- (UIImageView *)timeIv{
    if (!_timeIv) {
        _timeIv = [[UIImageView alloc] init];
        _timeIv.image = IMAGE(@"dt_remainTime");
    }
    return _timeIv;
}

- (UILabel *)groupStyleLb{
    if (!_groupStyleLb) {
        _groupStyleLb = [[UILabel alloc] init];
        _groupStyleLb.font = FONT(18);
        _groupStyleLb.textColor = [UIColor redColor];
    }
    return _groupStyleLb;
}



@end

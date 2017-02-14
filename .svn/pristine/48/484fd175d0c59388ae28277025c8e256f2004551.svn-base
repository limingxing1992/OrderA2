
//
//  ProductDetailViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/9.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()
/** 图片*/
@property (nonatomic, strong) UIImageView *logoIv;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 收藏*/
@property (nonatomic, strong) UIButton *favoriteBtn;
/** 价格*/
@property (nonatomic, strong) UILabel *priceLb;

/** 加入购物车按钮*/
@property (nonatomic, strong) UIButton *addBtn;
/** 购买按钮*/
@property (nonatomic, strong) UIButton *buyBtn;
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






@property (nonatomic, strong) ProductModel *detailModel;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"详情";
    [self.contentView addSubview:self.logoIv];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.favoriteBtn];
    [self.contentView addSubview:self.priceLb];
    [self.contentView addSubview:self.addBtn];
    [self.contentView addSubview:self.buyBtn];
    [self.contentView addSubview:self.lookCommentBtn];
    [self.contentView addSubview:self.contentInView];
    [self autoLayoutSubViews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark ----------------界面布局

- (void)autoLayoutSubViews{
    _logoIv.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(250 *KHeight_Scale);
    
    _favoriteBtn.sd_layout
    .topSpaceToView(_logoIv, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(55)
    .widthIs(41.5);
    
    _titleLb.sd_layout
    .centerYEqualToView(_favoriteBtn)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(_favoriteBtn, 0)
    .heightIs(21);

    _priceLb.sd_layout
    .topSpaceToView(_titleLb, 20)
    .leftEqualToView(_titleLb)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _addBtn.sd_layout
    .topSpaceToView(_priceLb, 15)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(SCREEN_WIDTH /2 - 15)
    .heightIs(35);
    
    _buyBtn.sd_layout
    .centerYEqualToView(_addBtn)
    .leftSpaceToView(_addBtn, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightRatioToView(_addBtn, 1);
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = GRAYCOLOR;
    [self.contentView addSubview:line];
    line.sd_layout
    .topSpaceToView(_addBtn, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    _lookCommentBtn.sd_layout
    .topSpaceToView(line, 10)
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

#pragma mark ----------------业务

/** 收藏动作*/
- (void)favoriteAction{
    /*********************************************************************
     函数名称 : addFavWithDictionary:
     函数描述 : 添加收藏接口（Fav_Add）
     输入参数 : obj.uid：用户ID ,obj.infotype：收藏类型 news-新闻 image-图片 show-展会 product-商品 company-企业 blog-日志 needs-供求信息 group-团购商品 ,obj.infoid：收藏对象ID
     返回值 : success：1，responseFailure：0 ,-1-提交信息不全
     作者   : 张永亮
     *********************************************************************/
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
        return;
    }
    [ShareBusinessManager.userManager addFavWithDictionary:@{@"obj.uid":UserID,
                                                             @"obj.infotype":@"product",
                                                             @"obj.infoid":_detailModel.proid}
                                                   success:^(id object) {
                                                       [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                       if (errCode == -1) {
                                                           [SVProgressHUD showErrorWithStatus:@"商品已收藏"];
                                                       }else{
                                                           [SVProgressHUD showErrorWithStatus:@"收藏失败"];
                                                       }
                                                   }];
}

/** 加入购物车*/
- (void)addToShopCarAction{
//    /*********************************************************************
//     函数名称 : addCartWithDictionary:
//     函数描述 : 加入购物车接口（Cart_add）
//     输入参数 : obj.uid：用户ID， obj.cid：应用ID， obj.proid：商品ID， obj.num：商品数量， obj.isGroup：是否团购 1-是 0-否
//     返回值 :  success：1，responseFailure：0
//     作者   : 张永亮
//     *********************************************************************/
//    - (void)addCartWithDictionary:(NSDictionary *)parameters
//success:(void (^)(id object))responseSuccess
//failure:(void (^)(NSInteger errCode,NSString *errorMsg))responseFailure;
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil]
        ;
        return;
    }
    [ShareBusinessManager.mallManager addCartWithDictionary:@{@"obj.uid":UserID,
                                                              @"obj.cid":APPCID,
                                                              @"obj.proid":_detailModel.proid,
                                                              @"obj.isGroup":@0,
                                                              @"obj.num":@1}
                                                    success:^(id object) {
                                                        [SVProgressHUD showSuccessWithStatus:@"已加入购物车"];
                                                    } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                        [SVProgressHUD showErrorWithStatus:errorMsg];
                                                    }];

}

/** 购买*/
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
                                                              @"obj.proid":_detailModel.proid,
                                                              @"obj.isGroup":@0,
                                                              @"obj.num":@1}
                                                    success:^(id object) {
                                                        ProductCarViewController *carVc = [[ProductCarViewController alloc] init];
                                                        [weakself.navigationController pushViewController:carVc animated:YES];                                                
                                                    } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                        [SVProgressHUD showErrorWithStatus:errorMsg];
                                                    }];
}

/** 查看评论*/
- (void)lookCommnetAction{
    CommentListViewController *com = [[CommentListViewController alloc] init];
    com.titleText = _detailModel.title;
    com.type = @"product";
    com.ID = _detailModel.proid;
    [self.navigationController pushViewController:com animated:YES];
}

#pragma mark ----------------数据

- (void)loadData{
    [SVProgressHUD show];
    WeakObj(self);
    [ShareBusinessManager.mallManager getProductDetailDictionary:@{@"id":_proId}
                                                         success:^(ProductModel *productModel) {
                                                             [SVProgressHUD dismiss];
                                                             weakself.detailModel = productModel;
                                                             [weakself updateUIInfo];
                                                         } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:errorMsg];
                                                         }];
}

/** 刷新界面*/
- (void)updateUIInfo{
    _contentLb.text = _detailModel.content;
    [_logoIv sd_setImageWithURL:LOGOURL(_detailModel.logo) placeholderImage:Placeholder_big];
    _priceLb.text = [NSString stringWithFormat:@"¥%@", _detailModel.price2];
    if (_detailModel.price2.floatValue == 0) {
        _priceLb.text = @"暂无报价";
    }
    _titleLb.text = _detailModel.title;
}


#pragma mark ----------------webView代理

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}


#pragma mark ----------------实例

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv  =[[UIImageView alloc] init];
        [_logoIv sd_setImageWithURL:LOGOURL(_model.logo) placeholderImage:Placeholder_middle];
    }
    return _logoIv;

}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(21);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = _model.title;
    }
    return _titleLb;

}

- (UIButton *)favoriteBtn{
    if (!_favoriteBtn) {
        _favoriteBtn = [[UIButton alloc] init];
        [_favoriteBtn setImage:IMAGE(@"IMG_0288") forState:UIControlStateNormal];
        [_favoriteBtn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoriteBtn;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(17);
        _priceLb.textColor = OrangeCOLOR;
        _priceLb.text = [NSString stringWithFormat:@"¥%@", _model.price2];
        if (_model.price2.floatValue == 0) {
            _priceLb.text = @"暂无报价";
        }
    }
    return _priceLb;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setBackgroundImage:IMAGE(@"dt_buttonBuyNow") forState:UIControlStateNormal];
        [_addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = FONT(20);
        [_addBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addToShopCarAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] init];
        [_buyBtn setBackgroundImage:IMAGE(@"dt_buttonBuyNow") forState:UIControlStateNormal];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = FONT(20);
        [_buyBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
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
        _contentInView.layer.borderColor = GRAYCOLOR.CGColor;
        _contentInView.layer.borderWidth = 0.5;
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


@end

//
//  CreateAddressViewController.m
//  LevelModel1
//
//  Created by 李明星 on 2017/1/11.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "AddressPickerView.h"

#define PickerHeight 350 *KHeight_Scale

@interface CreateAddressViewController ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate , UITextFieldDelegate, AddressPickerViewDelegate>

/** 添加新地址按钮*/
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) BMKLocationService *locService;//定位工具类
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;//搜索类
@property (nonatomic ,strong) AddressPickerView * pickerView;//城市选择器

/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;

/** 收货人*/
@property (nonatomic, strong) UILabel *nameLb;

/** 收货输入*/
@property (nonatomic, strong) UITextField *nameTf;

/** 地址*/
@property (nonatomic, strong) UILabel *addressLb;

/** 省*/
@property (nonatomic, strong) UIButton *provinceBtn;

/** */
@property (nonatomic, strong) UILabel *provinceLb;

/** 市*/
@property (nonatomic, strong) UIButton *cityBtn;

/** */
@property (nonatomic, strong) UILabel *cityLb;

/** 区*/
@property (nonatomic, strong) UIButton *disBtn;

/** */
@property (nonatomic, strong) UILabel *disLb;

/** 详细地址*/
@property (nonatomic, strong) UILabel *detailAddressLb;

/** 输入*/
@property (nonatomic, strong) UITextField *detailAddressTf;

/** 邮政*/
@property (nonatomic, strong) UILabel *postCodeLb;

/** 邮政输入*/
@property (nonatomic, strong) UITextField *postCodeTf;

/** 手机号*/
@property (nonatomic, strong) UILabel *phoneLb;

/** 手机号输入*/
@property (nonatomic, strong) UITextField *phoneTf;

/** 创建按钮*/
@property (nonatomic, strong) UIButton *createBtn;

/** 选择器是否已经弹出*/
@property (nonatomic, assign) BOOL isShow;


@end

@implementation CreateAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"添加新地址";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item;

    [self.contentView sd_addSubviews:@[self.titleLb, self.nameLb, self.nameTf,
                                       self.addressLb, self.provinceBtn, self.provinceLb,
                                       self.cityBtn, self.cityLb,
                                       self.disBtn, self.disLb,
                                       self.detailAddressLb, self.detailAddressTf,
                                       self.postCodeLb, self.postCodeTf,
                                       self.phoneLb, self.phoneTf,
                                       self.createBtn]];
    [self.view addSubview:self.pickerView];
    
    [self autoLayoutSubViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    _searcher.delegate = nil;
    _locService.delegate = nil;
}

#pragma mark ----------------界面

- (void)autoLayoutSubViews{
    _titleLb.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _nameTf.sd_layout
    .topSpaceToView(_titleLb, 22)
    .leftSpaceToView(self.contentView, 110)
    .heightIs(30)
    .widthIs(190);
    
    _nameLb.sd_layout
    .rightSpaceToView(_nameTf, 5)
    .centerYEqualToView(_nameTf)
    .autoHeightRatio(0);
    [_nameLb setSingleLineAutoResizeWithMaxWidth:300];
    
    UIImageView *imgName = [[UIImageView alloc] initWithImage:IMAGE(@"start")];
    [self.contentView addSubview:imgName];
    imgName.sd_layout
    .centerYEqualToView(_nameTf)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(10)
    .widthEqualToHeight();
    
    
    _addressLb.sd_layout
    .rightEqualToView(_nameLb)
    .topSpaceToView(_nameLb, 25)
    .autoHeightRatio(0);
    [_addressLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _provinceBtn.sd_layout
    .topEqualToView(_addressLb)
    .leftEqualToView(_nameTf)
    .heightIs(28)
    .widthIs(110);
    [_provinceBtn setSd_cornerRadius:@3];
    
    _provinceLb.sd_layout
    .centerYEqualToView(_provinceBtn)
    .leftSpaceToView(_provinceBtn, 10)
    .autoHeightRatio(0);
    [_provinceLb setSingleLineAutoResizeWithMaxWidth:100];
    
    _cityBtn.sd_layout
    .topSpaceToView(_provinceBtn, 10)
    .leftEqualToView(_provinceBtn)
    .rightEqualToView(_provinceBtn)
    .heightRatioToView(_provinceBtn, 1);
    [_cityBtn setSd_cornerRadius:@3];
    
    _cityLb.sd_layout
    .centerYEqualToView(_cityBtn)
    .rightEqualToView(_provinceLb)
    .leftEqualToView(_provinceLb)
    .autoHeightRatio(0);
    
    _disBtn.sd_layout
    .topSpaceToView(_cityBtn, 10)
    .leftEqualToView(_cityBtn)
    .rightEqualToView(_cityBtn)
    .heightRatioToView(_cityBtn, 1);
    [_disBtn setSd_cornerRadius:@3];
    
    _disLb.sd_layout
    .centerYEqualToView(_disBtn)
    .rightEqualToView(_cityLb)
    .leftEqualToView(_cityLb)
    .autoHeightRatio(0);

    _detailAddressTf.sd_layout
    .topSpaceToView(_disBtn, 15)
    .leftEqualToView(_disBtn)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(35);
    
    _detailAddressLb.sd_layout
    .centerYEqualToView(_detailAddressTf)
    .rightEqualToView(_addressLb)
    .autoHeightRatio(0);
    [_detailAddressLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _postCodeTf.sd_layout
    .topSpaceToView(_detailAddressTf, 15)
    .leftEqualToView(_detailAddressTf)
    .rightEqualToView(_nameTf)
    .heightRatioToView(_nameTf, 1);
    
    UIImageView *imgAddress = [[UIImageView alloc] initWithImage:IMAGE(@"start")];
    [self.contentView addSubview:imgAddress];
    imgAddress.sd_layout
    .centerYEqualToView(_detailAddressTf)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(10)
    .widthEqualToHeight();

    
    _postCodeLb.sd_layout
    .centerYEqualToView(_postCodeTf)
    .rightEqualToView(_addressLb)
    .autoHeightRatio(0);
    [_postCodeLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _phoneTf.sd_layout
    .topSpaceToView(_postCodeTf, 15)
    .leftEqualToView(_postCodeTf)
    .rightEqualToView(_postCodeTf)
    .heightRatioToView(_postCodeTf, 1);
    
    _phoneLb.sd_layout
    .centerYEqualToView(_phoneTf)
    .rightEqualToView(_postCodeLb)
    .autoHeightRatio(0);
    [_phoneLb setSingleLineAutoResizeWithMaxWidth:300];
    UIImageView *imPhone = [[UIImageView alloc] initWithImage:IMAGE(@"start")];
    [self.contentView addSubview:imPhone];
    imPhone.sd_layout
    .centerYEqualToView(_phoneTf)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(10)
    .widthEqualToHeight();

    
    _createBtn.sd_layout
    .topSpaceToView(_phoneTf, 25)
    .centerXEqualToView(self.contentView)
    .heightIs(40)
    .widthIs(95);
    
    
    [self.contentView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 80)];


}


#pragma mark ----------------locationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{

    [self.locService stopUserLocationService];//停止定位
    self.locService.delegate = nil;
    //定位成功
    //反向地理编码
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reversGeo = [[BMKReverseGeoCodeOption alloc] init];
    reversGeo.reverseGeoPoint = userLocation.location.coordinate;
    self.searcher.delegate = self;
    [self.searcher reverseGeoCode:reversGeo];
//    BOOL flag = [self.searcher reverseGeoCode:reversGeo];

}

- (void)didFailToLocateUserWithError:(NSError *)error{
    //定位失败进行数据获取。（根据上次定位位置）
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"定位失败：%@",error.description]];
}

//接收反向地理编码结果
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    self.searcher.delegate = self;
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKAddressComponent *detail = result.addressDetail;
        /** 
         /// 街道号码
         @property (nonatomic, strong) NSString* streetNumber;
         /// 街道名称
         @property (nonatomic, strong) NSString* streetName;
         /// 区县名称
         @property (nonatomic, strong) NSString* district;
         /// 城市名称
         @property (nonatomic, strong) NSString* city;
         /// 省份名称
         @property (nonatomic, strong) NSString* province;
         */
        
        [_provinceBtn setTitle:detail.province forState:UIControlStateNormal];
        [_cityBtn setTitle:detail.city forState:UIControlStateNormal];
        [_disBtn setTitle:detail.district forState:UIControlStateNormal];
        [SVProgressHUD dismiss];
    }else {
        [SVProgressHUD showErrorWithStatus:@"定位异常，请重试"];
    }
}


#pragma mark ----------------textField代理

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _phoneTf) {
        if (![textField.text validateMobile]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机"];
        }
    }

}


#pragma mark ----------------业务

/** 开始定位*/
- (void)startLoacation{
    
    [self.locService startUserLocationService];
    self.locService.delegate = self;
    [SVProgressHUD showWithStatus:@"定位中"];

}
/** 选择省份*/
- (void)selectProvinceAction{
    [self pickViewAnimation];
}
/** 选择市区*/
- (void)selectCityAction{
    [self pickViewAnimation];

}
/** 选择区*/
- (void)selectDisAction{
    [self pickViewAnimation];
}
/** 创建地址*/
- (void)createAction{
    
    if (!_nameTf.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入收货人姓名"];
        return;
    }
    
    if (!_detailAddressTf.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确地址"];
        return;
    }


    if (![_phoneTf.text validateMobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    
    /*********************************************************************
     函数名称 : addAddressWithDictionary:
     函数描述 : 添加收货地址接口（Address_Add）
     输入参数 : obj.uid：用户ID ,obj.realname：真实姓名, obj.tel：联系方式, obj.address：地址, obj.postcode：邮编
     返回值 : success：1，responseFailure：0
     作者   : 张永亮
     *********************************************************************/
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"obj.uid":UserID,
                                                                                  @"obj.realname":_nameTf.text,
                                                                                  @"obj.tel":_phoneTf.text,
                                                                                  @"obj.address":_detailAddressTf.text}];
    if (_postCodeTf.text.length) {
        [dict setValue:_postCodeTf.text forKey:@"obj.postcode"];
    }
    [SVProgressHUD showWithStatus:@"添加中"];
    WeakObj(self);
    [ShareBusinessManager.userManager addAddressWithDictionary:dict
                                                       success:^(id object) {
                                                           [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                                                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                               [weakself.navigationController popViewControllerAnimated:YES];
                                                           });
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"创建失败--%ld",errCode]];
                                                       }];
    

}

- (void)pickViewAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        if (_isShow) {
            _pickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,  PickerHeight);
        }
        else {
            _pickerView.frame=CGRectMake(0,SCREEN_HEIGHT - PickerHeight, SCREEN_WIDTH, PickerHeight);
        }
        [UIView commitAnimations];
        
        _isShow = !_isShow;
        
    }];

}

#pragma mark - AddressPickerViewDelegate

- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self pickViewAnimation];
}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    [_provinceBtn setTitle:province forState:UIControlStateNormal];
    [_cityBtn setTitle:city forState:UIControlStateNormal];
    [_disBtn setTitle:area forState:UIControlStateNormal];
    [self pickViewAnimation];
}


#pragma mark ----------------实例

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _rightBtn.titleLabel.font = FONT(15);
        [_rightBtn setTitle:@"定位" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(startLoacation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (BMKGeoCodeSearch *)searcher{
    if (!_searcher) {
        _searcher =[[BMKGeoCodeSearch alloc]init];
    }
    return _searcher;
}

- (BMKLocationService *)locService{
    if (_locService == nil) {
        _locService = [[BMKLocationService alloc] init];
        _locService.distanceFilter = 100;
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locService;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont boldSystemFontOfSize:20];
        _titleLb.textColor = BLACKCOLOR;
        _titleLb.text = @"新增收货地址（带*号为必填项）";
    }
    return _titleLb;

}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(16);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"收货人姓名：";
    }
    return _nameLb;

}

- (UITextField *)nameTf{
    if (!_nameTf) {
        _nameTf = [[UITextField alloc] init];
        _nameTf.font = FONT(16);
        _nameTf.textColor = BLACKTEXTCOLOR;
        _nameTf.placeholder = @"请填写收货人姓名";
        _nameTf.borderStyle = UITextBorderStyleRoundedRect;
        _nameTf.delegate = self;
        [_nameTf setBackgroundColor:RGBColor(253, 245, 234)];

    }
    return _nameTf;

}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font = FONT(16);
        _addressLb.textColor = BLACKTEXTCOLOR;
        _addressLb.text = @"所在地区：";
    }
    return _addressLb;
}

- (UILabel *)provinceLb{
    if (!_provinceLb) {
        _provinceLb = [[UILabel alloc] init];
        _provinceLb.font =FONT(16);
        _provinceLb.text = @"省";
        _provinceLb.textColor = BLACKTEXTCOLOR;
    }
    return _provinceLb;
}

- (UIButton *)provinceBtn{
    if (!_provinceBtn) {
        _provinceBtn = [[UIButton alloc] init];
        _provinceBtn.titleLabel.font = FONT(16);
        [_provinceBtn setTitle:@"请选择地址" forState:UIControlStateNormal];
        [_provinceBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        _provinceBtn.layer.borderColor = GRAYCOLOR.CGColor;
        _provinceBtn.layer.borderWidth = 1;
        [_provinceBtn addTarget:self action:@selector(selectProvinceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _provinceBtn;

}

- (UILabel *)cityLb{
    if (!_cityLb) {
        _cityLb = [[UILabel alloc] init];
        _cityLb.font = FONT(16);
        _cityLb.textColor = BLACKTEXTCOLOR;
        _cityLb.text = @"市";
    }
    return _cityLb;
}

- (UIButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [[UIButton alloc] init];
        _cityBtn.titleLabel.font = FONT(16);
        [_cityBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        _cityBtn.layer.borderColor = GRAYCOLOR.CGColor;
        _cityBtn.layer.borderWidth = 1;
        [_cityBtn addTarget:self action:@selector(selectCityAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityBtn;

}

- (UILabel *)disLb{
    if (!_disLb) {
        _disLb = [[UILabel alloc] init];
        _disLb.font = FONT(16);
        _disLb.textColor = BLACKTEXTCOLOR;
        _disLb.text = @"区";
    }
    return _disLb;
}

- (UIButton *)disBtn{
    if (!_disBtn) {
        _disBtn = [[UIButton alloc] init];
        _disBtn.titleLabel.font = FONT(16);
        [_disBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
        _disBtn.layer.borderColor = GRAYCOLOR.CGColor;
        _disBtn.layer.borderWidth = 1;
        [_disBtn addTarget:self action:@selector(selectDisAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disBtn;
}

- (UILabel *)detailAddressLb{
    if (!_detailAddressLb) {
        _detailAddressLb = [[UILabel alloc] init];
        _detailAddressLb.font = FONT(16);
        _detailAddressLb.textColor = BLACKTEXTCOLOR;
        _detailAddressLb.text = @"详细地址：";
    }
    return _detailAddressLb;
}

- (UITextField *)detailAddressTf{
    if (!_detailAddressTf) {
        _detailAddressTf = [[UITextField alloc] init];
        _detailAddressTf.font = FONT(16);
        _detailAddressTf.textColor = BLACKTEXTCOLOR;
        _detailAddressTf.placeholder = @"请填写详细地址";
        _detailAddressTf.delegate = self;
        _detailAddressTf.borderStyle = UITextBorderStyleRoundedRect;
        [_detailAddressTf setBackgroundColor:RGBColor(253, 245, 234)];

    }
    return _detailAddressTf;

}

- (UILabel *)postCodeLb{
    if (!_postCodeLb) {
        _postCodeLb = [[UILabel alloc] init];
        _postCodeLb.font = FONT(16);
        _postCodeLb.textColor = BLACKTEXTCOLOR;
        _postCodeLb.text = @"邮政编码：";
    }
    return _postCodeLb;
}

- (UITextField *)postCodeTf{
    if (!_postCodeTf) {
        _postCodeTf = [[UITextField alloc] init];
        _postCodeTf.textColor = BLACKTEXTCOLOR;
        _postCodeTf.delegate = self;
        _postCodeTf.font = FONT(16);
        _postCodeTf.placeholder = @"请填写邮政编码";
        _postCodeTf.borderStyle = UITextBorderStyleRoundedRect;
        [_postCodeTf setBackgroundColor:RGBColor(253, 245, 234)];
    }
    return _postCodeTf;

}

- (UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc] init];
        _phoneLb.font = FONT(16);
        _phoneLb.textColor = BLACKTEXTCOLOR;
        _phoneLb.text = @"手机号码：";
    }
    return _phoneLb;
}

- (UITextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.font = FONT(16);
        _phoneTf.placeholder = @"请填写手机号";
        _phoneTf.textColor = BLACKTEXTCOLOR;
        _phoneTf.delegate = self;
        _phoneTf.borderStyle = UITextBorderStyleRoundedRect;
        [_phoneTf setBackgroundColor:RGBColor(253, 245, 234)];
    }
    return _phoneTf;

}

- (UIButton *)createBtn{
    if (!_createBtn) {
        _createBtn = [[UIButton alloc] init];
        _createBtn.titleLabel.font = FONT(15);
        [_createBtn setBackgroundImage:IMAGE(@"bg_PubOn") forState:UIControlStateNormal];
        [_createBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_createBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_createBtn addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createBtn;
}

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, PickerHeight)];
        _pickerView.delegate = self;
    }
    return _pickerView;

}


@end

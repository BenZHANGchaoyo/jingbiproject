//
//  HeBi_SecondCertificate_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_SecondCertificate_ViewController.h"

// view
#import "HeBi_SecondCertificate_View.h"

// tools
#import "AFHTTPSessionManager.h"

@interface HeBi_SecondCertificate_ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HeBi_SecondCertificate_View *frontView;
@property (nonatomic, strong) HeBi_SecondCertificate_View *backView;
@property (nonatomic, strong) HeBi_SecondCertificate_View *handView;

@property (nonatomic, assign) PhotoType selectedPhotoType;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy) NSString *frontURL;     // 正面照
@property (nonatomic, copy) NSString *backURL;      // 背面照
@property (nonatomic, copy) NSString *handURL;      // 手持照

@end

@implementation HeBi_SecondCertificate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"高级认证", nil);
    
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.handView];
    [self.scrollView addSubview:self.frontView];
    [self.scrollView addSubview:self.backView];
    [self.scrollView addSubview:self.submitButton];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.submitButton.bottom + ScaleW(80));
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _scrollView;
}


-(HeBi_SecondCertificate_View *)handView
{
    if (nil == _handView) {
        _handView = [[HeBi_SecondCertificate_View alloc]initWithFrame:CGRectMake(0, self.backView.bottom, ScreenWidth, 0)];
        _handView.photoType = PhotoTypeHand;
        WS(weakSelf);
        _handView.selectPhotoBlock = ^(PhotoType photoType) {
            weakSelf.selectedPhotoType = photoType;
            [weakSelf showActionSheet];

        };
    }
    return _handView;

}


-(HeBi_SecondCertificate_View *)frontView
{
    if (nil == _frontView) {
        _frontView = [[HeBi_SecondCertificate_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _frontView.photoType = PhotoTypeFront;
        WS(weakSelf);
        _frontView.selectPhotoBlock = ^(PhotoType photoType) {
            weakSelf.selectedPhotoType = photoType;
            [weakSelf showActionSheet];
        };

    }
    return _frontView;
    
}

-(HeBi_SecondCertificate_View *)backView
{
    if (nil == _backView) {
        _backView = [[HeBi_SecondCertificate_View alloc]initWithFrame:CGRectMake(0, self.frontView.bottom, ScreenWidth, 0)];
        _backView.photoType = PhotoTypeBack;
        WS(weakSelf);
        _backView.selectPhotoBlock = ^(PhotoType photoType) {
            weakSelf.selectedPhotoType = photoType;
            [weakSelf showActionSheet];

        };

    }
    return _backView;
    
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.handView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(45))];
        _submitButton.backgroundColor = kMainTextColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = ScaleW(5);
        }
    return _submitButton;
}


#pragma mark - 用户操作


- (void)showActionSheet {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:SSKJLocalized(@"打开相机", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:SSKJLocalized(@"打开相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:photo];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)presentPickerConroller:(UIImagePickerController *)imagePickerController sourceType:(UIImagePickerControllerSourceType)sourceType {
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{
        NSLog(@"present成功");
    }];
}


- (void)httptoolIOAEX_set_img{

//    NSDictionary *params = @{@"cardimg1":self.frontURL,
//                             @"cardimg2":self.backURL,
//                             };
//    WS(weakSelf);
//    [HttpTool postWithURL:IOAEX_set_img params:params success:^(id json) {
//        if ([json[@"status"] integerValue] == 200) {
//            [MBProgressHUD showSuccess:ZBLocalized(@"提交成功", nil)];
//            [ManagerSocket sharedManager].model.auth_status = @"2";
////            [weakSelf.navigationController popViewControllerAnimated:YES];
//            [weakSelf backToLastVc];
//        }else{
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//    } failure:^(NSError *error) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//    }];
}


#pragma mark - Camera Delegate


- (void)saveImage:(UIImage *)image {

    [self uploadImage:image];
    
    
//    if (self.selectedPhotoType == PhotoTypeHand) {
//        self.handView.image = image;
//    }else if (self.selectedPhotoType == PhotoTypeFront){
//        self.frontView.image = image;
//    }else{
//        self.backView.image = image;
//    }
}

#pragma mark - photo delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取返回的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - 提交

-(void)submitEvent
{
    [self httptoolIOAEX_set_img];
}



#pragma mark - 上传图片


- (void)uploadImage:(UIImage *)image1 {
//    NSArray *imageAry = @[image1];
//    // 基于AFN3.0+ 封装的HTPPSession句柄
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 10.f;
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:KAccount forHTTPHeaderField:@"account"];
//    [manager.requestSerializer setValue:KToken forHTTPHeaderField:@"token"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//    WS(weakSelf);
//    [manager POST:IOAEX_upload_pic parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (int i = 0; i < imageAry.count; i++) {
//            id file = imageAry[i];
//            NSString * imgname = [NSString stringWithFormat:@"jiangxian_img_%d.jpg",i];
//            if ([file isKindOfClass:[UIImage class]]) {
//                [formData appendPartWithFileData:UIImageJPEGRepresentation(file,0.3) name:@"file_pic" fileName:imgname mimeType:@"image/jpg/png/jpeg"];
//            }
//        }
//    } progress:^(NSProgress * xx){
//        NSLog(@"%lld",xx.completedUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        WL_NetWork_Model *network_Model=[WL_NetWork_Model mj_objectWithKeyValues:responseObject];
//        NSLog(@"%@",network_Model.data);
//        if (network_Model.status.integerValue == 200) {
//            if(weakSelf.selectedPhotoType == PhotoTypeFront){
//                weakSelf.frontURL = network_Model.data[@"url"];
//                weakSelf.frontView.image = image1;
//            }else if(weakSelf.selectedPhotoType == PhotoTypeBack){
//                weakSelf.backURL = network_Model.data[@"url"];
//                weakSelf.backView.image = image1;
//            }
////            else if(weakSelf.selectedPhotoType == PhotoTypeHand){
////                weakSelf.handURL = network_Model.data[@"url"];
////                weakSelf.handView.image = image1;
////            }
//        }else{
//            [MBProgressHUD showError:network_Model.msg];
//        }
//
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//    }];
}


#pragma mark - 选择照片
-(void)backToLastVc
{
    NSArray *controllers = self.navigationController.viewControllers;
    for (SSKJ_BaseViewController *vc in controllers) {
        if ([NSStringFromClass([vc class]) isEqualToString:@"HeBi_Mine_Certificate_ViewController"]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

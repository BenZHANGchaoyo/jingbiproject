//
#import "JB_FBC_Root_ViewController.h"
#import "FBCSalingViewController.h"
#import "FBRecodDetailViewController.h"
#import "FBCHeaderView.h"
#import "FBCBuyListView.h"
#import "FBCSellListView.h"
#import "FBCRecodListView.h"
#import "HeBi_Default_AlertView.h"
#import "JB_Login_ViewController.h"

#define kHeaderHeight    scaleW(50)
@interface JB_FBC_Root_ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *movingView;
@property (nonatomic, strong) UIButton *trasferBtn;
@property (nonatomic, strong) UILabel *trasferDotLabel;
@property (nonatomic, strong) UIButton *systemBtn;
@property (nonatomic, strong) UILabel *systemDotLabel;
@property (nonatomic, strong) UIButton *notafacationBtn;
@property (nonatomic, strong) UILabel *notafacationDotLabel;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) FBCHeaderView *naviView;
@property (nonatomic, strong) FBCBuyListView *buyInView;
@property (nonatomic, strong) FBCRecodListView *recodeView;
@property (nonatomic, strong) FBCSellListView *sellOutView;
@property (nonatomic, strong) HeBi_Default_AlertView *loginAlert;

@property (nonatomic, strong) UIButton *gotoBuyBtn;



@end

@implementation JB_FBC_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationView];
    [self setNavgationBackgroundColor:kMianBgColor alpha:1];
    [self.view addSubview:self.naviView];
    [self viewConfig];
}

-(FBCHeaderView *)naviView
{
    if (!_naviView) {
        _naviView = [[FBCHeaderView alloc]init];
        _naviView.top = Height_NavBar;
        WS(weakSelf);
        _naviView.btnItemIndex = ^(NSInteger index) {
            [weakSelf.mainScrollView setContentOffset:CGPointMake(index*ScreenWidth, 0) animated:YES];
        };
    }
    return _naviView;
}
-(void)setNavigationView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScaleW(100), ScaleW(22))];
    [label label:label font:ScaleW(22) textColor:kTextColorb3b7e9 text:@"场外交易"];
    label.font = [UIFont boldSystemFontOfSize:ScaleW(22)];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:label];
    self.navigationItem.leftBarButtonItem = leftBar;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.buyInView headerRefresh];
    [self.sellOutView headerRefresh];
}

-(void)rigthBtnAction:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:@"" RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            [weakSelf.buyInView headerRefresh];
            [weakSelf.recodeView headerRefresh];
            [weakSelf.sellOutView headerRefresh];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}

#pragma mark - UI

-(void)viewConfig
{
    [self mainScrollView];
    [self movingView];
    [self.view addSubview:self.gotoBuyBtn];
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    
    if (_currentIndex == 2) {
        NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
        
        [settings objectForKey:@"kLogin"];
        
        WS(weakSelf);
        if ([[settings objectForKey:@"kLogin"] integerValue] != 1) {
            [HeBi_Default_AlertView showWithTitle:@"提示" message:@"未登录是否要登录或者注册" cancleTitle:@"取消" confirmTitle:@"登录/注册" confirmBlock:^{
                JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
        }else{
            [self.recodeView headerRefresh];
        }
    }
    
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.naviView.bottom, ScreenWidth,  ScreenHeight - Height_NavBar)];
        _mainScrollView.delegate = self;
        [self.view addSubview:_mainScrollView];
        
        _mainScrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        [_mainScrollView addSubview:self.buyInView];//转账记录
        [_mainScrollView addSubview:self.recodeView];//系统通知
        [_mainScrollView addSubview:self.sellOutView];//公告
        
    }
    return _mainScrollView;
}
-(FBCBuyListView *)buyInView{
    WS(weakSelf);
    if (!_buyInView) {
        _buyInView = [[FBCBuyListView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,  ScreenHeight - Height_NavBar)];
        WS(weakSelf);
        _buyInView.selecetCellBlock = ^(id  _Nonnull objc) {
            FBCSalingViewController *vc = [[FBCSalingViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _buyInView;
}
-(FBCSellListView *)sellOutView{
    WS(weakSelf);
    if (!_sellOutView) {
        _sellOutView = [[FBCSellListView alloc]initWithFrame:CGRectMake(ScreenWidth *1, 0, ScreenWidth,  ScreenHeight - Height_NavBar)];
        _sellOutView.selecetCellBlock = ^(id  _Nonnull objc) {
            //[weakSelf getoDetailVc:objc];
        };
        
    }
    return _sellOutView;
}
-(FBCRecodListView *)recodeView{
    WS(weakSelf);
    if (!_recodeView) {
        WS(weakSelf);
        _recodeView = [[FBCRecodListView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth,  ScreenHeight - Height_NavBar)];
        _recodeView.selecetCellBlock = ^(id  _Nonnull objc) {
            
            FBRecodDetailViewController *vc = [[FBRecodDetailViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            // [weakSelf getoDetailVc:objc];
        };
    }
    return _recodeView;
}
-(void)getoDetailVc:(id)objc
{
//    SignAleadyPayedViewController *vc = [[SignAleadyPayedViewController alloc]init];
//    vc.information = weakSelf.information;
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [weakSelf presentViewController:vc animated:YES completion:^{
//        vc.view.superview.backgroundColor = [UIColor clearColor];
//    }];
//    vc.signAlreadyBackBlock = ^{
//        [weakSelf changeStausAlreadySignedPayed];
//    };
//    
}
-(UIButton *)gotoBuyBtn
{
    if (!_gotoBuyBtn) {
        _gotoBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBuyBtn.frame = CGRectMake(ScreenWidth - ScaleW(16) - ScaleW(50), ScreenHeight - Height_NavBar - Height_TabBar - ScaleW(15) - ScaleW(50), ScaleW(50), ScaleW(50));
        [_gotoBuyBtn btn:_gotoBuyBtn font:0 textColor:kWhiteColorClear text:@"" image:[UIImage imageNamed:@"commitBtnIcon"] sel:@selector(gotoBuyBtnAction:) taget:self];
    }
    return _gotoBuyBtn;
}
-(void)btnClicked:(UIButton *)sender
{
    NSInteger tag = sender.tag - 10000;
    self.currentIndex = tag;
    [self.mainScrollView setContentOffset:CGPointMake(tag*ScreenWidth, 0) animated:YES];
}
-(void)gotoBuyBtnAction:(UIButton *)sender
{
    
}
#pragma mark scrollDelegae


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ScreenWidth;
    self.currentIndex = index;
    self.naviView.currentIndex = index;
}
//ETF_FBHomeFbtransTrading_URL


@end

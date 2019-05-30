//
//  JB_WebView_Controller.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/13.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_WebView_Controller.h"
#import <WebKit/WebKit.h>

@interface JB_WebView_Controller ()
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *htmlString;

@end

@implementation JB_WebView_Controller


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cleanCacheAndCookie];
    
    [self setUI];
    

    self.url = ETF_REGISTERPROTOCOL_URL;
    
    [self requestContent];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}


#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.webView];
}

-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView setOpaque:FALSE];
        _webView.backgroundColor=[UIColor clearColor];
        
        if (@available(iOS 11.0, *))
        {
            
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
            _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
            
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
        
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return _webView;
}



#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
    
    //修改字体颜色  #9098b8
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"completionHandler:nil];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showError:SSKJLocalized(@"加载失败",nil)];
}



#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //网页title
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
}



-(void)requestContent
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:self.url RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            weakSelf.htmlString = network_model.data[@"content"];
            [weakSelf.webView loadHTMLString:_htmlString baseURL:nil];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    }];
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

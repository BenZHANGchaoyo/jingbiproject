//
//  HomepageHeaderView.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HomepageHeaderView.h"
#import "SDCycleScrollView.h"
#import "XBTextLoopView.h"
#import "HomepageCollectionViewCell.h"
@interface HomepageHeaderView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic, strong) UIView *notifacationView;
@property (nonatomic, strong) UIImageView *notifaImg;
@property (nonatomic, strong) XBTextLoopView *rodlodText;
//行情选块
@property (nonatomic, strong) UICollectionView *marketsBlock;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) JB_Market_Index_Model *btcModel;
@property (nonatomic, strong) JB_Market_Index_Model *bchModel;
@property (nonatomic, strong) JB_Market_Index_Model *ethModel;



@end
@implementation HomepageHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(372));
    self.backgroundColor = kMianDeepBgColor;
    [self addSubview:self.mainView];
    [self addSubview:self.headerView];
    [self addSubview:self.notifacationView];
    [self addSubview:self.marketsBlock];
    
}
-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(142), ScreenWidth, ScaleW(221))];
        [_mainView setCornerRadius:ScaleW(10)];
        _mainView.backgroundColor = kMianBgColor;
    }
    return _mainView;
}
#pragma mark - 头部轮播视图
-(SDCycleScrollView *)headerView
{
    if (_headerView==nil)
    {
        UIImage *imageHeight=[UIImage imageNamed:@"bannerDefult"];

        _headerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(15),ScaleW(11), ScreenWidth - ScaleW(30), imageHeight.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"bannerDefult"]];

        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;

        _headerView.delegate = self;

        _headerView.layer.cornerRadius = ScaleW(10);

        _headerView.layer.masksToBounds = YES;

        _headerView.backgroundColor = kMainBackgroundColor;

        _headerView.autoScrollTimeInterval = 3.0;

        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;

        _headerView.currentPageDotColor = kMainWihteColor;

        _headerView.pageDotColor = kWhiteColorClear;

        _headerView.currentPageDotImage = [UIImage imageNamed:@"lanse"];

        _headerView.pageDotImage = [UIImage imageNamed:@"baise"];

        [self addSubview:_headerView];

    }

    return _headerView;
}
-(UIView *)notifacationView
{
    if (!_notifacationView) {
        _notifacationView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(11) + _headerView.bottom,ScreenWidth -ScaleW(30), ScaleW(45))];
        [_notifacationView setCornerRadius:ScaleW(45/2.f)];
        _notifaImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notifacationImg"]];
        //_notifaImg.frame = CGRectMake(ScaleW(15), 0, ScaleW(16), ScaleW(16));
        _notifaImg.centerY = _notifacationView.height/2;
        _notifaImg.left = ScaleW(15);
        _notifacationView.backgroundColor = kTextColor282c4f;
        [_notifacationView addSubview:_notifaImg];
    }
    return _notifacationView;
}
-(void)setNoticeArray:(NSArray *)noticeArray
{
    _noticeArray = noticeArray;
    [_rodlodText removeFromSuperview];
    _rodlodText = [XBTextLoopView textLoopViewWith:_noticeArray loopInterval:5.f initWithFrame:CGRectMake(ScaleW(13) + _notifaImg.right, 0, ScaleW(270), ScaleW(45)) selectBlock:^(NSString *selectString, NSInteger index) {
        
    }];
    [_notifacationView addSubview:_rodlodText];
}
-(UICollectionView *)marketsBlock
{
    if (!_marketsBlock) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _marketsBlock = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _notifacationView.bottom + ScaleW(20), ScreenWidth, ScaleW(95)) collectionViewLayout:layout];
        _marketsBlock.delegate = self;
        _marketsBlock.dataSource = self;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake((ScreenWidth - ScaleW(52))/3.f - 2, _marketsBlock.height - 2);
        layout.sectionInset = UIEdgeInsetsMake(0, ScaleW(25), 0, ScaleW(25));
        _marketsBlock.backgroundColor = kMianBgColor;
        _marketsBlock.pagingEnabled = YES;
        [_marketsBlock registerClass:[HomepageCollectionViewCell class] forCellWithReuseIdentifier:@"HomepageCollectionViewCell"];
        _marketsBlock.showsHorizontalScrollIndicator = NO;
        [self addSubview:_marketsBlock];
    }
    return _marketsBlock;
}
#pragma mark collectionViewdelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomepageCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomepageCollectionViewCell" forIndexPath:indexPath];
    collectionCell.backgroundColor = kMianBgColor;
//    Market_Main_List_Model * model =  _colictionViewArray [indexPath.row];
    JB_Market_Index_Model *model;
    if (indexPath.row == 0) {
        model = self.btcModel;
    }else if (indexPath.row == 1){
        model = self.bchModel;
    }else{
        model = self.ethModel;
    }
    
    [collectionCell setCoinModel:model];;
    return collectionCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JB_Market_Index_Model *model;
    if (indexPath.row == 0) {
        model = self.btcModel;
    }else if (indexPath.row == 1){
        model = self.bchModel;
    }else{
        model = self.ethModel;
    }
    if (self.coinTapBlock) {
        self.coinTapBlock(model);
    }
}

-(void)viewWithdataArray:(NSArray *)array
{
//    _colictionViewArray = [NSMutableArray arrayWithArray:array];
//    if(_colictionViewArray.count%3!=0)
//    {
//        NSInteger count = 3-(_colictionViewArray.count%3);
//
//        for (int i = 0; i < count; i ++) {
//            Market_Main_List_Model * model =  [[Market_Main_List_Model alloc]init];
//            [_colictionViewArray addObject:model];
//        }
//    };
//    NSInteger count = 3-(_colictionViewArray.count%3);
//    _pageControl.numberOfPages = count;
//    _pageControl.currentPage = 0;
//    [_marketsBlock reloadData];
}



- (void)setCoinArray:(NSArray<JB_Market_Index_Model *> *)coinArray
{
    _coinArray = coinArray;
    
    for (JB_Market_Index_Model *model in coinArray) {
        if ([model.code isEqualToString:@"BTC/USDT"]) {
            self.btcModel = model;
        }else if ([model.code isEqualToString:@"BCH/USDT"]){
            self.bchModel = model;
        }else if ([model.code isEqualToString:@"ETH/USDT"]){
            self.ethModel = model;
        }
    }
    
    [self.marketsBlock reloadData];
    
}

-(void)didGetSocketModel:(JB_Market_Index_Model *)socketModel
{
    if ([socketModel.code isEqualToString:@"BTC/USDT"]) {
        self.btcModel = socketModel;
    }else if ([socketModel.code isEqualToString:@"BCH/USDT"]){
        self.bchModel = socketModel;
    }else if ([socketModel.code isEqualToString:@"ETH/USDT"]){
        self.ethModel = socketModel;
    }
    
    [self.marketsBlock reloadData];
}


-(void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    self.headerView.imageURLStringsGroup = bannerArray;
    
}


@end

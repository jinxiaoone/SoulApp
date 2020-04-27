//
//  SLHomeViewController.m
//  SoulApp
//
//  Created by shiyu on 2020/4/16.
//  Copyright © 2020 shiyu. All rights reserved.
//

#import "SLHomeViewController.h"
#import "SLSphereView.h"
#import "SLSperateView.h"

#import "SLHomeModel.h"

@interface SLHomeViewController ()

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) YLImageView *backImageView;

@property (nonatomic, strong) SLSphereView *sphereView;

@property (nonatomic, strong) NSMutableArray *homeViewArray;

@end

@implementation SLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidenNaviBar = YES;
    self.homeViewArray = [NSMutableArray array];
    [self initBackgroundView];
    
    [self initializeRefresh:YES];
}

- (void)initBackgroundView {
    self.backScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.backScrollView];
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.backImageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    self.backImageView.image = [YLGIFImage imageNamed:@"backgound.gif"];
    [self.backScrollView addSubview:self.backImageView];
    
    self.sphereView = [[SLSphereView alloc] initWithFrame:CGRectMake(20, 180, KScreenWidth-40, KScreenHeight-280)];
    [self.backScrollView addSubview:self.sphereView];
    
}


- (void)initializeRefresh:(BOOL)isRemove {
    WEAKSELF
    [SLHomeModel selectFromStart:0 totalCount:50 models:^(NSArray<NSObject *> *models) {
        if (isRemove) {
            [weakSelf.listArray removeAllObjects];
        }
        [weakSelf.listArray addObjectsFromArray:models];
        if (!models.count) {
            weakSelf.listArray = [SLHomeModel createData];
        }
        [weakSelf initsphereViews];
    }];
    
}


#pragma 星球转动
- (void)initsphereViews {
    for (NSInteger i = 0; i < self.listArray.count; i ++) {
        SLSperateView *homeView = [self initializeHomeView:i];
        [self.homeViewArray addObject:homeView];
        [self.sphereView addSubview:homeView];
    }
    [self.sphereView setCloudTags:self.homeViewArray];
}

- (SLSperateView *)initializeHomeView:(NSInteger)row {
    SLSperateView *homeView = [[SLSperateView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    SLHomeModel *model = self.listArray[row];
    [homeView setData:model];
    homeView.tag = row;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    [homeView addGestureRecognizer:tapGes];
    return homeView;
}

- (void)tapGes:(UITapGestureRecognizer*)ges {
    SLSperateView *homeView = (SLSperateView *)ges.view;
    [self showSphereView:homeView];
}

#pragma mark --点击按钮弹出--
- (void)showSphereView:(SLSperateView*)homeView {
    
}

@end

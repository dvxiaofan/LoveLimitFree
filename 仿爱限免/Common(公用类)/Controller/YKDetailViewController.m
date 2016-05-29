//
//  YKDetailViewController.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKDetailViewController.h"
#import "AppDelegate.h"

#define BUTTON_BASE_TAG 100

@interface YKDetailViewController ()<UIActionSheetDelegate>
{
    UIImageView *topView;
    UIButton *button;
    UIImageView *appView;
}

// 整体
//@property (nonatomic, weak) UIView *originalView;
// 图标
//@property (nonatomic, weak) YKIconView *iconView;
// 名字
//@property (nonatomic, weak) UILabel *nameLabel;
// 分享按钮
//@property (nonatomic, weak) UIButton *shareBtn;

@end

@implementation YKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置不让导航栏遮挡控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:@"应用详情"];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"返回"
                                                             backImage:[UIImage imageNamed:@"buttonbar_back"] action:@selector(actionBack:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:nil
                                                              backImage:nil
                                                                 action:nil];
    self.view.userInteractionEnabled = YES;
    
    //[MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    //[MMProgressHUD showWithStatus:@"正在加载"];
    
    [self createTopView];
    
    [self createBottomView];
    
    //[MMProgressHUD dismiss];
    
}

#pragma mark - 设置详情页顶部视图
- (void)createTopView {
    // 背景
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, SCREEN.width - 20, 280)];
    topView.userInteractionEnabled = YES;
    topView.image = [UIImage imageNamed:@"appdetail_background"];
    [self.view addSubview:topView];
    
    // 头像
    YKIconView *iconView = [[YKIconView alloc] init];
    CGFloat iconViewX = YKDetaiBorderW;
    CGFloat iconViewY = YKDetaiBorderH;
    CGFloat iconViewWH = 57;
    iconView.frame = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    iconView.layer.cornerRadius = 8;
    iconView.status = _status;
    [topView addSubview:iconView];
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] init];
    CGFloat nameLabelX = CGRectGetMaxX(iconView.frame) + 8;
    CGFloat nameLabelY = iconViewY - 5;
    nameLabel.text = self.status.name;
    nameLabel.font = YKDetailNameFont;
    nameLabel.textColor = YKDetailNameColor;
    CGSize nameLabelSize = [nameLabel.text sizeWithFont:nameLabel.font];
    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
    [topView addSubview:nameLabel];
    
    //原价。。。
    UILabel *priceLabel = [[UILabel alloc] init];
    if ([self.status.priceTrend isEqualToString:@"limited"]) {
        priceLabel.text = [NSString stringWithFormat:@"原价:￥%.2f 限免中", self.status.lastPrice];
    }
    else if ([self.status.priceTrend isEqualToString:@"sales"]) {
        priceLabel.text = [NSString stringWithFormat:@"原价:￥%.2f 降价中", self.status.lastPrice];
    }
    else if ([self.status.priceTrend isEqualToString:@"free"]) {
        priceLabel.text = [NSString stringWithFormat:@"原价:￥%.2f 免费中", self.status.lastPrice];
    }
    priceLabel.font = YKStatusCellTextFont;
    priceLabel.textColor = YKStatusCellTextColor;
    CGFloat priceLabelX = nameLabelX;
    CGFloat priceLabelY = CGRectGetMaxY(nameLabel.frame) + 3;
    CGSize priceLabelSize = [priceLabel.text sizeWithFont:priceLabel.font];
    priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelSize.width, priceLabelSize.height);
    [topView addSubview:priceLabel];
    
    //类型
    UILabel *cateLabel = [[UILabel alloc] init];
    if ([self.status.categoryName isEqualToString:@"Game"]) {
        cateLabel.text = @"类型:游戏";
    }
    else if ([self.status.categoryName isEqualToString:@"Pastime"]) {
        cateLabel.text = @"类型:娱乐";
    }
    else if ([self.status.categoryName isEqualToString:@"Education"]) {
        cateLabel.text = @"类型:教育";
    }
    else if ([self.status.categoryName isEqualToString:@"Tool"]) {
        cateLabel.text = @"类型:工具";
    }
    else if ([self.status.categoryName isEqualToString:@"Photography"]) {
        cateLabel.text = @"类型:摄影";
    }
    else if ([self.status.categoryName isEqualToString:@"Ability"]) {
        cateLabel.text = @"类型:效率";
    }
    else if ([self.status.categoryName isEqualToString:@"Weather"]) {
        cateLabel.text = @"类型:天气";
    }
    else if ([self.status.categoryName isEqualToString:@"Music"]) {
        cateLabel.text = @"类型:音乐";
    }
    cateLabel.font = YKStatusCellTextFont;
    cateLabel.textColor = YKStatusCellTextColor;
    CGFloat cateLabelX = nameLabelX;
    CGFloat cateLabelY = CGRectGetMaxY(priceLabel.frame) + 3;
    CGSize cateLabelSize = [cateLabel.text sizeWithFont:cateLabel.font];
    cateLabel.frame = CGRectMake(cateLabelX, cateLabelY, cateLabelSize.width, cateLabelSize.height);
    [topView addSubview:cateLabel];
    
    //大小
    UILabel *fSLabel = [[UILabel alloc] init];
    fSLabel.text = [NSString stringWithFormat:@"%.2fMB", self.status.fileSize];
    fSLabel.font = YKStatusCellTextFont;
    fSLabel.textColor = YKStatusCellTextColor;
    CGFloat fSLabelX = CGRectGetMaxX(priceLabel.frame) + 5;
    CGFloat fSLabelY = priceLabelY;
    CGSize fSLabelSize = [fSLabel.text sizeWithFont:fSLabel.font];
    fSLabel.frame = CGRectMake(fSLabelX, fSLabelY, fSLabelSize.width, fSLabelSize.height);
    [topView addSubview:fSLabel];
    
    //评分
    UILabel *scoreLabel = [[UILabel alloc] init];
    scoreLabel.text = [NSString stringWithFormat:@"评分 : %.1f", self.status.starCurrent];
    scoreLabel.font = YKStatusCellTextFont;
    scoreLabel.textColor = YKStatusCellTextColor;
    CGFloat scoreLabelX = CGRectGetMaxX(cateLabel.frame) + 20;
    CGFloat scoreLabeY = cateLabelY;
    CGSize scoreLableSzie = [scoreLabel.text sizeWithFont:scoreLabel.font];
    scoreLabel.frame = CGRectMake(scoreLabelX, scoreLabeY, scoreLableSzie.width, scoreLableSzie.height);
    [topView addSubview:scoreLabel];
    
    //三个按钮
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
    
    //NSArray *titleArray = @[@"分享", @"收藏", @"下载"];
    NSArray *imageArray = @[[UIImage imageNamed:@"Detail_btn_left"], [UIImage imageNamed:@"Detail_btn_middle"], [UIImage imageNamed:@"Detail_btn_right"]];
    for (int i =0; i < imageArray.count; i++) {
        CGFloat btnW = topView.frame.size.width / 3 - 0.5;
        CGFloat btnH = 40;
        CGFloat btnX = i * btnW;
        CGFloat btnY = CGRectGetMaxX(iconView.frame) + 2;
        button = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        if (i == 0) {
            [button setTitle:@"分享" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else if (i == 1) { // 判断是否有收藏记录
            NSString *sql = @"select * from fav where appName = ?";
            FMResultSet *set = [db executeQuery:sql, _status.name];
            if ([set next]) { // 如果有
                [button setTitle:@"已收藏" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.enabled = NO;
            } else {          // 如果没有
                [button setTitle:@"收藏" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        } else {
            // 判断是否有下载记录
            NSString *sql = @"select * from down where appName = ?";
            FMResultSet *set = [db executeQuery:sql, _status.name];
            if ([set next]) { // 如果有
                [button setTitle:@"已下载" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.enabled = NO;
            } else {          // 如果没有
                [button setTitle:@"下载" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        [button setBackgroundImage:imageArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = BUTTON_BASE_TAG + i;
        [topView addSubview:button];
        
        
    }
    
    // 滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat svX = iconViewX;
    CGFloat svY = CGRectGetMaxY(button.frame);
    CGFloat svW = topView.frame.size.width - 20;
    CGFloat svH = 90;
    scrollView.frame = CGRectMake(svX, svY, svW, svH);
    scrollView.contentSize = CGSizeMake(SCREEN.width * 3, 0);
    [topView addSubview:scrollView];
    
    
    // 描述信息
    UILabel *desLabel = [[UILabel alloc] init];
    CGFloat desLabelX = iconViewX;
    CGFloat desLabelY = CGRectGetMaxY(iconView.frame) + 80;
    CGFloat desLabelW = SCREEN.width - desLabelX * 2;
    CGFloat desLabelH = topView.frame.size.height - desLabelY;
    desLabel.frame = CGRectMake(desLabelX, desLabelY, desLabelW, desLabelH);
    desLabel.numberOfLines = 4;
    desLabel.text = self.status.appDescription;
    desLabel.font = [UIFont systemFontOfSize:10];
    desLabel.textColor = [UIColor grayColor];
    [topView addSubview:desLabel];
    
    //YKLog(@"text = %@", self.status.appDescription);
}
#pragma mark - 三个按钮点击事件
- (void)btnClick:(UIButton *)btn {
    NSInteger tag = btn.tag;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
    
    switch (tag) {
        case BUTTON_BASE_TAG:
        {
            //YKLog(@"分享");
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博", @"微信好友", @"微信朋友圈", @"短信", @"邮件", nil];
            [actionSheet showInView:self.view];
        }
            break;
        case BUTTON_BASE_TAG + 1:
        {
            //YKLog(@"收藏");
            [btn setTitle:@"已收藏" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.enabled = NO;
            
            // 数据保存到数据库
            NSString *sql = @"insert into fav (appName,iconUrl) values(?,?)";
            BOOL bl = [db executeUpdate:sql, _status.name, _status.iconUrl];
            if (!bl) {
                 YKLog(@"收藏信息保存失败");
            }
        }
            break;
        case BUTTON_BASE_TAG + 2:
        {
            //YKLog(@"下载");
            [[UIApplication sharedApplication]
             openURL:[NSURL URLWithString:self.status.itunesUrl]];
            
            [btn setTitle:@"已下载" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.enabled = NO;
            
            // 数据保存到数据库
            NSString *sql = @"insert into down (appName,iconUrl) values(?,?)";
            BOOL bl = [db executeUpdate:sql, _status.name, _status.iconUrl];
            if (!bl) {
                YKLog(@"下载信息保存失败");
            }
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - 创建底部附近信息视图
- (void)createBottomView {
    // 整体背景
    UIImageView *bottomView = [[UIImageView alloc] init];
    CGFloat bottomViewX = topView.frame.origin.x;
    CGFloat bottomViewY = CGRectGetMaxY(topView.frame);
    CGFloat bottomViewW = SCREEN.width - bottomViewX * 2;
    CGFloat bottomViewH = SCREEN.height - topView.frame.size.height - 118;
    bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    bottomView.image = [UIImage imageNamed:@"appdetail_recommend"];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    
    //YKLog(@"h = %f", bottomViewH);
    
    // 滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat svX = bottomViewX;
    CGFloat svY = 0;
    CGFloat svW = bottomViewW - 20;
    CGFloat svH = 80;
    scrollView.frame = CGRectMake(svX, svY, svW, svH);
    [bottomView addSubview:scrollView];
    
    NSArray *imgArray = @[[UIImage imageNamed:@"category_Ability"], [UIImage imageNamed:@"category_Gps"], [UIImage imageNamed:@"category_Book"], [UIImage imageNamed:@"category_Life"], [UIImage imageNamed:@"category_News"], [UIImage imageNamed:@"category_Refer"],];
    for (int i = 0; i <imgArray.count; i++) {
        appView = [[UIImageView alloc] init];
        CGFloat imgViewWH = 57;
        CGFloat imgViewX = i * imgViewWH + 10 * i;
        CGFloat imgViewY = 18;
        appView.frame = CGRectMake(imgViewX, imgViewY, imgViewWH, imgViewWH);
        appView.layer.cornerRadius = 9;
        appView.image = imgArray[i];
        [scrollView addSubview:appView];
    }
    scrollView.contentSize = CGSizeMake(appView.width * imgArray.count, 0);
    
}

#pragma mark - 构建导航栏按钮
- (UIBarButtonItem *)creatNavBtnWithTitle:(NSString *)title backImage:(UIImage *)image action:(SEL)action {
    
    UIButton *btn = [YKUtility createBtnWithTitle:title backgroundImag:image];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = btn;
    
    return itme;
}
#pragma mark - 返回按钮点击事件
- (void)actionBack:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

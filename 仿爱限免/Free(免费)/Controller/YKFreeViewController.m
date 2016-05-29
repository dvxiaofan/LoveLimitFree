//
//  YKFreeViewController.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKFreeViewController.h"
#import "YKFreeViewCell.h"
#import "YKFreeStatusFrame.h"

@interface YKFreeViewController ()<UISearchBarDelegate>

@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *freeStatusFrames;

@end

@implementation YKFreeViewController

- (NSMutableArray *)freeStatusFrames {
    if (!_freeStatusFrames) {
        _freeStatusFrames = [NSMutableArray array];
    }
    return _freeStatusFrames;
}

- (instancetype)init {
    if (self = [super init]) {
        _page = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _navTitle = @"免 费";
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:_navTitle];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"分类"
                                                             backImage:[UIImage imageNamed:@"buttonbar_action"] action:@selector(actionLeft:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:@"设置"
                                                             backImage:[UIImage imageNamed:@"buttonbar_action"] action:@selector(actionRihgt:)];
    
    [self createSearchBar];
    
    // 加载数据
    [self loadMoreData];
    
    // 上部往下拉刷新数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    
    // 底部网上拉加载数据
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

#pragma mark - 上部往下拉刷新数据
- (void)updateData {
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - 加载更多数据
- (void)loadMoreData {
    
    // 显示一个HUD加载进度
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithStatus:@"正在加载"];
    
    _page ++;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:FREE_URL, _page];
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        // 字典转化为模型数组
        NSArray *newStatuses = [YKStatuses mj_objectArrayWithKeyValuesArray:responseObject[@"applications"]];
        // 将status数组转化为statusframe数组
        NSArray *newFrames = [self statusFramesWithStautses:newStatuses];
        // 将数据加载原有数据后面
        [self.freeStatusFrames addObjectsFromArray:newFrames];
        // 刷新表格
        [self.tableView reloadData];
        // 停止刷新数据
        [self.tableView.mj_footer endRefreshing];
        [MMProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YKLog(@"error");
    }];
    
    
}

#pragma mark - 将status数组转化为statusframe数组
- (NSArray *)statusFramesWithStautses:(NSArray *)statuses {
    NSMutableArray *frames = [NSMutableArray array];
    for (YKStatuses *status in statuses) {
        YKFreeStatusFrame *frame = [[YKFreeStatusFrame alloc] init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - 创建搜索框
- (void)createSearchBar {
    UISearchBar *search = [[UISearchBar alloc] init];
    search.frame = CGRectMake(0, 0, 0, 40);
    search.placeholder = @"60万应用搜搜看";
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    search.showsCancelButton = NO;
    search.delegate = self;
    
    self.tableView.tableHeaderView = search;
}

#pragma mark - 搜索框代理事件
// 开始编辑搜索框
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    YKLog(@"开始编辑搜索框");
    
    searchBar.showsCancelButton = YES;
    
    NSArray *subViews = [(searchBar.subviews[0]) subviews];
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}
// 点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    YKLog(@"点击搜索");
}
// 点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    YKLog(@"点击取消按钮");
    
    searchBar.showsCancelButton = NO;
    
    [searchBar resignFirstResponder];
}


#pragma mark - 构建导航栏按钮
- (UIBarButtonItem *)creatNavBtnWithTitle:(NSString *)title backImage:(UIImage *)image action:(SEL)action {
    
    UIButton *button = [YKUtility createBtnWithTitle:title backgroundImag:image];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = button;
    
    return itme;
}

#pragma mark - 导航栏按钮点击事件
// 分类按钮
- (void)actionLeft:(UIButton *)button {
    //YKLog(@"分类");
    
    YKFenleiViewController *fenleiVC = [[YKFenleiViewController alloc] init];
    fenleiVC.Title = _navTitle;
    [self.navigationController pushViewController:fenleiVC animated:YES];
    
}
// 设置按钮
- (void)actionRihgt:(UIButton *)button {
    //YKLog(@"设置");
    
    YKSetViewController *setVC = [[YKSetViewController alloc] init];
    
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.freeStatusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKFreeViewCell *cell = [YKFreeViewCell cellWithTableView:tableView];
    
    cell.freeStatusFrame = self.freeStatusFrames[indexPath.row];
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cate_list_bg1"]];
    }
    else {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cate_list_bg2"]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKFreeStatusFrame *frame = self.freeStatusFrames[indexPath.row];
    
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YKDetailViewController *detailVC = [[YKDetailViewController alloc] init];
    
    YKFreeStatusFrame *frame = self.freeStatusFrames[indexPath.row];
    
    detailVC.status = frame.status;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

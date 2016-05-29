//
//  YKMySetViewController.m
//  仿爱限免
//
//  Created by 小烦 on 16/5/19.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKMySetViewController.h"

@interface YKMySetViewController ()

{
    NSMutableArray *_dataArray; // 保存数据的动态数组
    UITableView *_tableView;    // 自定义tableview
}

@end

@implementation YKMySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:@"我的设置"];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"返回"
                                                             backImage:[UIImage imageNamed:@"buttonbar_back"] action:@selector(actionBack:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:nil
                                                              backImage:nil
                                                                 action:nil];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    NSArray *topTextArray = @[@"推送通知", @"开启推送通知", @"开启关注通知"];
    [_dataArray addObject:topTextArray];
    
    NSArray  *bottomTextArray = @[@"推荐爱限免", @"官方推荐", @"官方微博", @"版本 V1.81", @"感谢使用爱限免应用"];
    [_dataArray addObject:bottomTextArray];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
}
#pragma mark - 构建导航栏按钮
- (UIBarButtonItem *)creatNavBtnWithTitle:(NSString *)title backImage:(UIImage *)image action:(SEL)action {
    
    UIButton *button = [YKUtility createBtnWithTitle:title backgroundImag:image];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = button;
    
    return itme;
}
// 返回按钮点击事件
- (void)actionBack:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //从数组中获得数据
    NSString *textStr = _dataArray[indexPath.section] [indexPath.row];
    cell.textLabel.text = textStr;
    //第一区的第二行和第三行加上开关
    if (indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2)) {
        UISwitch *swh = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN.width - 80, 2, 60, 30)];
        swh.on = NO;
        [cell addSubview:swh];
    }
    // 第二区的最后两行字体加粗
    if (indexPath.section == 1 && (indexPath.row == 3 || indexPath.row == 4)) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    
    return cell;
}
//取消点击cell的选中颜色
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {           // 推荐爱限免
            YKLog(@"推荐爱限免");
        } else if (indexPath.row == 1) {    // 官方推荐
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL]];
        } else if (indexPath.row == 2) {    // 官方微博
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WEIBO_URL]];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
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

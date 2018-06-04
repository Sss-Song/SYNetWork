//
//  ViewController.m
//  SYNetwork
//
//  Created by 宋成博 on 17/7/27.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import "ViewController.h"
#import "PPNetworkHelper.h"
#import "SYHTTPRequestTool.h"
#import "MJRefresh.h"


//我是主分支上的代码


//我在新分支上改了 哈哈哈哈

//继续更新1.0.1


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>





@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,copy)NSString *URL;


@end

@implementation ViewController

-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.URL = @"http://s.fotoyou.cn/api/book/";
    
    self.tableView =[[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    [self.tableView.mj_header beginRefreshing];

}

-(void)loadNewUser{
  
   [SYHTTPRequestTool POST:self.URL parameters:nil successCache:^(id responseObject) {
       //第一次的时候  在这里是获取不到缓存数据的 ,只有第一次请求数据成功了 才会将数据存放起来
       // 当没有网络的时候,加载缓存数据(保证无网络的时候有数据)
       if (![SYHTTPRequestTool isNetwork]) {
           
           NSLog(@"%@",responseObject);
           [self.dataArray removeAllObjects];
           NSDictionary *secondDic = responseObject[@"msg"];
           NSArray *arr = [NSArray arrayWithArray:secondDic[@"data"]];
           for (NSDictionary *dic in arr) {
               [self.dataArray addObject:dic];
           }
           [self.tableView.mj_header endRefreshing];
           [self.tableView reloadData];
       }
       
   } success:^(id responseObject) {
       
       [self.dataArray removeAllObjects];
       NSDictionary *secondDic = responseObject[@"msg"];
       NSArray *arr = [NSArray arrayWithArray:secondDic[@"data"]];
       for (NSDictionary *dic in arr) {
           [self.dataArray addObject:dic];
       }
       [self.tableView.mj_header endRefreshing];
       [self.tableView reloadData];
       
   } failure:^(NSError *error) {
       
   }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    cell.backgroundColor = [UIColor cyanColor];
    NSDictionary *dic = _dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    return cell;
}

@end

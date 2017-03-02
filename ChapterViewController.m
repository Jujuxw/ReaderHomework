//
//  ChapterViewController.m
//  Reader
//
//  Created by juju on 2017/2/28.
//  Copyright © 2017年 juju. All rights reserved.
//

#import "ChapterViewController.h"

#import <sqlite3.h>

#import "DBAccess.h"

#import "BaseViewController.h"

@interface ChapterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DBAccess *db;
@end

@implementation ChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.db = [[DBAccess alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    [self.db initializeDatabase];
    
    self.titleArray = [self.db getTitle];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview: self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseViewController *bvc = [[BaseViewController alloc] init];
    
    bvc.passageTitle = [NSString stringWithFormat: @"lesson %ld",indexPath.row + 1];
    
    bvc.lesson = indexPath.row + 1;
    
    [self.navigationController pushViewController:bvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"cellID";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
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

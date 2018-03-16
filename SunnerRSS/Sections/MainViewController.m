//
//  MainViewController.m
//  SunnerRSS
//
//  Created by sunner on 2018/3/15.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "MainViewController.h"
#import "RssSourceModel.h"
#import "AddRssSourceViewController.h"
#import "EntryViewController.h"

@interface MainViewController () <NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *rssSourceList;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSS sources list";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addRssSource)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.rssSourceList = [NSMutableArray array];
}

- (void)addRssSource
{
    AddRssSourceViewController *arsVc = [[AddRssSourceViewController alloc] initWithNibName:NSStringFromClass([AddRssSourceViewController class]) bundle:nil];
    [arsVc addRssSourceCompletionHandler:^(RssSourceModel *rsModel) {
        [self.rssSourceList addObject:rsModel];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:arsVc animated:YES];
}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rssSourceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    RssSourceModel *rsModel = self.rssSourceList[indexPath.row];
    cell.textLabel.text = rsModel.name;
    cell.detailTextLabel.text = rsModel.desc;
    return cell;
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RssSourceModel *rsModel = self.rssSourceList[indexPath.row];
    EntryViewController *entryVc = [[EntryViewController alloc] initWithNibName:NSStringFromClass([EntryViewController class]) bundle:nil];
    entryVc.rssPath = rsModel.link;
    [self.navigationController pushViewController:entryVc animated:YES];
}


@end

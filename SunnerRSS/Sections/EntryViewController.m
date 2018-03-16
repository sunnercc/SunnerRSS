//
//  EntryViewController.m
//  SunnerRSS
//
//  Created by sunner on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "EntryViewController.h"
#import "SCRSSParser.h"
#import "DetailViewController.h"


@interface EntryViewController ()

@property (nonatomic, strong) SCFeedModel *feedModel;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"list";
    
    [self startRequest];
}


- (void)startRequest
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:self.rssPath];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [[session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [[SCParser parser] parserRSS:data completionHandler:^(SCFeedModel *scFeedModel, NSError *error) {
            
            if (error) {
                NSLog(@"%@", error);
            } else {
                NSLog(@"%@", scFeedModel);
                
                self.feedModel = scFeedModel;
                [self.tableView reloadData];
            }
        }];
        
    }] resume];
}



#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feedModel.entrys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    SCEntryModel *entryModel = self.feedModel.entrys[indexPath.row];
    cell.textLabel.text = entryModel.title;
    cell.detailTextLabel.text = entryModel.published;
    return cell;
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCEntryModel *entryModel = self.feedModel.entrys[indexPath.row];
    DetailViewController *detailVc = [[DetailViewController alloc] initWithNibName:NSStringFromClass([DetailViewController class]) bundle:nil];
    detailVc.urlPath = entryModel.link;
    detailVc.navTilte = entryModel.title;
    [self.navigationController pushViewController:detailVc animated:YES];
}


@end

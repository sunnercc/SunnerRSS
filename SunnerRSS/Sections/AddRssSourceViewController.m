//
//  AddRssSourceViewController.m
//  SunnerRSS
//
//  Created by sunner on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "AddRssSourceViewController.h"
#import "RssSourceModel.h"

@interface AddRssSourceViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *descTF;
@property (weak, nonatomic) IBOutlet UITextField *linkTF;

@property (nonatomic, copy) void (^completionHandler)(RssSourceModel *);

@end

@implementation AddRssSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)addRssSourceCompletionHandler:(void (^)(RssSourceModel *rsModel))completionHandler
{
    self.completionHandler = completionHandler;
}

- (IBAction)sureAction:(UIButton *)sender {
    RssSourceModel *rsModel = [[RssSourceModel alloc] init];
    rsModel.name = self.nameTF.text;
    rsModel.desc = self.descTF.text;
    rsModel.link = self.linkTF.text;
    if (self.completionHandler) {
        self.completionHandler(rsModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end

//
//  AddRssSourceViewController.h
//  SunnerRSS
//
//  Created by sunner on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RssSourceModel;

@interface AddRssSourceViewController : UIViewController

- (void)addRssSourceCompletionHandler:(void (^)(RssSourceModel *rsModel))completionHandler;

@end

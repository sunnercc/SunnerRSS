//
//  ViewController.m
//  SunnerRSS
//
//  Created by sunner on 2018/3/15.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "ViewController.h"
#import "SCRSSParser.h"

@interface ViewController () <NSXMLParserDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSString *urlPath = @"http://blog.devtang.com/atom.xml";
//    NSString *urlPath = @"http://beyondvincent.com/atom.xml";
    NSURL *url = [NSURL URLWithString:urlPath];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [[session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [[SCParser parser] parserRSS:data completionHandler:^(SCFeedModel *scFeedModel, NSError *error) {
           
            if (error) {
                NSLog(@"%@", error);
            } else {
                NSLog(@"%@", scFeedModel);
            }
        }];
        
    }] resume];
}
@end

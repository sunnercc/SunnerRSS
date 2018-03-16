//
//  RssSourceModel.m
//  SunnerRSS
//
//  Created by sunner on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "RssSourceModel.h"

@interface RssSourceModel()

@end

@implementation RssSourceModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = [[dict valueForKey:@"name"] copy];
        self.desc = [[dict valueForKey:@"desc"] copy];
        self.link = [[dict valueForKey:@"link"] copy];
    }
    return self;
}

- (NSDictionary *)dict
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setValue:self.name forKey:@"name"];
    [mDict setValue:self.desc forKey:@"desc"];
    [mDict setValue:self.link forKey:@"link"];
    return [mDict copy];
}

@end

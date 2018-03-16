//
//  RssSourceModel.m
//  SunnerRSS
//
//  Created by sunner on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "RssSourceModel.h"

#define FileName ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"RssSource.data"])


@interface RssSourceModel() <NSCoding>

@end

@implementation RssSourceModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.link = [aDecoder decodeObjectForKey:@"link"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.link forKey:@"link"];
}


- (RssSourceModel *)readFromSandBox
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:FileName];
}

- (void)saveToSandBox
{
    [NSKeyedArchiver archiveRootObject:self toFile:FileName];
}

@end

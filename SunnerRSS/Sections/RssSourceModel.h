//
//  RssSourceModel.h
//  SunnerRSS
//
//  Created by sunner on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssSourceModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *link;

- (RssSourceModel *)readFromSandBox;

- (void)saveToSandBox;

@end

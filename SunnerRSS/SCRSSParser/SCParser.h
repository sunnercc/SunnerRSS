//
//  SCParser.h
//  SunnerRSS
//
//  Created by ifuwo on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCFeedModel;

@interface SCParser : NSObject

+ (instancetype)parser;

- (void)parserRSS:(NSData *)data completionHandler:(void (^)(SCFeedModel *scFeedModel, NSError *error))completionHandler;

@end

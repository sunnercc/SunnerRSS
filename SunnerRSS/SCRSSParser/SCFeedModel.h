//
//  SCFeedModel.h
//  SunnerRSS
//
//  Created by ifuwo on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCAuthorModel;
@class SCEntryModel;

@interface SCFeedModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *link;   // id元素

@property (nonatomic, copy) NSString *updated;

@property (nonatomic, strong) SCAuthorModel *author;

@property (nonatomic, strong) NSMutableArray <SCEntryModel *> *entrys;

@end

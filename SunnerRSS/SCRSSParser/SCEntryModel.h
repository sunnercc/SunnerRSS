//
//  SCEntryModel.h
//  SunnerRSS
//
//  Created by ifuwo on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCEntryModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *link;  // id元素

@property (nonatomic, copy) NSString *published;

@property (nonatomic, copy) NSString *updated;

@end

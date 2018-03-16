//
//  SCParser.m
//  SunnerRSS
//
//  Created by ifuwo on 2018/3/16.
//  Copyright © 2018年 sunner. All rights reserved.
//

#import "SCParser.h"

#import "SCRSSParserDefines.h"

#import "SCFeedModel.h"
#import "SCAuthorModel.h"
#import "SCEntryModel.h"

typedef NS_ENUM(NSUInteger, ParentElementType) {
    ParentElementTypeNone = 0,
    ParentElementTypeFeed = 1,
    ParentElementTypeAuthor = 2,
    ParentElementTypeEntry = 3,
};

@interface SCParser() <NSXMLParserDelegate>
{
    // 父标签的类型
    ParentElementType _parentElementType;
    // 记录当前标签
    NSString *_currentElement;
    // 记录当前Feed
    SCFeedModel *_currentFeed;
    // 记录当前Author
    SCAuthorModel *_currentAuthor;
    // 记录当前Entry
    SCEntryModel *_currentEntry;
}

@property (nonatomic, copy) void (^completionHandler)(SCFeedModel *scFeedModel, NSError *error);

@end

@implementation SCParser

+ (instancetype)parser
{
    return [[self alloc] init];
}

- (void)parserRSS:(NSData *)data completionHandler:(void (^)(SCFeedModel *scFeedModel, NSError *error))completionHandler
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    self.completionHandler = completionHandler;
    if (![parser parse])
    {
        self.completionHandler(nil, parser.parserError);
    }
}

#pragma mark - NSXMLParserDelegate

// Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    SCLog(@"%s", __func__);
}
// sent when the parser begins parsing of the document.
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    SCLog(@"%s", __func__);
    
    self.completionHandler(_currentFeed, nil);
}
// sent when the parser has completed parsing. If this is encountered, the parse was successful.

// DTD handling methods for various declarations.
//- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID
//{
//    NSLog(@"%s", __func__);
//}

//- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID notationName:(nullable NSString *)notationName
//{
//    NSLog(@"%s", __func__);
//}

//- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(nullable NSString *)type defaultValue:(nullable NSString *)defaultValue
//{
//    NSLog(@"%s", __func__);
//}

//- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
//{
//    NSLog(@"%s", __func__);
//}
//
//- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(nullable NSString *)value
//{
//    NSLog(@"%s", __func__);
//}
//
//- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID
//{
//    NSLog(@"%s", __func__);
//}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    SCLog(@"%s", __func__);
    
    if ([elementName isEqualToString:@"feed"])
    {
        _parentElementType = ParentElementTypeFeed;
        _currentFeed = [[SCFeedModel alloc] init];
        _currentFeed.entrys = [NSMutableArray array];
    }
    else if ([elementName isEqualToString:@"author"])
    {
        _parentElementType = ParentElementTypeAuthor;
        _currentAuthor = [[SCAuthorModel alloc] init];
        
    }
    else if ([elementName isEqualToString:@"entry"])
    {
        _parentElementType = ParentElementTypeEntry;
        _currentEntry = [[SCEntryModel alloc] init];
    }
    
    _currentElement = elementName;
}
// sent when the parser finds an element start tag.
// In the case of the cvslog tag, the following is what the delegate receives:
//   elementName == cvslog, namespaceURI == http://xml.apple.com/cvslog, qualifiedName == cvslog
// In the case of the radar tag, the following is what's passed in:
//    elementName == radar, namespaceURI == http://xml.apple.com/radar, qualifiedName == radar:radar
// If namespace processing >isn't< on, the xmlns:radar="http://xml.apple.com/radar" is returned as an attribute pair, the elementName is 'radar:radar' and there is no qualifiedName.

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    SCLog(@"%s", __func__);
    
    _currentElement = nil;
    
    if ([elementName isEqualToString:@"feed"])
    {
        
    }
    else if ([elementName isEqualToString:@"author"])
    {
        _currentFeed.author = _currentAuthor;
        
    }
    else if ([elementName isEqualToString:@"entry"])
    {
        [_currentFeed.entrys addObject:_currentEntry];
    }
}
// sent when an end tag is encountered. The various parameters are supplied as above.

//- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI
//{
//    NSLog(@"%s", __func__);
//}
// sent when the parser first sees a namespace attribute.
// In the case of the cvslog tag, before the didStartElement:, you'd get one of these with prefix == @"" and namespaceURI == @"http://xml.apple.com/cvslog" (i.e. the default namespace)
// In the case of the radar:radar tag, before the didStartElement: you'd get one of these with prefix == @"radar" and namespaceURI == @"http://xml.apple.com/radar"

//- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix
//{
//    NSLog(@"%s", __func__);
//}
// sent when the namespace prefix in question goes out of scope.



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    SCLog(@"%s", __func__);
    
    [self foundParserCharacters:string];
}
// This returns the string of the characters encountered thus far. You may not necessarily get the longest character run. The parser reserves the right to hand these to the delegate as potentially many calls in a row to -parser:foundCharacters:

//- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString
//{
//    NSLog(@"%s", __func__);
//}
// The parser reports ignorable whitespace in the same way as characters it's found.

//- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(nullable NSString *)data
//{
//    NSLog(@"%s", __func__);
//}
// The parser reports a processing instruction to you using this method. In the case above, target == @"xml-stylesheet" and data == @"type='text/css' href='cvslog.css'"

//- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment
//{
//    NSLog(@"%s", __func__);
//}
// A comment (Text in a <!-- --> block) is reported to the delegate as a single string

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    SCLog(@"%s", __func__);
    
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    [self foundParserCharacters:string];
}
// this reports a CDATA block to the delegate as an NSData.

//- (nullable NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(nullable NSString *)systemID
//{
//    NSLog(@"%s", __func__);
//}
// this gives the delegate an opportunity to resolve an external entity itself and reply with the resulting data.

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    SCLog(@"%s", __func__);
    
    self.completionHandler(nil, parseError);
}
// ...and this reports a fatal error to the delegate. The parser will stop parsing.

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    SCLog(@"%s", __func__);
    
    self.completionHandler(nil, validationError);
}
// If validation is on, this will report a fatal validation error to the delegate. The parser will stop parsing.

#pragma mark - private

- (void)foundParserCharacters:(NSString *)string
{
    if (_parentElementType == ParentElementTypeFeed)
    {
        if ([_currentElement isEqualToString:@"title"])
        {
            _currentFeed.title = string;
        }
        else if ([_currentElement isEqualToString:@"subtitle"])
        {
            _currentFeed.subTitle = string;
        }
        else if ([_currentElement isEqualToString:@"updated"])
        {
            _currentFeed.updated = string;
        }
        else if ([_currentElement isEqualToString:@"id"])
        {
            _currentFeed.link = string;
        }
    }
    else if (_parentElementType == ParentElementTypeAuthor)
    {
        if ([_currentElement isEqualToString:@"name"])
        {
            _currentAuthor.name = string;
        }
        else if ([_currentElement isEqualToString:@"email"])
        {
            _currentAuthor.email = string;
        }
    }
    else if (_parentElementType == ParentElementTypeEntry)
    {
        if ([_currentElement isEqualToString:@"title"])
        {
            _currentEntry.title = string;
        }
        else if ([_currentElement isEqualToString:@"published"])
        {
            _currentEntry.published = string;
        }
        else if ([_currentElement isEqualToString:@"updated"])
        {
            _currentEntry.updated = string;
        }
        else if ([_currentElement isEqualToString:@"id"])
        {
            _currentEntry.link = string;
        }
    }
}

@end

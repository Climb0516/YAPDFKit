//
//  PDFObject.h
//  YAPDFKit
//
//  Created by Aliona on 19.05.14.
//  Copyright (c) 2014 Ptenster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDFStream.h"

@class PDFDocument;

@interface PDFObject : NSObject

@property NSInteger firstNumber;
@property NSInteger secondNumber;
@property PDFStream *stream;
@property id value;
@property NSMutableDictionary *references;

- (id)initWithData :(NSData*)d first:(NSInteger*)first second:(NSInteger*)second;
- (NSString *)getObjectNumber;
- (id)getValueByName:(NSString *)n;
- (NSArray*)getContents;
- (PDFStream *)getStreamObject;


@end

//
//  main.m
//  YAPDFKit
//
//  Created by Aliona on 10.05.14.
//  Copyright (c) 2014 Ptenster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>

#import "PDFDocument.h"
#import "PDFObject.h"
#import "PDFStreamDecoder.h"
#import "PDFPages.h"

enum ParserStates {
    BEGIN_STATE = 0,
    FILL_VERSION_STATE,
    DEFAULT_STATE,
};


int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSString *file = @"/Users/pim/RnD/Studies/PDF-transparant/pdfs/pages-export-naar-pdf.pdf";
        NSString *file2 = @"/Users/pim/RnD/Studies/PDF-transparant/pdfs/pages-multi-export-naar-pdf.pdf";

        //Open the PDF source file:
        FILE* filei = fopen([file2 UTF8String], "rb");

        //Get the file length:
        int fseekres = fseek(filei,0, SEEK_END);   //fseek==0 if ok
        long filelen = ftell(filei);
        fseekres = fseek(filei,0, SEEK_SET);

        //Read the entire file into memory (!):
        char *buffer = malloc(filelen*sizeof(char)); //Allocates the buffer
        ZeroMemory(buffer, filelen);

        if (!fread(buffer, filelen, 1 ,filei)) {
            return 0;
        }

        NSData* fileData = [NSData dataWithBytes:(const void *)buffer length:filelen];

        PDFDocument *document = [[PDFDocument alloc] initWithData:fileData];
        
        //[document getInfoForKey:@"Type"];
        
        //SOME FEATURES
        //NSLog(@"dict: %@", [document allObjects]);
        
        NSDictionary *pdfObjs = [document allObjects];
        for(id key in pdfObjs) {
            id pdfObject = [pdfObjs objectForKey:key];
            NSLog(@"Objectnumber: %@",[pdfObject getObjectNumber]);
            //NSLog(@"contents: %@",[pdfObject getContents]);
            
            if([pdfObject getStreamObject])
            {
//                NSLog(@"stream object: %@",[pdfObject getStreamObject]);
                NSLog(@"stream unenc: %@",[[pdfObject getStreamObject] getDecompressedDataAsString]);
            }
        }
        
        
        //PDFPages *pg = [[PDFPages alloc] initWithDocument:document];
        //[pg getPageCount];
        //[pg getPagesTree];

        /*
        if ([document errorMessage]) {
            NSLog(@"%@", [document errorMessage]);
        }
        else {
            NSLog(@"%@", [document version]);
        }
        */

     }
    return 0;
}

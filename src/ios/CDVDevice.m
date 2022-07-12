#import "CDVDevice.h"
#import <Cordova/CDVPlugin.h>

@implementation CDVDevice

- (void)downloadFile:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* fileUrl = [command.arguments objectAtIndex:0];

    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[
    NSURL URLWithString:@"http://www.example.com/info.pdf"]];

    // Store the Data locally as PDF File
    NSString *resourceDocPath = [[NSString alloc] initWithString:[
        [[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]
            stringByAppendingPathComponent:@"Documents"
    ]];

    NSString *filePath = [resourceDocPath 
        stringByAppendingPathComponent:@"myPDF.pdf"];
    [pdfData writeToFile:filePath atomically:YES];


// Now create Request for the file that was saved in your documents folder
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];

    [webView setUserInteractionEnabled:YES];
    [webView setDelegate:self];
    [webView loadRequest:requestObj];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:"Successfull"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
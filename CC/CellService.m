//
//  CellService.m
//  文明施工
//
//  Created by fy ren on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CellService.h"

@implementation CellService

-(NSString *) CellWeb:(NSString *)url
{
    NSString * fullUrl = [[Settings Instance].ServiceUrl stringByAppendingString:url];
    fullUrl = [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //apiUrlStr = [apiUrlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* apiUrl = [NSURL URLWithString:fullUrl];
    NSError *error = nil;
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl usedEncoding:&encoding error:&error];
    //NSLog(@"api url: %@", apiUrl);
    //NSLog([error description]);
    return apiResponse;
}

//NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];


-(NSData *) CellWeb:(NSString *)url Data:(NSString *) data
{
    NSString * fullUrl = [[Settings Instance].ServiceUrl stringByAppendingString:url];
    //NSString *data = [[NSString alloc] initWithFormat:@"message=%@",@"hello,world."];
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:fullUrl]];
    [request setHTTPMethod:@"POST"]; 
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  
    [request setHTTPBody:postData];
    //[NSURLConnection connectionWithRequest:request delegate:self ];  
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

-(NSData *) CellWebData:(NSString *)url
{
    NSString * fullUrl = [[Settings Instance].ServiceUrl stringByAppendingString:url];
    fullUrl = [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* apiUrl = [NSURL URLWithString:fullUrl];
    NSData* data = [NSData dataWithContentsOfURL:apiUrl ];
    return data;
}

-(NSString *) CheckLogin:(NSString *)name Password:(NSString *)pwd
{
    NSString * url = [[NSString alloc] initWithFormat:@"IOS/Login?Name=%@&Password=%@",name,pwd];
    return [self CellWeb:url];
}

@end

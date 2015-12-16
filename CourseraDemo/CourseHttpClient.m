//
//  CourseHttpClient.m
//  CourseraDemo
//
//  Created by 臧其龙 on 15/12/14.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "CourseHttpClient.h"

static NSString * const kBaseURL = @"https://api.coursera.org/api/catalog.v1/";

@implementation CourseHttpClient

#pragma mark Singleton Init

+ (instancetype)sharedHttpClient
{
    static CourseHttpClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CourseHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL] sessionConfiguration:nil];
    });
    
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    
    if (self)
    {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.reachabilityManager startMonitoring];
        
    }
    
    return self;
}

#pragma mark - Http Method

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters success:success failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(SuccessBlock)success
                                         failure:(FailureBlock)failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    
    return dataTask;
}



@end

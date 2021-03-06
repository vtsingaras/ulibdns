//
//  UMDnsResolver.m
//  ulibdns
//
//  Created by Andreas Fink on 07/09/15.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMDnsResolver.h"
#import "UMDnsResolvingRequest.h"
#import "UMDnsRemoteServer.h"

@implementation UMDnsResolver

- (UMDnsResolver *)init
{
    self = [super initWithName:@"UMDnsResolver" workSleeper:[[UMSleeper alloc]init]];
    if(self)
    {
        newRequests = [[UMQueue alloc]init];
    }
    return self;
}

- (void)backgroundInit
{
    ulib_set_thread_name([NSString stringWithFormat:@"%@",self.name]);
    socket_u4 = [[UMSocket alloc]initWithType:UMSOCKET_TYPE_UDP4ONLY];
    socket_u6 = [[UMSocket alloc]initWithType:UMSOCKET_TYPE_UDP6ONLY];
    if((socket_u4==NULL) && (socket_u6==NULL))
    {
        @throw([NSException exceptionWithName:@"socket_error" reason:@"can not open sockets" userInfo:@{@"backtrace": UMBacktrace(NULL,0)}]);
    }
}

- (void)backgroundExit
{
    [socket_u4 close];
    [socket_u6 close];
}

- (int)work
{
    @autoreleasepool
    {
        UMDnsResolvingRequest *req = [newRequests getFirst];
        if(req)
        {
            UMSocket *socket = NULL;
            
            if(req.useStream)
            {
                socket = req.serverToQuery.socket;
            }
            else
            {
                if([req.serverToQuery.address isIPv4]==YES)
                {
                    socket = socket_u4;
                }
                else if([req.serverToQuery.address isIPv6]==YES)
                {
                    socket = socket_u6;
                }
                else
                {
                    @throw([NSException exceptionWithName:@"invalid_address" reason:@"server is neither ipv4 nor ipv6 address" userInfo:@{@"backtrace": UMBacktrace(NULL,0)}]);
                }
            }
            [self sendRequest:req socket:socket];
        }
    }
    return 0;
}

- (void)sendRequest:(UMDnsResolvingRequest *)req socket:(UMSocket *)socket
{
    
}

@end


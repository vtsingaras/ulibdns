//
//  UMDnsResourceRecordMB.h
//  ulibdns
//
//  Created by Andreas Fink on 31/08/15.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMDnsResourceRecord.h"

@interface UMDnsResourceRecordMB : UMDnsResourceRecord
{
    UMDnsName *madname;
}

@property (readwrite,strong) UMDnsName *madname;

- (UMDnsResourceRecordMB *)initWithMadname:(UMDnsName *)a;
- (UMDnsResourceRecordMB *)initWithParams:(NSArray *)params zone:(NSString *)zone;


@end

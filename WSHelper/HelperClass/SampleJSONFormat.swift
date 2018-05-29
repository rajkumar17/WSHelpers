//
//  SampleJSONFormat.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/17/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit

class SampleJSONFormat: NSObject {

    
    
}



/*
{
    "Flight1":{
        "3":{
            "id":"10",
            "name":"JumboJet1B",
            "level":"1",
            "category":"1",
            "energy":"10",
            "bonus":"10",
            "completed":0
        },
        "4":{
            "id":"10",
            "name":"JumboJet1B",
            "level":"1",
            "category":"1",
            "energy":"10",
            "bonus":"10",
            "completed":0
        }
    }
}

NSDictionary *flights = … // result from a JSON parser
NSDictionary *flight1 = [flights objectForKey:@"Flight1"];

for (NSString *key in [flight1 allKeys]) {
    NSDictionary *flight1Entry = [flight1 objectForKey:key];
    
    NSString *entryId = [flight1Entry objectForKey:@"id"];
    NSString *entryName = [flight1Entry objectForKey:@"name"];
    NSString *entryEnergy = [flight1Entry objectForKey:@"energy"];
    
    …
}
*/
//Otherwise, if you want the keys sorted according to their numeric value:
/*
NSDictionary *flights = … // result from a JSON parser
NSDictionary *flight1 = [flights objectForKey:@"Flight1"];
NSArray *flight1Keys = [[flight1 allKeys] sortedArrayUsingComparator:^(id o1, id o2) {
NSInteger i1 = [o1 integerValue];
NSInteger i2 = [o2 integerValue];
NSComparisonResult result;

if (i1 > i2) result = NSOrderedDescending;
else if (i1 < i2) result = NSOrderedAscending;
else result = NSOrderedSame;

return result;
}];

for (NSString *key in flight1Keys) {
    NSDictionary *flight1Entry = [flight1 objectForKey:key];
    
    NSString *entryId = [flight1Entry objectForKey:@"id"];
    NSString *entryName = [flight1Entry objectForKey:@"name"];
    NSString *entryEnergy = [flight1Entry objectForKey:@"energy"];
    
    …
}
*/
/////  ------
/*
NSDictionary *data1 = [dictionary objectForKey:@"Data 1"];
NSArray *arrayDecFirst2012 = [data1 objectForKey:@"2012-12-01"];
NSDictionary *firstDictionaryInDecFirst2012 = [arrayDecFirst2012 objectAtIndex:0];
NSString *fieldOne = [firstDictionaryInDecFirst2012 objectForKey:@"field 1"];
Or, if you want to use the new subscripting notation, that would be:

NSDictionary *data1 = dictionary[@"Data 1"];
NSArray *arrayDecFirst2012 = data1[@"2012-12-01"];
NSDictionary *firstDictionaryInDecFirst2012 = arrayDecFirst2012[0];
NSString *fieldOne = firstDictionaryInDecFirst2012[@"field 1"];*/

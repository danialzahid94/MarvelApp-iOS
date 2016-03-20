//
//  BaseEntity.h
//  SDaringGame
//
//  Created by Danial Zahid on 24/03/2014.
//  Copyright (c) 2014 Danial Zahid. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject


- (void)setValuesForKeysWithJSONDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
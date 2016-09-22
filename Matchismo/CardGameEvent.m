//
//  CardGameEvent.m
//  Matchismo
//
//  Created by Foster, Jake on 9/22/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CardGameEvent.h"

@implementation CardGameEvent
- initWithEvent:(CGCardEvent)event cards:(NSArray *)cards points:(NSInteger)points {
    self = [super init];
    if (self) {
        _event = event;
        _cards = cards;
        _points = points;
    }
    return self;
}

@end

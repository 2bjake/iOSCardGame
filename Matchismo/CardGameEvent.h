//
//  CardGameEvent.h
//  Matchismo
//
//  Created by Foster, Jake on 9/22/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, CGCardEvent) {
    CGEventCardSelect,
    CGEventCardUnselect,
    CGEventCardMatch,
    CGEventCardMismatch
};

@interface CardGameEvent : NSObject
@property (nonatomic, readonly) CGCardEvent event;
@property (nonatomic, readonly) NSArray *cards;
@property (nonatomic, readonly) NSInteger points;

- initWithEvent:(CGCardEvent)event cards:(NSArray *)cards points:(NSInteger)points;
@end

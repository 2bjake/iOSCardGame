//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@class CardGameEvent;

@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCardCount:(NSUInteger)count withDeck:(Deck *)deck NS_DESIGNATED_INITIALIZER;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (readonly, getter=isStarted) BOOL started;
@property (nonatomic) NSUInteger matchCount;
@property (nonatomic, readonly) NSArray* events;
@end

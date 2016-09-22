//
//  SetCardMatchingGame.h
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CardMatchingGame.h"
@class Deck;

@interface SetCardMatchingGame : CardMatchingGame
- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCardCount:(NSUInteger)count withDeck:(Deck *)deck NS_UNAVAILABLE;
@end

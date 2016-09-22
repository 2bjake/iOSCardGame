//
//  PlayingCardMatchingGame.h
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CardMatchingGame.h"

@interface PlayingCardMatchingGame : CardMatchingGame
- (instancetype)initWithCardCount:(NSUInteger)count withDeck:(Deck *)deck NS_UNAVAILABLE;

- (instancetype)initWithCardCount:(NSUInteger)count NS_DESIGNATED_INITIALIZER;
@end

//
//  PlayingCardMatchingGame.m
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "PlayingCardMatchingGame.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardMatchingGame
- (instancetype)initWithCardCount:(NSUInteger)count {
    self = [super initWithCardCount:count withDeck:[[PlayingCardDeck alloc] init]];
    return self;
}
@end

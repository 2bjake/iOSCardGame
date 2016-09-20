//
//  PlayingCard.m
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits {
    return @[@"♣️", @"♥️", @"♦️", @"♠️"];
}

+ (NSUInteger)maxRange {
    return [[self rankStrings] count] - 1;
}

@synthesize suit = _suit;

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRange]) {
        _rank = rank;
    }
}

- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if (otherCards.count == 1) {
        PlayingCard *otherCard = otherCards.firstObject;
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    } else if (otherCards.count == 2) {
        PlayingCard *firstCard = otherCards.firstObject;
        PlayingCard *secondCard = otherCards.lastObject;
        
        int matchScore = [self match:@[firstCard]];
        matchScore += [self match:@[secondCard]];
        matchScore += [firstCard match:@[secondCard]];
        return matchScore;
    }
    
    return score;
}

@end

//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardGameEvent.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSArray *events;
@property (nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count withDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        _matchCount = 2;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int LESSER_MATCH_BONUS = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    if (index < self.cards.count) {
        _started = YES;
        Card *card = self.cards[index];
        
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
                [self addEventWithCardEvent:CGEventCardUnselect cards:@[card] points:0];
            } else {
                [self addEventWithCardEvent:CGEventCardSelect cards:@[card] points:0];
                if (self.matchCount == 2) {
                    [self matchOneCardToCard:card];
                } else {
                    [self matchTwoCardsToCard:card];
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
        
        
    }
}

- (void)matchOneCardToCard:(Card*)card {
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                int newPoints = matchScore * MATCH_BONUS;
                [self addEventWithCardEvent:CGEventCardMatch cards:@[card, otherCard] points:newPoints];
                self.score += newPoints;
                card.matched = YES;
                otherCard.matched = YES;
            } else {
                [self addEventWithCardEvent:CGEventCardMismatch cards:@[card, otherCard] points:MISMATCH_PENALTY];
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}

- (void)matchTwoCardsToCard:(Card*) card {
    NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            [otherChosenCards addObject:otherCard];
        }
    }
    
    if (otherChosenCards.count == 2) {
        Card *firstCard = otherChosenCards.firstObject;
        Card *secondCard = otherChosenCards.lastObject;
        
        int matchScore = [card match:otherChosenCards];
        if (matchScore) {
            int newPoints = matchScore * LESSER_MATCH_BONUS;
            self.score += newPoints;
            card.matched = YES;
            firstCard.matched = YES;
            secondCard.matched = YES;
            
            [self addEventWithCardEvent:CGEventCardMatch cards:@[card, firstCard, secondCard] points:newPoints];

        } else {
            self.score -= MISMATCH_PENALTY;
            firstCard.chosen = NO;
            secondCard.chosen = NO;
            [self addEventWithCardEvent:CGEventCardMismatch cards:@[card, firstCard, secondCard] points:MISMATCH_PENALTY];
        }
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)setMatchCount:(NSUInteger)matchCount {
    if (!self.isStarted) {
        _matchCount = matchCount;
    }
}

- (NSArray *)events {
    if (!_events) _events = [[NSArray alloc] init];
    return _events;
}

- (void)addEventWithCardEvent:(CGCardEvent)cardEvent cards:(NSArray*)cards points:(NSInteger)points {
    CardGameEvent *event = [[CardGameEvent alloc] initWithEvent:cardEvent cards:cards points:points];
    self.events = [self.events arrayByAddingObject:event];
}

@end

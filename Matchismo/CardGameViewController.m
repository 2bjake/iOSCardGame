//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CardGameViewController.h"
#import "GameHistoryViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "CardGameEvent.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createGame];
    }
    return _game;
}

- (void)resetGame {
    _game = [self createGame];
}

- (CardMatchingGame *)createGame { //abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)drawCard:(Card *)card onButton:(UIButton *)button {
    //abstract
}

- (NSAttributedString *) attributedStringForCard:(Card*)card {
    return [[NSAttributedString alloc] initWithString:@""]; //abstract
}

- (void)updateUI {
    for (int i = 0; i < self.cardButtons.count; i++) {
        Card *card = [self.game cardAtIndex:i];
        UIButton *button = self.cardButtons[i];
        [self drawCard:card onButton:button];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.statusLabel.attributedText = [self attributedTextForEvent:self.game.events.lastObject];
}

- (NSAttributedString *)attributedTextForEvent:(CardGameEvent *)event {
    if (event == nil) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:@""];

    switch (event.event) {
        case CGEventCardSelect:
            status = [self joinAttributedStrings:@[[self attributedStringForCard:event.cards.firstObject], @"selected."]];
            break;
        case CGEventCardUnselect:
            status = [self joinAttributedStrings:@[[self attributedStringForCard:event.cards.firstObject], @"unselected."]];
            break;
        case CGEventCardMatch:
            status = [self joinAttributedStrings:[[[[@[@"Matched"]
                                                    arrayByAddingObjectsFromArray:[self attributedStringsForCards:event.cards]]
                                                    arrayByAddingObject:@"for"]
                                                    arrayByAddingObject:[NSString stringWithFormat:@"%ld", (long)event.points]]
                                                    arrayByAddingObject:@"points."]];
            break;
        case CGEventCardMismatch:
            status = [self joinAttributedStrings:[[[[self attributedStringsForCards:event.cards]
                                                    arrayByAddingObject:@"don't match."]
                                                    arrayByAddingObject:[NSString stringWithFormat:@"%ld", (long)event.points]]
                                                    arrayByAddingObject:@"point penalty!"]];
            break;
    }
    
    return status;
}

- (NSMutableArray *) attributedStringsForCards: (NSArray *)cards {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Card* card in cards) {
        [result addObject:[self attributedStringForCard:card]];
    }
    return result;
}

- (NSMutableAttributedString *) joinAttributedStrings:(NSArray *)strings {
    NSAttributedString *space = [[NSAttributedString alloc] initWithString:@" "];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (int i = 0; i < strings.count; i++) {
        if (i != 0) {
            [result appendAttributedString:space];
        }
        id string = strings[i];
        
        
        NSAttributedString *newString = [[NSAttributedString alloc] initWithString:@""];
        if ([string isKindOfClass:[NSString class]]) {
            newString = [[NSAttributedString alloc] initWithString:string];
        } else if ([string isKindOfClass:[NSAttributedString class]]) {
            newString = string;
        }
        
        [result appendAttributedString:newString];
    }
    return result;
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [self resetGame];
    [self updateUI];
}

- (NSUInteger)cardCount {
    return self.cardButtons.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *hvc = (GameHistoryViewController *) segue.destinationViewController;
            
            NSMutableArray *strings = [[NSMutableArray alloc] init];
            for (CardGameEvent *event in self.game.events) {
                [strings addObject:[self attributedTextForEvent:event]];
            }
            hvc.history = strings;
        }
    }
}

@end

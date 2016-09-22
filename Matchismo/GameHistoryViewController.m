//
//  GameHistoryViewController.m
//  Matchismo
//
//  Created by Foster, Jake on 9/22/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation GameHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateTextView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateTextView];
}

- (NSArray *)history {
    if (!_history) _history = @[];
    return _history;
}

- (void)updateTextView {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
    NSAttributedString *newline = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    for (NSAttributedString *string in self.history) {
        [text appendAttributedString:string];
        [text appendAttributedString:newline];
    }
    self.textView.attributedText = text;
}

@end

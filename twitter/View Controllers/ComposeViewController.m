//
//  ComposeViewController.m
//  twitter
//
//  Created by Tariq Almawash on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *draftText;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *countLabel;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.draftText.delegate = self;
    [self.draftText becomeFirstResponder];

}
- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetTapped:(id)sender {
    [[APIManager shared] postStatusWithText:self.draftText.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (self.draftText.text.length > 260) {
        self.countLabel.tintColor = [UIColor redColor];
    }
    else if (self.draftText.text.length > 240) {
        self.countLabel.tintColor = [UIColor orangeColor];
    }
    else {
        self.countLabel.tintColor = [UIColor lightGrayColor];
    }
    
    if (self.draftText.text.length > 280) {
        self.draftText.text = [self.draftText.text substringWithRange:NSMakeRange(0, 280)];
    }
    [self.countLabel setTitle:[NSString stringWithFormat:@"%lu", self.draftText.text.length]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

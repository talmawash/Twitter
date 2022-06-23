//
//  TweetCell.m
//  twitter
//
//  Created by Tariq Almawash on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface TweetCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userIdAndDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *repliesButton;
@property (weak, nonatomic) IBOutlet UILabel *labelFavs;
@property (weak, nonatomic) IBOutlet UILabel *labelRetweets;
@property (weak, nonatomic) IBOutlet UILabel *labelReplies;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)loadTweet {
    self.userName.text = self.tweet.user.name;
    NSString *userNameAndDate = [NSString stringWithFormat:@"@%@ · %@", self.tweet.user.screenName, self.tweet.shortTimeAgo];

    self.userIdAndDate.text = userNameAndDate;
    self.tweetText.text = self.tweet.text;
    [self.tweetText setLineBreakMode:NSLineBreakByClipping];
    self.labelReplies.text = @"";// premium feature [NSString stringWithFormat:@"%i", self.tweet.repliesCount];
    self.labelRetweets.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.labelFavs.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.repliesButton setTitle:@"" forState:UIControlStateNormal];
    // [self.repliesButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.retweetButton setTitle:@"" forState:UIControlStateNormal];
    // [self.retweetButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.favoriteButton setTitle:@"" forState:UIControlStateNormal];
    // [self.favoriteButton setTitle:@"" forState:UIControlStateHighlighted];
    if (self.tweet.favorited) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    NSURL *URL = [NSURL URLWithString:self.tweet.user.profilePicture];
    
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:URL];
    [self.profileImage setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        self.profileImage.layer.cornerRadius = 24;
        self.profileImage.clipsToBounds = TRUE;
        if (response) {
            self.profileImage.alpha = 0.0;
            self.profileImage.image = image;
            [UIView animateWithDuration:0.3 animations:^{
                self.profileImage.alpha = 1;
            }];
        }
        else {
            self.profileImage.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)retweetTapped:(id)sender {
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self loadTweet];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet * tweet, NSError * error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self loadTweet];
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet * tweet, NSError * error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (IBAction)favoriteTapped:(id)sender {
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self loadTweet];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet * tweet, NSError * error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [self loadTweet];
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet * tweet, NSError * error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

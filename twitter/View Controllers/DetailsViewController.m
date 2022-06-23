//
//  DetailsViewController.m
//  twitter
//
//  Created by Tariq Almawash on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#include "APIManager.h"
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *labelTweet;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelRetweets;
@property (weak, nonatomic) IBOutlet UILabel *labelFavorites;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *repliesButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *retAndFavCell;
@property (weak, nonatomic) IBOutlet UILabel *labelRetweetWord;
@property (weak, nonatomic) IBOutlet UILabel *labelFavoriteWord;

@end

@implementation DetailsViewController

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = nil;

    self.labelTweet.text = self.tweet.text;
    self.labelName.text = self.tweet.user.name;
    self.labelUsername.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.labelDate.text = self.tweet.createdAtString;
    [self.repliesButton setTitle:@"" forState:UIControlStateNormal];
    // [self.repliesButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.retweetButton setTitle:@"" forState:UIControlStateNormal];
    // [self.retweetButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.favoriteButton setTitle:@"" forState:UIControlStateNormal];
    // [self.favoriteButton setTitle:@"" forState:UIControlStateHighlighted];
    
    [self updateRetweetsAndFavorites];
    
    NSURL *URL = [NSURL URLWithString:self.tweet.user.profilePicture];
    
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:URL];
    [self.imageProfile setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        self.imageProfile.layer.cornerRadius = 24;
        self.imageProfile.clipsToBounds = TRUE;
        if (response) {
            self.imageProfile.alpha = 0.0;
            self.imageProfile.image = image;
            [UIView animateWithDuration:0.3 animations:^{
                self.imageProfile.alpha = 1;
            }];
        }
        else {
            self.imageProfile.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (void)updateRetweetsAndFavorites{
    self.labelRetweets.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.labelFavorites.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
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
}

- (IBAction)retweetTapped:(id)sender {
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self updateRetweetsAndFavorites];
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
        [self updateRetweetsAndFavorites];
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
    NSLog(@"fav tapped!");
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self updateRetweetsAndFavorites];
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
        [self updateRetweetsAndFavorites];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  TweetCell.m
//  twitter
//
//  Created by Tariq Almawash on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
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
    NSString *userNameAndDate = [NSString stringWithFormat:@"@%@ · %@", self.tweet.user.screenName, self.tweet.createdAtString];
    self.userIdAndDate.text = userNameAndDate;
    self.tweetText.text = self.tweet.text;
    [self.tweetText sizeToFit];
    [self.tweetText setLineBreakMode:NSLineBreakByClipping];
    self.labelReplies.text = [NSString stringWithFormat:@"%i", self.tweet.repliesCount];
    self.labelRetweets.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.labelFavs.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.repliesButton setTitle:@"" forState:UIControlStateNormal];
    // [self.repliesButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.retweetButton setTitle:@"" forState:UIControlStateNormal];
    // [self.retweetButton setTitle:@"" forState:UIControlStateHighlighted];
    [self.favoriteButton setTitle:@"" forState:UIControlStateNormal];
    // [self.favoriteButton setTitle:@"" forState:UIControlStateHighlighted];
    
    NSURL *URL = [NSURL URLWithString:self.tweet.user.profilePicture];
    
    
    NSURLRequest *posterReq = [NSURLRequest requestWithURL:URL];
    [self.profileImage setImageWithURLRequest:posterReq placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TweetCell.h
//  twitter
//
//  Created by Tariq Almawash on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) Tweet* tweet;

- (void)loadTweet;
@end

NS_ASSUME_NONNULL_END

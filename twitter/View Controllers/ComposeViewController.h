//
//  ComposeViewController.h
//  twitter
//
//  Created by Tariq Almawash on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet: (Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController <UITextViewDelegate>
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

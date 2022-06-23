//
//  DetailsViewController.h
//  twitter
//
//  Created by Tariq Almawash on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UITableViewController
@property (strong, nonatomic) Tweet *tweet;
@end

NS_ASSUME_NONNULL_END

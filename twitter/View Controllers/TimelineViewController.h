//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "DetailsViewController.h"
@interface TimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, DetailsViewControllerDelegate>

@end

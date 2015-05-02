//
//  ViewTableViewCell.h
//  json123
//
//  Created by Sharobitech_Mac on 20/02/15.
//  Copyright (c) 2015 Superton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *notice_id;

@property (strong, nonatomic) IBOutlet UILabel *notice_venue;

@property (strong, nonatomic) IBOutlet UILabel *notice_date;

@property (strong, nonatomic) IBOutlet UILabel *notice_time;

@property (strong, nonatomic) IBOutlet UILabel *notice_details;

@property (strong, nonatomic) IBOutlet UILabel *notice_title;

@property (strong, nonatomic) IBOutlet UILabel *notice_subtitle;

@property (strong, nonatomic) IBOutlet UILabel *notice_regards;



@end

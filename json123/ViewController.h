//
//  ViewController.h
//  json123
//
//  Created by Superton on 2/19/15.
//  Copyright (c) 2015 Superton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain,nonatomic)IBOutlet UITableView *table;
@property (retain,nonatomic)NSMutableArray *jsonArray;
@property (nonatomic,strong)  NSMutableDictionary * organizedData ;

@property (nonatomic,strong)  NSArray *dataarray;
@property (retain,nonatomic)IBOutlet UILabel *lblid,*lblvenue,*lbldate,*lbltme,
*lbltitle,*lblsbtitle,*lbldetails,*lblregards;
-(void)loaddata;

@end


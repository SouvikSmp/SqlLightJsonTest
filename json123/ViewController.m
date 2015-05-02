//
//  ViewController.m
//  json123
//
//  Created by Superton on 2/19/15.
//  Copyright (c) 2015 Superton. All rights reserved.
//

#import "ViewController.h"
#import "ViewTableViewCell.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    AppDelegate *appdel;
    NSOperationQueue *operation;
}

@end

@implementation ViewController
@synthesize table;

NSMutableArray *arrresult;
@synthesize lbltitle,lbltme,lbldate,lblvenue,lblid,lblsbtitle,lbldetails,lblregards;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.organizedData=[[NSMutableDictionary alloc]init];
    
    operation=[[NSOperationQueue alloc] init];
    arrresult=[[NSMutableArray alloc]init];
    appdel=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdel getAllthevalues];
    [self.table reloadData];
    NSInvocationOperation *invocation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loaddata) object:nil];
    [operation addOperation:invocation];
    
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appdel.Alldataarry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"jsonCell";
    NSMutableDictionary *mutDic=[appdel.Alldataarry objectAtIndex:indexPath.row];
    ViewTableViewCell * cell = (ViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    if (cell==nil)
    {
        cell=[[ViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    cell.notice_id.text = [mutDic valueForKey:@"notice_id"];
    cell.notice_venue.text = [mutDic valueForKey:@"notice_venue"];
    cell.notice_date.text = [mutDic valueForKey:@"notice_date"];
    cell.notice_time.text = [mutDic valueForKey:@"notice_time"];
    cell.notice_title.text = [mutDic valueForKey:@"notice_title"];
    cell.notice_subtitle.text = [mutDic valueForKey:@"notice_sub_title"];
    cell.notice_regards.text = [mutDic valueForKey:@"notice_regards"];
    [cell.notice_details sizeToFit];
    cell.notice_details.text = [mutDic valueForKey:@"notice_details"];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)loaddata
{
    @try {
        
        NSError *err;
        arrresult=[[NSMutableArray alloc]init];
        NSString *str=[NSString stringWithFormat:@"http://app.yourwebdesignguys.com/scottish_church_college/api/user/noticelist/format/json/uid/911367107731797"];
        NSURL *url=[NSURL URLWithString:str];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
        self.dataarray=[maindic valueForKey:@"data"];
        
        if (self.dataarray.count > 0)
        {
            for (NSDictionary *dicall in _dataarray)
            {
                NSMutableDictionary *organizedData=[[NSMutableDictionary alloc]init];
                [organizedData setValue:[dicall valueForKey:@"notice_id"] forKey:@"notice_id"];
                [organizedData setValue:[dicall valueForKey:@"notice_venue"] forKey:@"notice_venue"];
                [organizedData setValue:[dicall valueForKey:@"notice_date"] forKey:@"notice_date"];
                [organizedData setValue:[dicall valueForKey:@"notice_time"] forKey:@"notice_time"];
                [organizedData setValue:[dicall valueForKey:@"notice_title"] forKey:@"notice_title"];
                [organizedData setValue:[dicall valueForKey:@"notice_sub_title"] forKey:@"notice_sub_title"];
                [organizedData setValue:[dicall valueForKey:@"notice_details"] forKey:@"notice_details"];
                [organizedData setValue:[dicall valueForKey:@"notice_regards"] forKey:@"notice_regards"];
                [organizedData setValue:[dicall valueForKey:@"notice_dom"] forKey:@"notice_dom"];
                [organizedData setValue:[dicall valueForKey:@"notice_status"] forKey:@"notice_status"];
                if ([appdel saveDatanotice_id:[dicall valueForKey:@"notice_id"] notice_venue:[dicall valueForKey:@"notice_venue"] notice_date:[dicall valueForKey:@"notice_date"] Notificationtime:[dicall valueForKey:@"notice_time"] WithTitle:[dicall valueForKey:@"notice_title"] Withsubtitle:[dicall valueForKey:@"notice_sub_title"] withNoticeDetails:[dicall valueForKey:@"notice_details"] withnotice_regards:[dicall valueForKey:@"notice_regards"] withnotice_dom:[dicall valueForKey:@"notice_dom"] withnotistatus:[dicall valueForKey:@"notice_status"]])
                {
                    NSLog(@"data success fully save");
                }
                else
                {
                    if ([appdel readEmployeesFromDatabase:[dicall valueForKey:@"notice_id"] Comparewith:[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",[dicall valueForKey:@"notice_venue"],[dicall valueForKey:@"notice_date"],[dicall valueForKey:@"notice_time"],[dicall valueForKey:@"notice_title"],[dicall valueForKey:@"notice_sub_title"],[dicall valueForKey:@"notice_details"],[dicall valueForKey:@"notice_regards"],[dicall valueForKey:@"notice_dom"],[dicall valueForKey:@"notice_status"]]])
                    {
                        NSLog(@"update whth new value:");
                    }
                }
                
                
                
                
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [appdel getAllthevalues];
                [self.table reloadData];
            });
            
            
        }

    }
    @catch (NSException *exception) {
        NSLog(@"The value of exception name:%@ and Description:%@",exception.name,exception.description);
    }
  
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

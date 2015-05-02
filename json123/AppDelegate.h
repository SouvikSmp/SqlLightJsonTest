//
//  AppDelegate.h
//  json123
//
//  Created by Superton on 2/19/15.
//  Copyright (c) 2015 Superton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *Alldataarry;

-(BOOL)saveDatanotice_id:(NSString*)notice_id notice_venue:(NSString*)notice_venue notice_date:(NSString*)notice_date Notificationtime:(NSString *)Notificationtime WithTitle:(NSString *)notice_title Withsubtitle:(NSString *)notice_sub_title withNoticeDetails:(NSString *)Details withnotice_regards:(NSString *)notice_regards withnotice_dom:(NSString *)notice_dom withnotistatus:(NSString *)notice_status;
-(BOOL)readEmployeesFromDatabase:(NSString *)Id Comparewith:(NSString *)Compare;
-(void)getAllthevalues;

@end


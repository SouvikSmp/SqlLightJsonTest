//
//  AppDelegate.m
//  json123
//
//  Created by Superton on 2/19/15.
//  Copyright (c) 2015 Superton. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    NSString *databaseName,*databasePath;
}

@end

@implementation AppDelegate
@synthesize Alldataarry;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    databaseName = @"savejsondata.sqlite";
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    // Execute the "checkAndCreateDatabase" function
    Alldataarry=[[NSMutableArray alloc] init];
    [self checkAndCreateDatabase];

    return YES;
}

-(void) checkAndCreateDatabase
{
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
    BOOL success;
    
    // Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the database has already been created in the users filesystem
    success = [fileManager fileExistsAtPath:databasePath];
      // If the database already exists then return without doing anything
    if(success) return;
    
    // If not then proceed to copy the database from the application to the users filesystem
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
  
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    NSLog(@"data base file path:%@",databasePathFromApp);
    fileManager=nil;
}


-(BOOL)saveDatanotice_id:(NSString*)notice_id notice_venue:(NSString*)notice_venue notice_date:(NSString*)notice_date Notificationtime:(NSString *)Notificationtime WithTitle:(NSString *)notice_title Withsubtitle:(NSString *)notice_sub_title withNoticeDetails:(NSString *)Details withnotice_regards:(NSString *)notice_regards withnotice_dom:(NSString *)notice_dom withnotistatus:(NSString *)notice_status
{
    
    sqlite3 *database;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into datasave (notice_id,notice_venue,notice_date,notice_time,notice_title,notice_sub_title,notice_details,notice_regards,notice_dom,notice_status) values (\"%ld\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",[notice_id integerValue], notice_venue, notice_date,Notificationtime,notice_title,notice_sub_title,Details,notice_regards,notice_dom,notice_status];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_stmt *statement;
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else
        {
           return NO;
        }
       
    }
    return NO;
}


-(BOOL)readEmployeesFromDatabase:(NSString *)Id Comparewith:(NSString *)Compare
{
    // Setup the database object
    sqlite3 *database;
    BOOL Updateable=NO;
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        NSString *Getallthevaluesofarow=[NSString stringWithFormat:@"select * from datasave where notice_id=\"%ld\"",[Id integerValue]];
        const char *sqlStatement =[Getallthevaluesofarow UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                // Read the data from the result row
                NSString *mainstr=@"";
                for (int i=1; i<10; i++)
                {
                    NSString *strvalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)];
                    mainstr=[NSString stringWithFormat:@"%@%@",mainstr,strvalue];
                }
               
                if (![mainstr isEqualToString:Compare])
                {
                    NSLog(@"update able");
                    Updateable=YES;
                }
                else
                {
                    NSLog(@"there is no need of update");
                }
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    return Updateable;
}

-(void)getAllthevalues
{
    sqlite3 *database;
    [Alldataarry removeAllObjects];
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        NSString *Getallthevaluesofarow=[NSString stringWithFormat:@"select * from datasave"];
        const char *sqlStatement =[Getallthevaluesofarow UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                // Read the data from the result row
                NSMutableDictionary *mutDiAall=[[NSMutableDictionary alloc] init];
                for (int i=0; i<10; i++)
                {
                    NSString *strvalue=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)];
                    [mutDiAall setValue:strvalue forKey:[self ReturnString:i]];
                }
                [Alldataarry addObject:mutDiAall];
                
            }
        }
        NSLog(@"The value of mutdic count:%ld",[Alldataarry count]);
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
}

-(NSString *)ReturnString:(int)value
{
    switch (value) {
        case 0:
            return @"notice_id";
            break;
        case 1:
            return @"notice_venue";
            break;
        case 2:
            return @"notice_date";
            break;
        case 3:
            return @"notice_time";
            break;
        case 4:
            return @"notice_title";
            break;
        case 5:
            return @"notice_sub_title";
            break;
        case 6:
            return @"notice_details";
            break;
        case 7:
            return @"notice_regards";
            break;
        case 8:
            return @"notice_dom";
            break;
        case 9:
            return @"notice_status";
            break;
        default:
            return @"";
            break;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

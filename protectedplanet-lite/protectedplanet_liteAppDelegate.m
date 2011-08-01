//
//  protectedplanet_liteAppDelegate.m
//  protectedplanet-lite
//
//  Created by Craig Mills on 31/07/2011.
//  Copyright 2011 UNEP-WCMC. All rights reserved.
//

#import "protectedplanet_liteAppDelegate.h"
#import "SBJson.h"
#import "protectedareaData.h"
#import "RootViewController.h"


@implementation protectedplanet_liteAppDelegate

//need these to access the viewcontroller stuff from the delegate
@synthesize window=_window;
@synthesize navigationController=_navigationController;

//all variables needed to get json and store results  TODO- probably only needs to be instance variables- need to test---
@synthesize pas;
@synthesize urlConnection;
@synthesize receivedData;
@synthesize paUrl = _paUrl;
//----------------------------------------


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    
    
    //section to grab json and parse it to the view controller ---------------------
    //viewcontroller is not refreshed until all the data are accounted for in the "connectionDidFinishLoading" method
    
    if ((self = [super init])) {
        
        //_pas = [[NSMutableArray array] retain];
        NSString *urlAsString = [NSString stringWithFormat:@"%@", @"http://localhost:3000/test_json.json"];
        
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAsString]];
        // Create the NSURLConnection con object with the NSURLRequest req object
        // and make this same class the delegate.
        urlConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        // Connection successful
        if (urlConnection) {
            NSMutableData *data = [[NSMutableData alloc] init];
            self.receivedData=data;
            [data release];
        }
        // Bad news, connection failed.
        else
            
        {
            UIAlertView *alert = [
                                  [UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"Error", @"Error")
                                  message:NSLocalizedString(@"Error connecting to remote server", @"Error connecting to remote server")
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"Bummer", @"Bummer")
                                  otherButtonTitles:nil
                                  ];
            [alert show];
            [alert release];
        }
        [req release];
        
    }

    
    
    //---------------------------------------------------------
    
    return YES;
}




//section to cover all the NSURLConnection callback methody stuff ------------------------

#pragma mark - NSURLConnection Callbacks
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
    self.receivedData = nil; 
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:[NSString stringWithFormat:@"Connection failed! Error - %@ (URL: %@)", [error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]]
                          delegate:self
                          cancelButtonTitle:@"Bummer"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    // Change UI to active state
    //[self setUIState:ACTIVE_STATE];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Convert receivedData to NSString.
    NSString *receivedDataAsString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    // Trace receivedData
    NSLog(@"Download has been successful!!!!!!!");
    //NSLog(@"%s - %@", __FUNCTION__, receivedDataAsString);
    
    
    
    // Create a dictionary from the JSON string
    NSDictionary *results = [receivedDataAsString JSONValue];
    
    NSMutableArray *temp_pas = [NSMutableArray array]; //this used to store all the pas in the json dictionary
    
    //loop through the json results creating a pa object to use to parse into the viewcontroller
    for (NSDictionary *jsonPa in results)
    {
        //NSLog (@"%@: %@", @"name:", [jsonPa objectForKey:@"name"]);     //log to make sure the json is in and being read
        
        
        //get pa name, desig and photo and add to pa object
        NSString *name = [jsonPa objectForKey:@"name"];
        NSString *desig = [jsonPa objectForKey:@"name"];
        NSString *image = @"http://localhost:3000/images/pa1.jpg"; //need to change to url from pp
        //NSString *image = [jsonPa objectForKey:@"image"];            
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: image]];
        
        //set-up pa object
        protectedareaData *pa1 = [[protectedareaData alloc] initWithName:name designation:desig thumbImage:[UIImage imageWithData: imageData]];
        [temp_pas addObject: pa1]; 
        
        
        //release the allocation of pa once it's in the array
        [pa1 release];
        //[imageData release];
        
        
    }
    

    //assign array of pas to rootController object 
    RootViewController *rootController = (RootViewController *) [_navigationController.viewControllers objectAtIndex:0];
    [rootController setPas:[temp_pas copy]];
    
    
    // Override point for customization after application launch. - THIS HAS TO BE DONE HERE AS YOU NEED ALL THE DATA IN FROM THE JSON REQUEST BEFORE FILLING THE TABLE (could use a switch instead)
    
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
     
    //release data from json
    [receivedDataAsString release];
    
    // Connection resources release.
    [connection release];
    
    self.receivedData = nil;
 }

//--------------------------------------

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end

//
//  protectedplanet_liteAppDelegate.h
//  protectedplanet-lite
//
//  Created by Craig Mills on 31/07/2011.
//  Copyright 2011 UNEP-WCMC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface protectedplanet_liteAppDelegate : NSObject <UIApplicationDelegate> {

    
    NSMutableArray *pas;
    NSString *_paUrl;
    NSURLConnection *urlConnection;
    NSMutableData *receivedData;
    
}


//-----default
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
//--------
@property (retain) NSMutableArray *pas;
@property (copy) NSString *paUrl;
@property (nonatomic, retain) NSURLConnection *urlConnection;
@property (nonatomic, retain) NSMutableData *receivedData;



@end

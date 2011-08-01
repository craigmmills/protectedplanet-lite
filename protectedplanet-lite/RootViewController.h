//
//  RootViewController.h
//  protectedplanet-lite
//
//  Created by Craig Mills on 31/07/2011.
//  Copyright 2011 UNEP-WCMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSMutableArray *_pas;
}


-(void) setPas: (NSMutableArray*) pas;

@end

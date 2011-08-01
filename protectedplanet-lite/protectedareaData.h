//
//  protectedareas.h
//  protectedplanet
//
//  Created by Craig Mills on 22/07/2011.
//  Copyright 2011 UNEP-WCMC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface protectedareaData : NSObject {
    NSString *_name;
    NSString *_designation;
    UIImage *_thumbImage;
}

@property (copy) NSString *name;
@property (copy) NSString *designation;
@property (retain) UIImage *thumbImage;

-(id)initWithName:(NSString*)name designation:(NSString*)designation thumbImage:(UIImage*)thumbImage;

@end

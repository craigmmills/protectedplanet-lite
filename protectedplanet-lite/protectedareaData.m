//
//  protectedareas.m
//  protectedplanet
//
//  Created by Craig Mills on 22/07/2011.
//  Copyright 2011 UNEP-WCMC. All rights reserved.
//

#import "protectedareaData.h"


@implementation protectedareaData
@synthesize name = _name;
@synthesize designation = _designation;
@synthesize thumbImage = _thumbImage;


-(id)initWithName:(NSString *)name designation:(NSString *)designation thumbImage:(UIImage *)thumbImage {

    //set instance variables
    if ((self = [super init])) {
        
        _name = [name copy];
        _designation = [designation copy];
        _thumbImage = [thumbImage retain];
        
    }
    return self;
}

- (void)dealloc {
    
    [super dealloc];
    
}

@end

//
//  OBJ_Informacion_manual.m
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "OBJ_Informacion_manual.h"

@implementation OBJ_Informacion_manual
@synthesize consejo;
@synthesize imagen;
@synthesize titulo;

-(id) init:(NSString *)texto imagen:(NSString *)image titulo:(NSString *)titulo_view
{
    if (self = [super init])
    {
        consejo = texto;
        imagen = image;
        titulo = titulo_view;
    }
    return self;
}
@end

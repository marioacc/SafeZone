//
//  OBJ_Informacion_manual.h
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBJ_Informacion_manual : NSObject
@property NSString * consejo;
@property NSString * imagen;
@property NSString * titulo;

-(id) init:(NSString *)texto imagen:(NSString *)image titulo:(NSString *)titulo_view;
@end

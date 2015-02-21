//
//  VC_Manual_Triangle_Detalle.h
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBJ_Informacion_manual.h"

@interface VC_Manual_Triangle_Detalle : UIViewController
{
    NSMutableArray * objetos;
    __weak IBOutlet UITextView *text_informacion;
    __weak IBOutlet UIImageView *image;
    __weak IBOutlet UILabel *label_title;
}
- (IBAction)action_siguiente:(id)sender;
- (IBAction)action_anterior:(id)sender;
@property int seleccion;
@end

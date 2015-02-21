//
//  VC_Manual_General.h
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_Manual_General : UIViewController{
    NSMutableArray * objetos;
    __weak IBOutlet UITextView *text_informacion;
    __weak IBOutlet UIImageView *image;
    __weak IBOutlet UILabel *label_title;
}
@property int seleccion;

@end

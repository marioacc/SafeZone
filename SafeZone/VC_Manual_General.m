//
//  VC_Manual_General.m
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VC_Manual_General.h"
#import "OBJ_Informacion_manual.h"

@interface VC_Manual_General ()

@end

@implementation VC_Manual_General
@synthesize seleccion;

- (void)viewDidLoad {
    [super viewDidLoad];
    objetos = [[NSMutableArray alloc]init];
    [self cargarObjetos];
    
    OBJ_Informacion_manual * objeto_actual = [objetos objectAtIndex:seleccion];
    text_informacion.text = objeto_actual.consejo;
    NSString * imagen_actual = objeto_actual.imagen;
    UIImage *imagen_path = [UIImage imageNamed: imagen_actual];
    [image setImage:imagen_path];
    //self.title = objeto_actual.titulo;
    label_title.text = objeto_actual.titulo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cargarObjetos
{
    OBJ_Informacion_manual * objeto1 = [[OBJ_Informacion_manual alloc]init:@"Drop into your knees before the earthquake is able to drop you down, this way it is possible to still move if required. ." imagen:@"Drop" titulo:@"Drop"];
    [objetos addObject:objeto1];
    OBJ_Informacion_manual * objeto2 = [[OBJ_Informacion_manual alloc]init:@"Cover your body below a sturdy object like a table." imagen:@"Cover" titulo:@"Cover"];
    [objetos addObject:objeto2];
    OBJ_Informacion_manual * objeto3 = [[OBJ_Informacion_manual alloc]init:@"Stay under the shelter until the earthquake stops, be ready to move with it if the earthquake moves it around." imagen:@"Hold" titulo:@"Hold"];
    [objetos addObject:objeto3];
}

- (IBAction)action_siguiente:(id)sender {
    seleccion ++;
    if (seleccion > 2) {
        seleccion = 0;
    }
    
    OBJ_Informacion_manual * objeto_actual = [objetos objectAtIndex:seleccion];
    text_informacion.text = objeto_actual.consejo;
    NSString * imagen_actual = objeto_actual.imagen;
    UIImage *imagen_path = [UIImage imageNamed: imagen_actual];
    [image setImage:imagen_path];
    //self.title = objeto_actual.titulo;
    label_title.text = objeto_actual.titulo;
}

- (IBAction)action_anterior:(id)sender {
    seleccion --;
    if (seleccion < 0) {
        seleccion = 2;
    }
    
    OBJ_Informacion_manual * objeto_actual = [objetos objectAtIndex:seleccion];
    text_informacion.text = objeto_actual.consejo;
    NSString * imagen_actual = objeto_actual.imagen;
    UIImage *imagen_path = [UIImage imageNamed: imagen_actual];
    [image setImage:imagen_path];
    //self.title = objeto_actual.titulo;
    label_title.text = objeto_actual.titulo;
}


@end

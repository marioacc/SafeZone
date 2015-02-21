//
//  VC_Manual_Triangle_Detalle.m
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VC_Manual_Triangle_Detalle.h"
#import "OBJ_Informacion_manual.h"

@interface VC_Manual_Triangle_Detalle ()

@end

@implementation VC_Manual_Triangle_Detalle
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
    
}


-(void)cargarObjetos
{
    OBJ_Informacion_manual * objeto1 = [[OBJ_Informacion_manual alloc]init:@"Most people who just duck and covers when a building collapse are crushed to death. Get next to an object, a sofa, a bed, a bulky object which after compressing will leave a void next to it." imagen:@"Manual_01" titulo:@"Triangle of Life"];
    [objetos addObject:objeto1];
    OBJ_Informacion_manual * objeto2 = [[OBJ_Informacion_manual alloc]init:@"Curl up in fetal position, this way you can survive in a smaller void." imagen:@"Manual_02" titulo:@"Curl Up"];
    [objetos addObject:objeto2];
    OBJ_Informacion_manual * objeto3 = [[OBJ_Informacion_manual alloc]init:@"Wooden buildings are the safest kind of construction during earthquakes. The wood is flexible and create large survival voids. Brick buildings will break into individual bricks and cause injuries. Concrete slabs have a greater crushing weight and more squashed bodies. " imagen:@"Manual_03" titulo:@"Wooden Buildings"];
    [objetos addObject:objeto3];
    OBJ_Informacion_manual * objeto4 = [[OBJ_Informacion_manual alloc]init:@"Don't get under doorways. If the doorway falls fordward or backward you will get crushed by the ceiling above, If the doorway falls sideways you will be cut in half by the doorway." imagen:@"Manual_04" titulo:@"Doorways"];
    [objetos addObject:objeto4];
    OBJ_Informacion_manual * objeto5 = [[OBJ_Informacion_manual alloc]init:@" Stay away of stairs. The stairs move in a different frequency during earthquakes bumping into the main building damaging them. Even if they don't collapse after the earthquake they might later with the weight of people, check them first always." imagen:@"Manual_05" titulo:@"Stairways"];
    [objetos addObject:objeto5];
    OBJ_Informacion_manual * objeto6 = [[OBJ_Informacion_manual alloc]init:@"Get the farther away of the center of a building. The closer to the interior compared to the outer perimeter the more greater the probablity of your espace route getting blocked." imagen:@"Manual_06" titulo:@"Center of Building"];
    [objetos addObject:objeto6];
    OBJ_Informacion_manual * objeto7 = [[OBJ_Informacion_manual alloc]init:@"Move outside of the car and sit or lay at its side, the crushed car will create a void of around 3 feet high next to them." imagen:@"Manual_08" titulo:@"Car"];
    [objetos addObject:objeto7];
    OBJ_Informacion_manual * objeto8 = [[OBJ_Informacion_manual alloc]init:@"Stacks of paper won't compact and create large voids." imagen:@"Manual_07" titulo:@"Stack of Paper"];
    [objetos addObject:objeto8];
}



- (IBAction)action_siguiente:(id)sender {
    seleccion ++;
    if (seleccion > 7) {
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
        seleccion = 7;
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

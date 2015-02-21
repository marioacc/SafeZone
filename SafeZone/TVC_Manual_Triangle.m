//
//  TVC_Manual_Triangle.m
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "TVC_Manual_Triangle.h"
#import "VC_Manual_Triangle_Detalle.h"

@interface TVC_Manual_Triangle ()

@end

@implementation TVC_Manual_Triangle

- (void)viewDidLoad {
    [super viewDidLoad];
    label_1.layer.masksToBounds = true;
    label_1.layer.cornerRadius = 12;
    label_2.layer.masksToBounds = true;
    label_2.layer.cornerRadius = 12;
    label_3.layer.masksToBounds = true;
    label_3.layer.cornerRadius = 12;
    label_4.layer.masksToBounds = true;
    label_4.layer.cornerRadius = 12;
    label_5.layer.masksToBounds = true;
    label_5.layer.cornerRadius = 12;
    label_6.layer.masksToBounds = true;
    label_6.layer.cornerRadius = 12;
    label_7.layer.masksToBounds = true;
    label_7.layer.cornerRadius = 12;
    label_8.layer.masksToBounds = true;
    label_8.layer.cornerRadius = 12;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VC_Manual_Triangle_Detalle *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Manual_Triangle_Detalle"];
    vc.seleccion = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //UIImage *pattern = [UIImage imageNamed:@"Barra_tabla.jpg"];
    //[cell setBackgroundColor:[UIColor colorWithPatternImage:pattern]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

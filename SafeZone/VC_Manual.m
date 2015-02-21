//
//  VC_Manual.m
//  SafeZone
//
//  Created by Jesus Ruiz on 2/19/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VC_Manual.h"
#import "VC_Manual_General.h"

@interface VC_Manual ()

@end

@implementation VC_Manual

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    VC_Manual_General *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VC_Manual_General"];
    vc.seleccion = 0;
}



@end

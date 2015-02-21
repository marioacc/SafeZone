//
//  VC_Alert_Coor.m
//  SafeZone
//
//  Created by moviles on 2/20/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VC_Alert_Coor.h"

@interface VC_Alert_Coor ()
#define METERS_PER_MILE 1609.344
@end

@implementation VC_Alert_Coor
@synthesize latitude;
@synthesize longitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLLocationCoordinate2D  ctrpoint;
    //    ctrpoint.latitude = [latitude doubleValue];
    //    ctrpoint.longitude =[longitude doubleValue];
    
    ctrpoint.latitude =[latitude doubleValue];
    ctrpoint.longitude =[longitude doubleValue];
    
    
    MKPointAnnotation *annotation=[[MKPointAnnotation alloc] init];
    annotation.coordinate=ctrpoint;
    annotation.title=@"S.O.S.";
    annotation.subtitle=@"Here are someone that needs help!";
    [ self.mapView addAnnotation:annotation];
}

-(void) viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [latitude doubleValue];;
    zoomLocation.longitude= [longitude doubleValue];
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [ self.mapView setRegion:viewRegion animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *) convertHexToDecimalString:(NSString *) hexString{
    unsigned int outVal;
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&outVal];
    return [NSString stringWithFormat:@"%u",outVal];
}


-(NSString *) convertDecimalToHexString:(NSString *)decimalString{
    NSString *hexString = [NSString stringWithFormat:@"0x%lX",
                           (unsigned long)[decimalString integerValue]];
    return hexString;
    
}



@end

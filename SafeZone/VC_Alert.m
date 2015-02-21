//
//  VC_Alert.m
//  SafeZone
//
//  Created by moviles on 2/20/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VC_Alert.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface VC_Alert ()

@end

@implementation VC_Alert

- (void)viewDidLoad {
    [super viewDidLoad];
    fondo_numeros.layer.masksToBounds = true;
    fondo_numeros.layer.cornerRadius = 20;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendLocation:(id)sender {
    [self startLocationManager];
    myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Alert"
                                  message:@"Would you like to send your location?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self startLocationManager];
                             myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/*
 LOCALIZATION METHODS
 */
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        longitudeLabel.text=longitude;
        latitudeLabel.text= latitude;
    }
    [locationManager stopUpdatingLocation];
}

-(void) startLocationManager{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

/*
 BLUETOOTH LOW ENERGY PERIPHERAL METHODS
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
    
    
    if (error) {
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    }
}

-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    if(peripheral.state == CBPeripheralManagerStatePoweredOn ) {
        NSLog(@"Iniciando Periferico");
        [self startPeripheralManager];
    }
    else {
        NSLog(@"Lo sentimos, el telefono no soporta esta tecnologia.");
    }
    
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
    NSLog(@"CORRECT ADVERTISING");
    if (error) {
        NSLog(@"Error advertising: %@", [error localizedDescription]);
    }
}

-(void) peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    if ([request.characteristic.UUID isEqual:latitudeCharacteristic.UUID]) {
        if (request.offset > latitudeCharacteristic.value.length) {
            [myPeripheralManager respondToRequest:request withResult:CBATTErrorInvalidOffset];
            return;
        }
        
        request.value = [latitudeCharacteristic.value subdataWithRange:NSMakeRange(request.offset,latitudeCharacteristic.value.length - request.offset)];
        [myPeripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }
}

-(void) startPeripheralManager{
    CBUUID *latitudeUUID =
    [CBUUID UUIDWithString:@"1252"];
    
    CBUUID *longitudeUUID =
    [CBUUID UUIDWithString:@"3452"];
    
    CBUUID *locationUUID =
    [CBUUID UUIDWithString:@"1234"];
    
    latitudeCharacteristic = [[CBMutableCharacteristic alloc] initWithType:latitudeUUID
                                                                properties:CBCharacteristicPropertyRead
                                                                     value:[latitude dataUsingEncoding:NSUTF8StringEncoding ] permissions:CBAttributePermissionsReadable];
    longitudeCharacteristic = [[CBMutableCharacteristic alloc] initWithType:longitudeUUID
                                                                 properties:CBCharacteristicPropertyRead
                                                                      value:[longitude dataUsingEncoding:NSUTF8StringEncoding] permissions:CBAttributePermissionsReadable];
    locationService = [[CBMutableService alloc] initWithType:locationUUID primary:YES];
    
    locationService.characteristics = @[latitudeCharacteristic, longitudeCharacteristic];
    [myPeripheralManager addService:locationService];
    [myPeripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey :
                                                 @[locationService.UUID] }];
}

@end

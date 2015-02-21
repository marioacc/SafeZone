//
//  VC_Alert.h
//  SafeZone
//
//  Created by moviles on 2/20/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface VC_Alert : UIViewController <CLLocationManagerDelegate, CBPeripheralManagerDelegate>{
    CBPeripheralManager *myPeripheralManager;
    
    CBUUID *myCustomServiceUUID;
    CLLocationManager *locationManager;
    CBMutableCharacteristic *latitudeCharacteristic;
    CBMutableCharacteristic *longitudeCharacteristic;
    CBMutableService *locationService;
    
    NSString *latitude;
    NSString *longitude;
    
    __weak IBOutlet UILabel *latitudeLabel;
    __weak IBOutlet UILabel *longitudeLabel;
    __weak IBOutlet UILabel *fondo_numeros;
}

- (IBAction)sendLocation:(id)sender;
-(void) startLocationManager;

@end

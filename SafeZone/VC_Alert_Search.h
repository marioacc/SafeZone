//
//  VC_Alert_Search.h
//  SafeZone
//
//  Created by moviles on 2/20/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "VC_Alert_Coor.h"

@interface VC_Alert_Search : UIViewController  <CBCentralManagerDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSArray *services;
    NSMutableArray *devices;
    NSArray *characteristics;
    CBCentralManager *myCentralManager;
    NSMutableDictionary *vendingMachines;
    VC_Alert_Coor * vc;
    __weak IBOutlet UITableView *tableView;
}

@property (strong, nonatomic) CBPeripheral *peripheral;

//Services
@property (strong, nonatomic) NSString *discoveredService;
@property (strong, nonatomic) NSString *discoveredCharacteristics;

//Charactersitics
@property (strong, nonatomic) CBCharacteristic *latitudeCharacteristic;
@property (strong, nonatomic) CBCharacteristic *longitudeCharacteristic;

//Values
@property (strong, nonatomic) NSString *longitudeValue;
@property (strong, nonatomic) NSString *latitudeValue;

@end

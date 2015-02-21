//
//  VC_Alert_Search.m
//  SafeZone
//
//  Created by moviles on 2/20/15.
//  Copyright (c) 2015 Group_4. All rights reserved.
//

#import "VC_Alert_Search.h"
#import "VC_Alert_Coor.h"

@interface VC_Alert_Search ()

@end

@implementation VC_Alert_Search

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    devices = [NSMutableArray arrayWithObjects: nil];
    
    /*Cacracteristicas para el modulo bluetooth*/
    //    services = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"8b8f8d60-6b64-11e4-a552-0002a5d5c51b"], nil];
    //    characteristics = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"c77fca60-6b64-11e4-a9b1-0002a5d5c51b"],[CBUUID UUIDWithString:@"32742960-6b65-11e4-a8ca-0002a5d5c51b"], nil];
    
    vendingMachines = [NSMutableDictionary dictionary];
    
    /*Caracteristicas de prueba con el IPAD*/
    services = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"1234"], nil];
    characteristics = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"1252"],[CBUUID UUIDWithString:@"3452"] , nil];
    
    myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"coordinates"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    vendingMachines = [NSMutableDictionary dictionary];
    
    /*Caracteristicas de prueba con el IPAD*/
    services = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"1234"], nil];
    characteristics = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"1252"],[CBUUID UUIDWithString:@"3452"] , nil];
    
    myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

-(void) centralManagerDidUpdateState:(CBCentralManager *)central {
    
    if(central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"Buscando Vending Machines");
        //testText.text = [NSString stringWithFormat:@"Buscando Vending Machines"];
        [myCentralManager scanForPeripheralsWithServices:services options:nil];
    }
    else {
        NSLog(@"Lo sentimos, el telefono no soporta esta tecnologia.");
        //testText.text = [NSString stringWithFormat:@"Lo sentimos, el telefono no soporta esta tecnologia."];
    }
}

-(void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"%@",peripheral.name);
    if(peripheral.name != nil) {
        
        if(![devices containsObject:peripheral.name]) {
            //[myCentralManager connectPeripheral:peripheral options:nil];
            [vendingMachines setObject:peripheral forKey:peripheral.name];
            [devices addObject:[NSString stringWithFormat:@"%@",peripheral.name]];
            [tableView reloadData];
        }
    }
}

-(void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connected to %@", peripheral.name);
    NSLog(@"Conectado a la Vending 1");
    //testText.text = [NSString stringWithFormat:@"Conectado a la Vending 1"];
    [myCentralManager stopScan];
    NSLog(@"Stopped scan");
    [peripheral discoverServices:services];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for(CBService *service in peripheral.services) {
        NSLog(@"Discovered service %@", service.UUID);
        self.discoveredService = [NSString stringWithFormat:@"%@",service.UUID];
        [peripheral discoverCharacteristics:characteristics forService:service];
    }
    
}


-(void) peripheral:(CBPeripheral *) peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    for(CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", characteristic.UUID);
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"1252"]]){
            self.latitudeCharacteristic=characteristic;
        } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"3452"]]){
            self.longitudeCharacteristic=characteristic;
        }
        self.discoveredCharacteristics = [NSString stringWithFormat:@"%@",characteristic.value];
        [peripheral readValueForCharacteristic:characteristic];
    }
    //coordenatesVC *coordenatesVc=[[coordenatesVC alloc] initWithNibName:@"coordenatesVC" bundle:nil];
    //coordenatesVC.longitude=self.longitudeValue;
    //coordenatesVC.=self.latitudeValue;
    NSString * lol = self.latitudeValue;
    NSString * lel = self.longitudeValue;
    
    //    vc.latitude = self.latitudeValue;
    //    vc.longitude = self.longitudeValue;
    //    //[self.navigationController pushViewController:vc animated:YES];
    
}

-(void) peripheral:(CBPeripheral *) peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    value = [value stringByReplacingOccurrencesOfString:@"<" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@">" withString:@""];
    if ([characteristic isEqual:self.latitudeCharacteristic]) {
        vc.latitude=value;
    }else if ([characteristic isEqual:self.longitudeCharacteristic]){
        vc.longitude=value;
    }
    NSLog(@" Valor de la caracteristica:%@", value);
    
    if (!vc.latitude == nil && characteristic.value !=nil) {
        if (!vc.longitude == nil && characteristic.value !=nil) {
            //[self presentViewController:vc animated:NO completion:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [devices count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *peripheralName=cell.textLabel.text;
    if (peripheralName != nil) {
        self.peripheral=[vendingMachines objectForKey:peripheralName];
        [myCentralManager connectPeripheral:self.peripheral options:nil];
        self.peripheral.delegate=self;
    }
    
    else if (peripheralName != self.peripheral.name && self.peripheral.name != nil) {
        CBPeripheral *newVending=[vendingMachines objectForKey:peripheralName];
        [myCentralManager cancelPeripheralConnection:self.peripheral];
        [myCentralManager connectPeripheral:newVending options:nil];
    }
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [devices objectAtIndex:indexPath.row];
    return cell;
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error localizedDescription]);
    }
    else {
        NSLog(@"Success!");
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"infovc"])
    {
        // Get reference to the destination view controller
        
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

//
//  ViewController.m
//  BatteryInfo
//
//  Created by KAGE on 16-7-7.
//  Copyright (c) 2016年 NB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UITextView *tvBatteryInfo;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSMutableString* strAllInfo = [NSMutableString string];

    do
    {
        [strAllInfo appendString:@"\n\n\nHello KAGE ~"];

        CFTypeRef blob = IOPSCopyPowerSourcesInfo();
        CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
        if (CFArrayGetCount(sources) == 0)
        {
            NSLog(@"Get nothing...");
            [strAllInfo appendString:@"\n\n--------------------------------------------------"];
            [strAllInfo appendString:@"\nFailed to get PowerSourcesInfo."];
            break;	// Could not retrieve battery information.  System may not have a battery.
        }

        NSDictionary* dictLimitedBatteryInfo = ((NSDictionary*)((NSArray*)CFBridgingRelease(blob))[0]);
        NSLog(@"IOPSCopyPowerSourcesInfo=%@", dictLimitedBatteryInfo);
        [strAllInfo appendString:@"\n\n--------------------------------------------------"];
        //[strAllInfo appendString:@"IOPSCopyPowerSourcesInfo Data\n\n"];
        [strAllInfo appendString:@"\n"];

        for (NSString* strKey in [dictLimitedBatteryInfo allKeys])
        {
            if ([strKey isEqual:@"BatteryHealth"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"电池健康状况 : %@", [dictLimitedBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"Is Charging"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"正在充电 : %@", [dictLimitedBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"Is Finishing Charge"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"已充满电 : %@", [dictLimitedBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"Power Source State"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"当前电源 : %@", [dictLimitedBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"Current Capacity"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"当前电量百分比 : %@%%", [dictLimitedBatteryInfo valueForKey:strKey]]];
            }
            else
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"%@ : %@", strKey, [dictLimitedBatteryInfo valueForKey:strKey]]];
            }
            [strAllInfo appendString:@"\n"];
        }


        io_service_t powerSource = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPMPowerSource"));
        CFMutableDictionaryRef batteryProperties = NULL;
        IORegistryEntryCreateCFProperties(powerSource, &batteryProperties, NULL, 0);
        NSDictionary* dictExtensiveBatteryInfo = (__bridge_transfer NSDictionary*)batteryProperties;

        //Credit: https://github.com/jBot-42/JSystemInfoKit/blob/3d8a98d7d1b2a1bff4ff09716d9365e2e8948905/SystemInfoKit/JSKSystemMonitor.m#L346
        NSLog(@"IOPMPowerSource=%@", dictExtensiveBatteryInfo);
        [strAllInfo appendString:@"\n\n--------------------------------------------------"];
        //[strAllInfo appendString:@"\nIOPMPowerSource Data\n\n"];
        [strAllInfo appendString:@"\n"];

        for (NSString* strKey in [dictExtensiveBatteryInfo allKeys])
        {
            if ([strKey isEqual:@"AbsoluteCapacity"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"绝对容量 : %@", [dictExtensiveBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"CurrentCapacity"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"当前容量 : %@", [dictExtensiveBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"CycleCount"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"循环次数 : %@", [dictExtensiveBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"DesignCapacity"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"设计容量 : %@", [dictExtensiveBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"MaxCapacity"])
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"最大容量 : %@", [dictExtensiveBatteryInfo valueForKey:strKey]]];
            }
            else if ([strKey isEqual:@"UpdateTime"])
            {
                NSString* strTime = [self timeFormat:[dictExtensiveBatteryInfo valueForKey:strKey]];
                [strAllInfo appendString:[NSString stringWithFormat:@"数据更新时间 : %@", strTime]];
            }
            else
            {
                [strAllInfo appendString:[NSString stringWithFormat:@"%@ : %@", strKey, [dictExtensiveBatteryInfo valueForKey:strKey]]];
            }
            [strAllInfo appendString:@"\n"];
        }
    } while (0);


    self.tvBatteryInfo = [[UITextView alloc] initWithFrame:self.view.frame];
    [self.tvBatteryInfo setEditable:NO];

    [self.view addSubview:self.tvBatteryInfo];

    self.tvBatteryInfo.text = strAllInfo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)timeFormat:(NSString*)strTimeInterval
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[strTimeInterval integerValue]];
    NSString* strTime = [formatter stringFromDate:date];

    return strTime;
}

@end

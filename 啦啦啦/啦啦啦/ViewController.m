//
//  ViewController.m
//  啦啦啦
//
//  Created by 彭盛凇 on 2017/9/6.
//  Copyright © 2017年 huangbaoche. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+QT.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *string = @"352132112313213213211213213213213211231321321321133221232131212123112131321232312132311123231213213231312231123213231213213123213213213213213";
    
    _label.text = string;
    
    [_label setLineBreakByTruncatingLastLineMiddle];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

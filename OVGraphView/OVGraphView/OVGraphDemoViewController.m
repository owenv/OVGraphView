//
//  OVGraphDemoViewController.m
//  OVGraphView
//
//  Created by Owen Voorhees on 8/8/12.
//  Copyright (c) 2012 Owen Voorhees. All rights reserved.
//

#import "OVGraphDemoViewController.h"

@interface OVGraphDemoViewController ()

@end

@implementation OVGraphDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    OVGraphView *graphview=[[OVGraphView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 300) ContentSize:CGSizeMake(960, 300)];
    graphview.reverse=YES;
    graphview.graphcolor=[UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];
    [self.view addSubview:graphview];
    [graphview setPoints:@[ [[OVGraphViewPoint alloc]initWithXLabel:@"today" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"yesterday" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],[[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@1 ],[[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@10 ],[[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@7 ],[[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@2.4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@3 ],[[OVGraphViewPoint alloc]initWithXLabel:@"10" YValue:@5.5 ],[[OVGraphViewPoint alloc]initWithXLabel:@"11" YValue:@3 ],[[OVGraphViewPoint alloc]initWithXLabel:@"12" YValue:@7 ],[[OVGraphViewPoint alloc]initWithXLabel:@"13" YValue:@9 ],[[OVGraphViewPoint alloc]initWithXLabel:@"14" YValue:@8 ]]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft | interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end

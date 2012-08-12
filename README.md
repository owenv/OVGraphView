OVGraphView
===========

An Objective-C class that makes it easy to display data as a line graph on iOS


Usage
===========

The following steps will create a basic instance of OVGraphView:
1. Add all the files from the OVGraphView group in the Xcode project.

2. Import OVGraphView.h and OVGraphViewPoint.h

3. Use the following code to create the instance and add it to the view hierarchy
 OVGraphView *graphview=[[OVGraphView alloc]initWithFrame:CGRectMake(0, 0, 480, 300) ContentSize:CGSizeMake(960, 300)];
[self.view addSubview:graphview];
[graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"today" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"yesterday" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],[[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@1 ],[[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@10 ],[[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@7 ],[[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@2.4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@3 ],[[OVGraphViewPoint alloc]initWithXLabel:@"10" YValue:@5.5 ],[[OVGraphViewPoint alloc]initWithXLabel:@"11" YValue:@3 ],[[OVGraphViewPoint alloc]initWithXLabel:@"12" YValue:@7 ],[[OVGraphViewPoint alloc]initWithXLabel:@"13" YValue:@9 ],[[OVGraphViewPoint alloc]initWithXLabel:@"14" YValue:@8 ]]];


Customizations
================

graphview.reverse=YES; //reverse the item order and automatically scroll to the right.


License
=========
There is no License at this time but I would appreciate attribution such as "OVGraphView component was created by Owen Voorhees" somewhere within the application.
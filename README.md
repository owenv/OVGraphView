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

[graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"today" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"yesterday" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ]]];


Customizations
================

graphview.reverse=YES; //reverse the item order and automatically scroll to the right.


License
=========
There is no License at this time but I would appreciate attribution such as "OVGraphView component was created by Owen Voorhees" somewhere within the application.
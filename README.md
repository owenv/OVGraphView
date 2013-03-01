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
		 
		 //customizations go here
		 
		[self.view addSubview:graphview];

		[graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"today" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"yesterday" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ]]];


Customizations
================

		graphview.plotContainer.reverse=YES; //reverse the item order and automatically scroll to the right.

		graphview.plotContainer.graphcolor=[UIColor ...];//set the color of the graph

License
=========
This code is distributed under the terms and conditions of the MIT license.

Copyright (c) 2012 Owen Voorhees

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
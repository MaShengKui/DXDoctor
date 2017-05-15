//
//  DXMapListController.m
//  DXDoctor
//
//  Created by Mask on 15/10/8.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXMapListController.h"

@interface DXMapListController ()

@end

@implementation DXMapListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MapListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    DXMapListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@   %d米", model.address, model.distance];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DXMapListModel *model = self.dataArray [indexPath.row];
    [self.view removeFromSuperview];
  //  [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%f---->%f",model.latitude, model.longitude);
}

@end

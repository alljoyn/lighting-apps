/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 ******************************************************************************/

#import "ViewController.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKLightingController.h"
#import "LSFSDKLightingControllerConfigurationBase.h"
#import "LSFSDKAllLightingItemDelegateBase.h"
#import "LSFSDKScene.h"

/*
 * Global delegate that updates the table using the Scene Initialized and
 * Scene Removed callbacks.
 */
@interface MyLightingDelegate : LSFSDKAllLightingItemDelegateBase

@property (nonatomic, strong) NSMutableArray *localSceneList;
@property (nonatomic, strong) UITableView *localTableView;

@end

@implementation MyLightingDelegate

@synthesize localSceneList = _localSceneList;
@synthesize localTableView = _localTableView;

-(id)initWithSceneList: (NSMutableArray *)sceneList andTableView: (UITableView *)tableView
{
    self = [super init];

    if (self)
    {
        self.localSceneList = sceneList;
        self.localTableView = tableView;
    }

    return self;
}

-(void)onSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andScene: (LSFSDKScene *) scene
{
    //Update UI when Scene is initialized
    [self.localSceneList addObject: scene];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.localTableView reloadData];
    });
}

-(void)onSceneRemoved: (LSFSDKScene *)scene
{
    //Update UI when Scene is removed
    [self.localSceneList removeObject: scene];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.localTableView reloadData];
    });
}

-(void)onSceneChanged: (LSFSDKScene *)scene
{
    //Update UI when Scene is changed
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.localTableView reloadData];
    });
}
@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *sceneList;
@property (nonatomic, strong) LSFSDKLightingDirector *lightingDirector;
@property (nonatomic, strong) MyLightingDelegate *myLightingDelegate;
@property (nonatomic, strong) LSFSDKLightingControllerConfigurationBase *config;

@end

@implementation ViewController

@synthesize sceneList = _sceneList;
@synthesize lightingDirector = _lightingDirector;
@synthesize myLightingDelegate = _myLightingDelegate;
@synthesize config = _config;

-(void)viewDidLoad
{
    [super viewDidLoad];

    // STEP 1: Create array used by UITableView
    self.sceneList = [[NSMutableArray alloc] init];

    // STEP 2: Initialize a lighting controller with default configuration
    self.config = [[LSFSDKLightingControllerConfigurationBase alloc]initWithKeystorePath: @"Documents"];
    LSFSDKLightingController *lightingController = [LSFSDKLightingController getLightingController];
    [lightingController initializeWithControllerConfiguration: self.config];
    [lightingController start];

    // STEP 3: Instantiate the lighting director, add custom delegate, and start
    self.myLightingDelegate = [[MyLightingDelegate alloc] initWithSceneList: self.sceneList andTableView: self.tableView];
    self.lightingDirector = [LSFSDKLightingDirector getLightingDirector];
    [self.lightingDirector addDelegate: self.myLightingDelegate];
    [self.lightingDirector start];

}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return [self.sceneList count];
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }

    LSFSDKScene * scene = (LSFSDKScene *)[self.sceneList objectAtIndex: indexPath.row];
    cell.textLabel.text = scene.name;

    return cell;
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    // Apply the Scene
    LSFSDKScene * scene = (LSFSDKScene *)[self.sceneList objectAtIndex: indexPath.row];
    [scene apply];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
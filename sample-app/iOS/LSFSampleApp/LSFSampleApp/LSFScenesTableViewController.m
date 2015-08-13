/******************************************************************************
 * Copyright (c) AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFScenesTableViewController.h"
#import "LSFSceneElementV2InfoTableViewController.h"
#import "scenesV1/LSFSceneInfoTableViewController.h"
#import "scenesV1/LSFScenesEnterNameViewController.h"
#import "scenesV1/LSFScenesV1Util.h"
#import "LSFSceneV2InfoTableViewController.h"
#import "LSFMasterScenesEnterNameViewController.h"
#import "LSFMasterScenesInfoTableViewController.h"
#import "LSFItemNameViewController.h"
#import "LSFSceneCell.h"
#import "LSFWifiMonitor.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFScenesTableViewController ()

@property (nonatomic, strong) UIBarButtonItem *myEditButton;
@property (nonatomic, strong) UIBarButtonItem *settingsButton;
@property (nonatomic, strong) UIBarButtonItem *addButton;

-(void)sceneChangedNotificationReceived: (NSNotification *)notification;
-(void)sceneRemovedNotificationReceived: (NSNotification *)notification;
-(void)masterSceneChangedNotificationReceived: (NSNotification *)notification;
-(void)masterSceneRemovedNotificationReceived: (NSNotification *)notification;
-(void)plusButtonPressed;
-(void)settingsButtonPressed;
-(void)appendSceneNames: (NSArray *)sceneIDs toString: (NSMutableString *)detailsString;
-(NSArray *)sortScenesByName: (NSArray *)scenes;
-(void)addObjectToTableAtIndex: (NSUInteger)insertIndex;
-(void)moveObjectFromIndex: (NSUInteger)fromIndex toIndex: (NSUInteger)toIndex;
-(void)refreshRowInTableAtIndex: (NSUInteger)index;
-(void)deleteRowsInTableAtIndex: (NSArray *)cellIndexPaths;
-(NSArray *)isSceneContainedInMasterScenes: (NSString *)sceneID;

@end

@implementation LSFScenesTableViewController

@synthesize myEditButton = _myEditButton;
@synthesize settingsButton = _settingsButton;
@synthesize addButton = _addButton;

const int SCENE_ELEMENT_ACTION_INDEX = 0;
const int SCENE_ACTION_INDEX = 1;
const int MASTER_SCENE_ACTION_INDEX = 2;

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];

    self.addButton = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                      target: self
                      action: @selector(plusButtonPressed)];

    self.settingsButton = [[UIBarButtonItem alloc]
                           initWithImage: [UIImage imageNamed: @"nav_settings_regular_icon.png"]
                           style:UIBarButtonItemStylePlain
                           target: self
                           action: @selector(settingsButtonPressed)];

    NSArray *actionButtonItems = @[self.settingsButton, self.addButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    self.data = [[NSMutableArray alloc] init];

    //Set scenes and master scenes notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneElementChangedNotificationReceived:) name: @"LSFSceneElementChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneElementRemovedNotificationReceived:) name: @"LSFSceneElementRemovedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneChangedNotificationReceived:) name: @"LSFSceneChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneRemovedNotificationReceived:) name: @"LSFSceneRemovedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(masterSceneChangedNotificationReceived:) name: @"LSFMasterSceneChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(masterSceneRemovedNotificationReceived:) name: @"LSFMasterSceneRemovedNotification" object: nil];

    //Set the content of the default scene data array
    NSMutableArray *scenesArray = [[NSMutableArray alloc] init];
    for (LSFSDKScene *scene in [[LSFSDKLightingDirector getLightingDirector] scenes])
    {
        [scenesArray addObject: scene];
    }

    NSArray *masterScenes = [self sortScenesByName: [[LSFSDKLightingDirector getLightingDirector] masterScenes]];
    NSArray *sceneElements = [self sortScenesByName: [[LSFSDKLightingDirector getLightingDirector] sceneElements]];

    [self.data addObjectsFromArray: masterScenes];
    [self.data addObjectsFromArray: scenesArray];
    [self.data addObjectsFromArray: sceneElements];

    // display all scenes items sorted by name not type
    self.data = [NSMutableArray arrayWithArray: [self sortScenesByName: self.data]];

    [self.tableView reloadData];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear scenes and master scenes notification handler
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Notification Handlers
 */
-(void)sceneElementChangedNotificationReceived: (NSNotification *)notification
{
    @synchronized(self.data)
    {
        if ([[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
        {
            LSFSDKSceneElement *sceneElement = [notification.userInfo valueForKey: @"sceneElement"];
            [self updateSceneElement: sceneElement];
        }
    }
}

-(void)sceneElementRemovedNotificationReceived: (NSNotification *)notification
{
    @synchronized(self.data)
    {
        if ([[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
        {
            LSFSDKSceneElement *sceneElement = [notification.userInfo valueForKey: @"sceneElement"];
            [self removeSceneElement: sceneElement];
        }
    }
}

-(void)sceneChangedNotificationReceived: (NSNotification *)notification
{
    @synchronized(self.data)
    {
        if ([[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
        {
            LSFSDKScene *scene = [notification.userInfo valueForKey: @"scene"];
            [self updateScene: scene];
        }
    }
}

-(void)sceneRemovedNotificationReceived: (NSNotification *)notification
{
    @synchronized(self.data)
    {
        if ([[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
        {
            LSFSDKScene *scene = [notification.userInfo valueForKey: @"scene"];
            [self removeScene: scene];
        }
    }
}

-(void)masterSceneChangedNotificationReceived: (NSNotification *)notification
{
    @synchronized(self.data)
    {
        if ([[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
        {
            LSFSDKMasterScene *masterScene = [notification.userInfo valueForKey: @"masterScene"];
            [self updateMasterScene: masterScene];
        }
    }
}

-(void)masterSceneRemovedNotificationReceived: (NSNotification *)notification
{
    @synchronized(self.data)
    {
        if ([[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
        {
            LSFSDKMasterScene *masterScene = [notification.userInfo valueForKey: @"masterScene"];
            [self removeMasterScene: masterScene];
        }
    }
}

-(void)updateSceneElement: (LSFSDKSceneElement *)sceneElement
{
    int existingIndex = [self findIndexInUIForID: sceneElement.theID];
    int insertionIndex = (int) [self findInsertionIndexInArray: sceneElement];

    if (existingIndex == -1)
    {
        // new scene element
        [self.data insertObject: sceneElement atIndex: insertionIndex];
        [self addObjectToTableAtIndex: insertionIndex];
    }
    else
    {
        if (existingIndex == insertionIndex)
        {
            // refresh sceneElement
            [self refreshRowInTableAtIndex: existingIndex];
        }
        else
        {
            // reorder sceneElement
            if (existingIndex < insertionIndex)
            {
                insertionIndex--;
            }

            [self.data removeObjectAtIndex: existingIndex];
            [self.data insertObject: sceneElement atIndex: insertionIndex];

            [self moveObjectFromIndex: existingIndex toIndex: insertionIndex];
        }
    }
}

-(void)removeSceneElement: (LSFSDKSceneElement *)sceneElement
{
    NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];

    int sceneElementArrayIndex = [self findIndexInUIForID: sceneElement.theID];
    if (sceneElementArrayIndex != -1)
    {
        [self.data removeObjectAtIndex: sceneElementArrayIndex];
        [deleteIndexPaths addObject: [NSIndexPath indexPathForRow: sceneElementArrayIndex inSection:0]];
    }

    [self deleteRowsInTableAtIndex: deleteIndexPaths];
}

-(void)updateScene: (LSFSDKScene *)scene
{
    int existingIndex = [self findIndexInUIForID: scene.theID];
    int insertionIndex = (int) [self findInsertionIndexInArray: scene];

    if (existingIndex == -1)
    {
        // new scene
        [self.data insertObject: scene atIndex: insertionIndex];
        [self addObjectToTableAtIndex: insertionIndex];
    }
    else
    {
        if (existingIndex == insertionIndex)
        {
            // refresh scene
            [self refreshRowInTableAtIndex: existingIndex];
        }
        else
        {
            // reorder scene
            if (existingIndex < insertionIndex)
            {
                insertionIndex--;
            }

            [self.data removeObjectAtIndex: existingIndex];
            [self.data insertObject: scene atIndex: insertionIndex];

            [self moveObjectFromIndex: existingIndex toIndex: insertionIndex];
        }
    }
}

-(void)removeScene: (LSFSDKScene *)scene
{
    NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];

    int sceneArrayIndex = [self findIndexInUIForID: scene.theID];
    if (sceneArrayIndex != -1)
    {
        [self.data removeObjectAtIndex: sceneArrayIndex];
        [deleteIndexPaths addObject: [NSIndexPath indexPathForRow: sceneArrayIndex inSection:0]];
    }

    [self deleteRowsInTableAtIndex: deleteIndexPaths];
}

-(void)updateMasterScene: (LSFSDKMasterScene *)masterScene
{
    int existingIndex = [self findIndexInUIForID: masterScene.theID];
    int insertionIndex = (int) [self findInsertionIndexInArray: masterScene];

    if (existingIndex == -1)
    {
        // new master scene
        [self.data insertObject: masterScene atIndex: insertionIndex];
        [self addObjectToTableAtIndex: insertionIndex];
    }
    else
    {
        if (existingIndex == insertionIndex)
        {
            // refresh master scene
            [self refreshRowInTableAtIndex: existingIndex];
        }
        else
        {
            // reorder scene
            if (existingIndex < insertionIndex)
            {
                insertionIndex--;
            }

            [self.data removeObjectAtIndex: existingIndex];
            [self.data insertObject: masterScene atIndex: insertionIndex];

            [self moveObjectFromIndex: existingIndex toIndex: insertionIndex];
        }
    }
}

-(void) removeMasterScene: (LSFSDKMasterScene *)masterScene
{
    NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];

    int masterSceneArrayIndex = [self findIndexInUIForID: masterScene.theID];
    if (masterSceneArrayIndex != -1)
    {
        [self.data removeObjectAtIndex: masterSceneArrayIndex];
        [deleteIndexPaths addObject: [NSIndexPath indexPathForRow: masterSceneArrayIndex inSection:0]];
    }
}

/*
 * UITableViewDataSource Implementation
 */
-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    id scene = [self.data objectAtIndex: [indexPath row]];

    LSFSceneCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SceneCell" forIndexPath: indexPath];

    if ([scene isKindOfClass: [LSFSDKScene class]])
    {
        LSFSDKScene *basicScene = (LSFSDKScene *)scene;

        cell.sceneType = Basic;
        cell.sceneID = basicScene.theID;
        cell.sceneImageView.image = [UIImage imageNamed: @"scene_set_icon.png"];
        cell.nameLabel.text = basicScene.name;
        cell.accessoryType = UITableViewCellAccessoryDetailButton;

        if ([basicScene isKindOfClass: [LSFSDKSceneV1 class]])
        {
#ifdef LSF_SCENES_V1_MODULE
            cell.detailsLabel.text = [LSFScenesV1Util buildSceneDetailsString: [((LSFSDKSceneV1 *)scene) getSceneDataModel]];
#else
            cell.accessoryType = UITableViewCellAccessoryNone;
#endif
        }
        else if ([basicScene isKindOfClass: [LSFSDKSceneV2 class]])
        {
            cell.detailsLabel.text = [self buildSceneV2DetailsString: (LSFSDKSceneV2 *)scene];
        }
    }
    else if ([scene isKindOfClass: [LSFSDKMasterScene class]])
    {
        LSFSDKMasterScene *masterScene = (LSFSDKMasterScene *)scene;

        cell.sceneType = Master;
        cell.masterSceneID = masterScene.theID;
        cell.sceneImageView.image = [UIImage imageNamed: @"master_scene_set_icon.png"];
        cell.nameLabel.text = masterScene.name;
        cell.detailsLabel.text = [self buildMasterSceneDetailsString: masterScene];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    else if ([scene isKindOfClass: [LSFSDKSceneElement class]])
    {
        LSFSDKSceneElement *element = (LSFSDKSceneElement *)scene;
        cell.sceneType = Element;
        cell.sceneID = element.theID;
        cell.sceneImageView.image = [UIImage imageNamed: @"scene_element_set_icon.png"];
        cell.nameLabel.text = element.name;
        cell.detailsLabel.text = [self buildSceneElementDetailsString: element];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }

    return cell;
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    id scene = [self.data objectAtIndex: indexPath.row];

    if ([scene isKindOfClass: [LSFSDKScene class]])
    {
        LSFSDKScene *basicScene = (LSFSDKScene *)scene;

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            [basicScene apply];
        });

        [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    }
    else if ([scene isKindOfClass: [LSFSDKMasterScene class]])
    {
        LSFSDKMasterScene *masterScene = (LSFSDKMasterScene *)scene;

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            [masterScene apply];
        });

        [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    }
    else if ([scene isKindOfClass: [LSFSDKSceneElement class]])
    {
        LSFSDKSceneElement *sceneElement = (LSFSDKSceneElement *)scene;

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            [sceneElement apply];
        });

        [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    }
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    LSFWifiMonitor *wifiMonitor = [LSFWifiMonitor getWifiMonitor];

    if (!wifiMonitor.isWifiConnected)
    {
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        UIView *customView = [[UIView alloc] initWithFrame: frame];
        UILabel *messageLabel = [[UILabel alloc] init];
        [customView addSubview: messageLabel];

        frame.origin.x = 30;
        frame.size.width = self.view.bounds.size.width - frame.origin.x;

        messageLabel.frame = frame;
        messageLabel.text = [NSString stringWithFormat: @"No Wi-Fi Connection.\n\nPlease check that Wi-Fi is enabled in this device's settings and that the device is connected to a Wi-Fi network.\n\nWaiting for Wi-Fi to become available..."];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentLeft;

        self.tableView.backgroundView = customView;
        return 0;
    }
    else if (![[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
    {
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        UIView *customView = [[UIView alloc] initWithFrame: frame];
        UILabel *messageLabel = [[UILabel alloc] init];
        [customView addSubview: messageLabel];

        frame.origin.x = 30;
        frame.size.width = self.view.bounds.size.width - frame.origin.x;

        messageLabel.frame = frame;
        messageLabel.text = [NSString stringWithFormat: @"No controller service is available on the network %@.\n\nSearching for controller service...", [LSFUtilityFunctions currentWifiSSID]];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentLeft;

        self.tableView.backgroundView = customView;
        return 0;
    }
    else
    {
        if (self.data.count == 0)
        {
            // Display a message when the table is empty
            UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

            messageLabel.text = @"There are no scenes available.\n\nTo create a scene from the current light settings, tap the + button above.";
            messageLabel.textColor = [UIColor blackColor];
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = NSTextAlignmentCenter;
            [messageLabel sizeToFit];

            self.tableView.backgroundView = messageLabel;
        }
        else
        {
            self.tableView.backgroundView = nil;
        }

        return self.data.count;
    }
}

-(CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000000001f;
}

-(BOOL)tableView: (UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        id scene = [self.data objectAtIndex: indexPath.row];

        if ([scene isKindOfClass: [LSFSDKSceneElement class]])
        {
            LSFSDKSceneElement *sceneElement = (LSFSDKSceneElement *)scene;
            NSArray *names = [self isSceneElementContainedInScene: sceneElement.theID];
            if (names.count > 0)
            {
                NSMutableString *nameString = [[NSMutableString alloc] init];

                for (int i = 0; i < names.count; i++)
                {
                    [nameString appendString: [NSString stringWithFormat: @"\"%@\", ", [names objectAtIndex: i]]];

                    if (i == (names.count - 2))
                    {
                        [nameString appendString: @"and "];
                    }
                }

                [nameString deleteCharactersInRange: NSMakeRange(nameString.length - 2, 2)];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Can't Delete SceneElement"
                                                                message: [NSString stringWithFormat: @"The scene element \"%@\" is being used by the following scenes: %@. It cannot be deleted until it is removed from those scenes, or those scenes are deleted.", sceneElement.name, nameString]
                                                               delegate: nil
                                                      cancelButtonTitle: @"OK"
                                                      otherButtonTitles: nil];
                [alert show];

            }
            else
            {
                int modelArrayIndex = [self findIndexInUIForID: sceneElement.theID];
                [self.data removeObjectAtIndex: modelArrayIndex];

                // Delete the row from the data source
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];

                dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
                    [sceneElement deleteItem];
                });
            }
        }
        else if ([scene isKindOfClass: [LSFSDKScene class]])
        {
            LSFSDKScene *basicScene = (LSFSDKScene *)scene;
            NSArray *names = [self isSceneContainedInMasterScenes: basicScene.theID];
            if (names.count > 0)
            {
                NSMutableString *nameString = [[NSMutableString alloc] init];

                for (int i = 0; i < names.count; i++)
                {
                    [nameString appendString: [NSString stringWithFormat: @"\"%@\", ", [names objectAtIndex: i]]];

                    if (i == (names.count - 2))
                    {
                        [nameString appendString: @"and "];
                    }
                }

                [nameString deleteCharactersInRange: NSMakeRange(nameString.length - 2, 2)];

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Can't Delete Scene"
                                                                message: [NSString stringWithFormat: @"The scene \"%@\" is being used by the following master scenes: %@. It cannot be deleted until it is removed from those master scenes, or those master scenes are deleted.", basicScene.name, nameString]
                                                               delegate: nil
                                                      cancelButtonTitle: @"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                int modelArrayIndex = [self findIndexInUIForID: basicScene.theID];
                [self.data removeObjectAtIndex: modelArrayIndex];

                // Delete the row from the data source
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];

                dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
                    [basicScene deleteItem];
                });
            }
        }
        else if ([scene isKindOfClass: [LSFSDKMasterScene class]])
        {
            LSFSDKMasterScene *masterScene = (LSFSDKMasterScene *)scene;

            int modelArrayIndex = [self findIndexInUIForID: masterScene.theID];
            [self.data removeObjectAtIndex: modelArrayIndex];

            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];

            dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
                [masterScene deleteItem];
            });
        }
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id scene = [self.data objectAtIndex: indexPath.row];

    if ([scene isKindOfClass: [LSFSDKSceneV1 class]])
    {
        [self doSegueToSceneInfo: indexPath];
    }
    else if ([scene isKindOfClass: [LSFSDKSceneV2 class]])
    {
        [self performSegueWithIdentifier: @"SceneV2Info" sender: indexPath];
    }
    else if ([scene isKindOfClass: [LSFSDKMasterScene class]])
    {
        [self performSegueWithIdentifier: @"MasterSceneInfo" sender: indexPath];
    }
    else if ([scene isKindOfClass: [LSFSDKSceneElement class]])
    {
        [self performSegueWithIdentifier: @"SceneElementV2Info" sender: indexPath];
    }
}

/*
 * Segue Method
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"CreateSceneElement"])
    {
        // Do not need to pass any data
    }
#ifdef LSF_SCENES_V1_MODULE
    else if ([segue.identifier isEqualToString: @"CreateScene"])
    {
        [LSFScenesV1Util doSegueCreateSceneV1: segue];
    }
#endif
    else if ([segue.identifier isEqualToString: @"CreateSceneV2"])
    {
        // Do not need to pass any data
    }
    else if ([segue.identifier isEqualToString: @"CreateMasterScene"])
    {
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        LSFMasterScenesEnterNameViewController *msenvc = (LSFMasterScenesEnterNameViewController *)nc.topViewController;
        msenvc.pendingMasterScene = [[LSFPendingScene alloc] init];
    }
    else if ([segue.identifier isEqualToString: @"SceneElementV2Info"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSString *elementID = [[self.data objectAtIndex: [indexPath row]] theID];

        LSFSceneElementV2InfoTableViewController *seitvc = [segue destinationViewController];
        seitvc.pendingSceneElement = [[LSFPendingSceneElement alloc] initFromSceneElementID: elementID];
    }
    else if ([segue.identifier isEqualToString: @"SceneV2Info"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;

        LSFSceneV2InfoTableViewController *sitvc = [segue destinationViewController];
        NSString *sceneID = [[self.data objectAtIndex: [indexPath row]] theID];
        LSFSDKSceneV2 *sceneV2 = [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] sceneCollectionManager] getSceneWithID: sceneID];

        sitvc.pendingScene = [[LSFPendingSceneV2 alloc] init];
        sitvc.pendingScene.theID = sceneV2.theID;
        sitvc.pendingScene.name = sceneV2.name;
        sitvc.pendingScene.membersSceneElements = [NSMutableArray arrayWithArray: [sceneV2 getComponentCollection]];
    }
    else if ([segue.identifier isEqualToString: @"MasterSceneInfo"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;

        LSFMasterScenesInfoTableViewController *msitvc = [segue destinationViewController];
        msitvc.masterSceneID = [NSString stringWithString: ((LSFSDKMasterScene *)[self.data objectAtIndex: [indexPath row]]).theID];
    }
}

/*
 * UIActionSheetDelegate implementation
 */
-(void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [self doCreateSceneSegueAtIndex: (int)buttonIndex];
}

/*
 * Private functions
 */
-(void)plusButtonPressed
{
    LSFWifiMonitor *wifiMonitor = [LSFWifiMonitor getWifiMonitor];

    if (wifiMonitor.isWifiConnected && [[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
    {
        if (NSClassFromString(@"UIAlertController"))
        {
            // In iOS 8 and above UIActionSheet has been deprecated. Thus,
            // attempt to use the newer UIAlertController class on any devices
            // that support it.

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

            void (^handleAlertAction)(UIAlertAction *) =  ^(UIAlertAction *action)
            {
                if([action.title isEqualToString: @"Add Scene Element"])
                {
                    [self doCreateSceneSegueAtIndex: SCENE_ELEMENT_ACTION_INDEX];
                }
                else if([action.title isEqualToString: @"Add Scene"])
                {
                    [self doCreateSceneSegueAtIndex: SCENE_ACTION_INDEX];
                }
                else if([action.title isEqualToString: @"Add Master Scene"])
                {
                    [self doCreateSceneSegueAtIndex: MASTER_SCENE_ACTION_INDEX];
                }

                [alertController dismissViewControllerAnimated:YES completion:nil];
            };

            UIAlertAction* sceneElementAction = [UIAlertAction actionWithTitle:@"Add Scene Element" style: UIAlertActionStyleDefault handler: handleAlertAction];
            UIAlertAction* basicSceneAction = [UIAlertAction actionWithTitle:@"Add Scene" style: UIAlertActionStyleDefault handler: handleAlertAction];
            UIAlertAction* masterSceneAction = [UIAlertAction actionWithTitle:@"Add Master Scene" style: UIAlertActionStyleDefault handler: handleAlertAction];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleCancel handler: handleAlertAction];

            [alertController addAction: sceneElementAction];
            [alertController addAction: basicSceneAction];
            [alertController addAction: masterSceneAction];
            [alertController addAction: cancel];

            if ([[LSFSDKLightingDirector getLightingDirector] isControllerServiceLeaderV1])
            {
                // disable SceneElement creation
                [sceneElementAction setEnabled: NO];

#ifndef LSF_SCENES_V1_MODULE
                // disable Scene creation
                [basicSceneAction setEnabled: NO];
#endif
            }

            alertController.popoverPresentationController.barButtonItem = self.addButton;
            alertController.popoverPresentationController.sourceView = self.view;

            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: @"Add Scene Element", @"Add Scene", @"Add Master Scene", nil];

            [actionSheet showInView: self.view];

            if ([[LSFSDKLightingDirector getLightingDirector] isControllerServiceLeaderV1])
            {
                // disable SceneElement creation
                [LSFUtilityFunctions disableActionSheet: actionSheet buttonAtIndex: 0];

#ifndef LSF_SCENES_V1_MODULE
                // disable Scene creation
                [LSFUtilityFunctions disableActionSheet: actionSheet buttonAtIndex: 1];
#endif
            }
        }

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                        message: @"Must be connected to a controller before creating a scene."
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
};

-(void)settingsButtonPressed
{
    [self performSegueWithIdentifier: @"ScenesSettings" sender: self];
}

-(NSString *)buildSceneElementDetailsString: (LSFSDKSceneElement *)element
{
    NSMutableString *detailsString = [[NSMutableString alloc] init];

    [detailsString appendString: [NSString stringWithFormat: @"%@ - ", [[element getEffect] name]]];

    for (LSFSDKLightingItem *item in [element getComponentCollection])
    {
        if ([item isKindOfClass: [LSFSDKGroupMember class]])
        {
            [detailsString appendString: [NSString stringWithFormat: @"%@, ", item.name]];
        }
    }

    return (detailsString.length > 2) ? [detailsString substringToIndex: (detailsString.length - 2)] : detailsString;
}

-(NSString *)buildSceneV2DetailsString: (LSFSDKSceneV2 *)scene
{
    NSMutableString *detailsString = [[NSMutableString alloc] init];
    for (LSFSDKLightingItem *item in [scene getComponentCollection])
    {
        if ([item isKindOfClass: [LSFSDKSceneElement class]])
        {
            [detailsString appendString: [NSString stringWithFormat: @"%@, ", item.name]];
        }
    }

    return (detailsString.length > 2) ? [detailsString substringToIndex: (detailsString.length - 2)] : detailsString;
}

-(NSString *)buildMasterSceneDetailsString: (LSFSDKMasterScene *)masterScene
{
    NSMutableString *detailsString = [[NSMutableString alloc] init];
    for (LSFSDKScene *item in [masterScene getScenes])
    {
        [detailsString appendString: [NSString stringWithFormat: @"%@, ", item.name]];
    }

    return (detailsString.length > 2) ? [detailsString substringToIndex: (detailsString.length - 2)] : detailsString;
}

-(void)appendSceneNames: (NSArray *)sceneIDs toString: (NSMutableString *)detailsString
{
    for (NSString *sceneID in sceneIDs)
    {
        LSFSDKScene *scene = [[LSFSDKLightingDirector getLightingDirector] getSceneWithID: sceneID];

        if (scene != nil)
        {
            [detailsString appendString: [NSString stringWithFormat: @"%@, ", scene.name]];
        }
    }
}

-(NSUInteger)findInsertionIndexInArray: (LSFSDKLightingItem *)item
{
    return [self.data indexOfObject: item inSortedRange: (NSRange){0, [self.data count]} options: (NSBinarySearchingFirstEqual | NSBinarySearchingInsertionIndex) usingComparator:
            ^NSComparisonResult(id a, id b) {
                NSString *first = [(LSFSDKLightingItem *)a name];
                NSString *second = [(LSFSDKLightingItem *)b name];

                NSComparisonResult result = [first localizedCaseInsensitiveCompare: second];
                if (result == NSOrderedSame)
                {
                    result = [((LSFSDKLightingItem *)a).theID localizedCaseInsensitiveCompare: ((LSFSDKLightingItem *)b).theID];
                }

                return result;
            }];
}

-(NSArray *)sortScenesByName: (NSArray *)scenes
{
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray: [scenes sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
        NSString *first = [(LSFSDKLightingItem *)a name];
        NSString *second = [(LSFSDKLightingItem *)b name];

        NSComparisonResult result = [first localizedCaseInsensitiveCompare: second];
        if (result == NSOrderedSame)
        {
            result = [((LSFSDKLightingItem *)a).theID localizedCaseInsensitiveCompare: ((LSFSDKLightingItem *)b).theID];
        }

        return result;
    }]];

    return sortedArray;
}

-(int)findIndexInUIForID: (NSString *)theID
{
    for (int i = 0; i < self.data.count; i++)
    {
        LSFSDKScene *scene = [self.data objectAtIndex: i];

        if ([theID isEqualToString: scene.theID])
        {
            return i;
        }
    }

    return -1;
}

-(void)addObjectToTableAtIndex: (NSUInteger)insertIndex
{
    //NSLog(@"Add: Index = %u", insertIndex);
    NSArray *insertIndexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow: insertIndex inSection:0], nil];

    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths: insertIndexPaths withRowAnimation: UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(void)moveObjectFromIndex: (NSUInteger)fromIndex toIndex: (NSUInteger)toIndex
{
    //NSLog(@"Move: FromIndex = %u; ToIndex = %u", fromIndex, toIndex);
    NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow: fromIndex inSection: 0];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow: toIndex inSection: 0];
    [self.tableView moveRowAtIndexPath: fromIndexPath toIndexPath: toIndexPath];

    [self refreshRowInTableAtIndex: toIndex];
}

-(void)refreshRowInTableAtIndex: (NSUInteger)index
{
    //NSLog(@"Refresh: Index = %u", index);
    NSArray *refreshIndexPaths = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow: index inSection:0], nil];
    [self.tableView reloadRowsAtIndexPaths: refreshIndexPaths withRowAnimation: UITableViewRowAnimationNone];
}

-(void)deleteRowsInTableAtIndex: (NSArray *)cellIndexPaths
{
    [self.tableView deleteRowsAtIndexPaths: cellIndexPaths withRowAnimation: UITableViewRowAnimationFade];
}

-(NSArray *)isSceneContainedInMasterScenes: (NSString *)sceneID
{
    NSMutableArray *names = [[NSMutableArray alloc] init];

    for (LSFSDKMasterScene *masterScene in [[LSFSDKLightingDirector getLightingDirector] masterScenes])
    {
        if ([[[masterScene getMasterSceneDataModel] masterScene].sceneIDs containsObject: sceneID])
        {
            NSLog(@"Master Scene %@ contains Scene ID %@", masterScene.name, sceneID);
            [names addObject: [NSString stringWithString: masterScene.name]];
        }
    }

    return names;
}

-(NSArray *)isSceneElementContainedInScene: (NSString *)sceneElementID
{
    NSMutableArray *names = [[NSMutableArray alloc] init];

    LSFSDKSceneElement *element = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: sceneElementID];
    for (LSFSDKLightingItem *item in [element getDependentCollection])
    {
        if ([item isKindOfClass: [LSFSDKScene class]])
        {
            [names addObject: [NSString stringWithString: item.name]];
        }
    }

    return names;
}

-(void)doCreateSceneSegueAtIndex: (int)actionIndex
{
    switch(actionIndex)
    {
        case SCENE_ELEMENT_ACTION_INDEX:
        {
            [self performSegueWithIdentifier: @"CreateSceneElement" sender: self];
            break;
        }
        case SCENE_ACTION_INDEX:
        {
            if ([[LSFSDKLightingDirector getLightingDirector] isControllerServiceLeaderV1])
            {
                [self performSegueWithIdentifier: @"CreateScene" sender: self];
            }
            else
            {
                [self performSegueWithIdentifier: @"CreateSceneV2" sender: self];
            }
            break;
        }
        case MASTER_SCENE_ACTION_INDEX:
        {
            [self performSegueWithIdentifier: @"CreateMasterScene" sender: self];
            break;
        }
        default:
        {
            NSLog(@"Unknown segue for action index %d", actionIndex);
        }
    }
}

-(void)doSegueToSceneInfo: (id)sender
{
#ifdef LSF_SCENES_V1_MODULE
    UIStoryboard *scenesV1StoryBoard = [UIStoryboard storyboardWithName:@"ScenesV1Storyboard" bundle: nil];
    LSFSceneInfoTableViewController *sitvc = (LSFSceneInfoTableViewController *)[scenesV1StoryBoard instantiateViewControllerWithIdentifier:@"SceneV1Info"];
    sitvc.sceneID = [NSString stringWithString: ((LSFSDKScene *)[self.data objectAtIndex: [(NSIndexPath *)sender row]]).theID];

    [self.navigationController pushViewController: sitvc animated:YES];
#endif
}

@end

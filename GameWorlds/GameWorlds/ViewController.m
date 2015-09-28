//
//  ViewController.m
//  GameWorlds
//
//  Created by Serge Kutny on 9/28/15.
//  Copyright © 2015 skutnii. All rights reserved.
//

#import "ViewController.h"
#import "GameWorld.h"
#import "CredentialsViewController.h"

@interface ViewController  ()
    <UITableViewDataSource, UITableViewDelegate, CredentialsDelegate>
{
    NSURLSession *_session;
}

@property(nonatomic, strong) NSArray *worlds;
@property(nonatomic, strong) IBOutlet UITableView *contentView;

@property(nonatomic, assign) BOOL credentialsLocked;
@property(nonatomic, strong) NSURLSession *session;

@end

@implementation ViewController

@synthesize session = _session;

- (NSURLSession*)session {
    if (!_session) {
        _session = [NSURLSession
                    sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                    delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    if (!self.worlds.count && !self.credentialsLocked) {
        CredentialsViewController *credentialsInput = [[CredentialsViewController alloc] init];
        credentialsInput.delegate = self;
        [self presentViewController:credentialsInput animated:NO completion:NULL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWorldsForUsername:(NSString*)username password:(NSString*)password {
    NSMutableURLRequest *loadRq = [NSMutableURLRequest
                                   requestWithURL:
                                   [NSURL URLWithString:
                                    @"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds"]];
    loadRq.HTTPMethod = @"POST";
    UIDevice *device = [UIDevice currentDevice];
    NSString *devType = [NSString stringWithFormat:@"%@ - %@ %@",
                         device.model, device.systemName, device.systemVersion];
    NSString *devId = [[NSUUID UUID] UUIDString];
    NSDictionary *params = @{
                             @"login":username,
                             @"password":password,
                             @"deviceType":devType,
                             @"deviceId":devId
                             };
    
    NSMutableArray *parts = [NSMutableArray arrayWithCapacity:4];
    for (id key in params) {
        [parts addObject:[NSString stringWithFormat:@"%@=%@", key, [params[key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]]];
    }
    NSString *body = [parts componentsJoinedByString:@"&"];
    loadRq.HTTPBody = [NSData dataWithBytes:body.UTF8String length:body.length];
    
    __weak ViewController *weakSelf = self;
    NSURLSessionTask *load = [self.session dataTaskWithRequest:loadRq
                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                 NSError *plistError = nil;
                                                 @try {
                                                     if (error) {
                                                         @throw error;
                                                     }
                                                     
                                                     if (!data) {
                                                         @throw [NSError errorWithDomain:@"HTTP" code:10000
                                                                                userInfo:@{NSLocalizedDescriptionKey:@"No data"}];
                                                     }
                                                     
                                                     NSDictionary *pList = [NSPropertyListSerialization propertyListWithData:data
                                                                                                          options:NSPropertyListImmutable
                                                                                                           format:NULL
                                                                                                            error:&plistError];
                                                     if (plistError) {
                                                         @throw plistError;
                                                     }
                                                     
                                                     NSArray *worldsList = pList[@"allAvailableWorlds"];
                                                     NSMutableArray *tmpWorlds = [NSMutableArray arrayWithCapacity:worldsList.count];
                                                     for (NSDictionary *dict in worldsList) {
                                                         GameWorld *world = [GameWorld new];
                                                         [world updateWithValuesFromDictionary:dict];
                                                         [tmpWorlds addObject:world];
                                                     }
                                                     
                                                     weakSelf.worlds = [NSArray arrayWithArray:tmpWorlds];
                                                     [weakSelf.contentView reloadData];
                                                 } @catch (NSError *err) {
                                                     NSLog(@"%@", err.localizedDescription);
                                                 }
                                             }];
    [load resume];
}

#pragma mark CredentialDelegate

- (void)credentialsInput:(CredentialsViewController *)cntr
       didSubmitUsername:(NSString *)username password:(NSString *)password {
    self.credentialsLocked = YES;
    [self loadWorldsForUsername:username password:password];
    [self dismissViewControllerAnimated:NO completion:NULL];
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tView numberOfRowsInSection:(NSInteger)section {
    return self.worlds.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.contentView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    GameWorld *world = self.worlds[indexPath.row];
    cell.textLabel.text = world.name;
    
    return cell;
}

- (void)tableView:(UITableView*)tView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GameWorld *world = self.worlds[indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:world.link]];
}

@end

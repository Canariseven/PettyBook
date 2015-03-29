//
//  AppDelegate.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 28/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTBook.h"
#import "AGTLibrary.h"
#import "AGTLibraryTableViewController.h"
#import "AGTBookViewController.h"
#import "AGTDataSourceAndDelegateTableView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    AGTBook *book1 = [[AGTBook alloc]initWithTitle:@"IOS - 8.3"
                                           authors:@[@"un autor",@"dos autores",@"tres autores"]
                                              tags:@[@"IOS",@"programación",@"Super poderes"]
                                          urlImage:@"image.jpg"
                                            urlPDF:@"libro.pdf"];
    AGTBook *book2 = [[AGTBook alloc]initWithTitle:@"Aprende Andorid"
                                           authors:@[@"un autor",@"dos autores",@"tres autores"]
                                              tags:@[@"Android",@"programación",@"Super"]
                                          urlImage:@"image.jpg"
                                            urlPDF:@"libro.pdf"];
    AGTBook *book3 = [[AGTBook alloc]initWithTitle:@"Sketch"
                                           authors:@[@"un autor",@"dos autores",@"tres autores"]
                                              tags:@[@"Diseño",@"Apps"]
                                          urlImage:@"image.jpg"
                                            urlPDF:@"libro.pdf"];
    AGTBook *book4 = [[AGTBook alloc]initWithTitle:@"Todo sobre Angular"
                                           authors:@[@"un autor",@"dos autores",@"tres autores"]
                                              tags:@[@"Angular",@"JavaScript"]
                                          urlImage:@"viewIcon"
                                            urlPDF:@"libro.pdf"];
    
    NSArray *books = @[book1,book2,book3,book4];
    AGTLibrary *library = [[AGTLibrary alloc]initWithBooks:books];
    [library booksCountForTag:@"Juan"];
    AGTLibraryTableViewController *tLibrary = [[AGTLibraryTableViewController alloc]initWihtModel:library];
    UINavigationController *navLibrary = [[UINavigationController alloc] initWithRootViewController:tLibrary];
    
    
    AGTBookViewController *book = [[AGTBookViewController alloc] initWithModel:book1];
    UINavigationController *navBook = [[UINavigationController alloc] initWithRootViewController:book];
    
    UISplitViewController *split = [[UISplitViewController alloc]init];
    split.viewControllers = @[navLibrary,navBook];
    split.delegate = book;
    tLibrary.controllerOfTable.delegate = book;
    
    self.window.rootViewController = split;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

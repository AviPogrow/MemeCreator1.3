//
//  AppDelegate.swift
//  MemeCreator
//
//  Created by new on 2/22/16.
//  Copyright © 2016 Avi Pogrow. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	lazy var sharedContext = {
		CoreDataStackManager.sharedInstance().managedObjectContext
	
	}()
	
	
	
	//customize color of UI components
	func customizeAppearance() {
		//make nav bar black and its text white
		UINavigationBar.appearance().barTintColor = UIColor.blackColor()
		
		UINavigationBar.appearance().titleTextAttributes = [
						NSForegroundColorAttributeName:  UIColor.whiteColor() ]
		
		
		UITabBar.appearance().barTintColor = UIColor.blackColor()
		
		_ = UIColor(red: 255/255.0, green: 238/255.0,
		blue: 136/255.0, alpha: 1.0)
		
	
	}
	
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		customizeAppearance()
		return true
	}

	func importJSONSeedData() {
    let jsonURL = NSBundle.mainBundle().URLForResource("seed", withExtension: "json")
    let jsonData = NSData(contentsOfURL: jsonURL!)
    
    do {
      let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments) as! NSArray
      let entity = NSEntityDescription.entityForName("Team", inManagedObjectContext: self.sharedContext)
      
      for jsonDictionary in jsonArray {
        let teamName = jsonDictionary["teamName"] as! String
        let zone = jsonDictionary["qualifyingZone"] as! String
        let imageName = jsonDictionary["imageName"] as! String
        let wins = jsonDictionary["wins"] as! NSNumber
        
        let team = Team(entity: entity!,
          insertIntoManagedObjectContext: self.sharedcontext)
        team.teamName = teamName
        team.imageName = imageName
        team.qualifyingZone = zone
        team.wins = wins
      }
      
      do {
        try sharedContext.save()
      } catch {
        print("error saving to context\(error)")
      }
    }
  }	
	
func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}


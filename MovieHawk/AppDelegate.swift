//
//  AppDelegate.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/4/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureUI()
        loadData()
        configureParse()
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{
    
    fileprivate func configureUI(){
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    fileprivate func loadData(){
        let tabBarC = window!.rootViewController as! UITabBarController
        
        let navVC0 = tabBarC.viewControllers?[0] as! UINavigationController
        
        let vc0 = navVC0.topViewController as! FeedViewController
        vc0.store = FeedStore(target: vc0)
        
        
        let navVC1 = tabBarC.viewControllers?[1] as! UINavigationController
        let vc1 = navVC1.topViewController as! SearchViewController
        vc1.store = MovieStore()
        
        let navVC2 = tabBarC.viewControllers?[2] as! UINavigationController
        let vc2 = navVC2.topViewController as! UserViewController
         vc2.store = UserStore()
    }
    
    fileprivate func configureParse(){
        
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "MovieHawk"
            $0.server = "https://moviehawk-parse-ask.herokuapp.com/parse"
        }
        Parse.initialize(with: configuration)
        
        let acl = PFACL()
        acl.getPublicReadAccess = true
        PFACL.setDefault(acl, withAccessForCurrentUser: true)
        
        do {
            try PFUser.logIn(withUsername: "test", password: "test")
        } catch {
            print("Unable to log in")
        }
        
        if let currentUser = PFUser.current() {
            print("\(currentUser.username!) logged in successfully")
        } else {
            print("No logged in user :(")
        }
        Movie.registerSubclass()
        
    }
}


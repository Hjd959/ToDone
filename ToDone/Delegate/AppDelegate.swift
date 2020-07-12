//
//  AppDelegate.swift
//  ToDone
//
//  Created by عبدالوهاب العنزي on 30/06/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData


@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     

        
      
        print("didFinshLanuchHightWithOptional")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
 
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
          print("ApplecationDidEnterBackground")
    }
    func applicationWillTerminate(_ application: UIApplication) {
         print("applicationWillTerminate")
        
        self.saveContext()
    }
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
  
          let container = NSPersistentContainer(name: "DataModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {

                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()

      // MARK: - Core Data Saving support

      func saveContext () {
          let context = persistentContainer.viewContext
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
               
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }



}


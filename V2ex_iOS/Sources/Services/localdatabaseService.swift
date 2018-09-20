//
//  localdatabaseService.swift
//  V2ex_iOS
//
//  Created by zippo on 9/20/18.
//  Copyright © 2018 zippo. All rights reserved.
//

import Foundation
import CoreData

class localDataBaseService {
    private init(){
//        if UserDefaults.standard.bool(forKey: "Not_First_time_running") == false {
//            UserDefaults.standard.set(true, forKey: "Not_First_time_running")
//        }
    }
    static let shared = localDataBaseService()
    
    // core data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "V2ex_iOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func updateWithThreadJsonDict(_ dict : [String : Any]) {
        let context : NSManagedObjectContext = persistentContainer.newBackgroundContext()
        
        let request : NSFetchRequest<Thread> = NSFetchRequest(entityName: "Thread")
        request.sortDescriptors = [NSSortDescriptor.init(key: "last_touched", ascending: false)]
        
        if let threadid = dict["id"] as? Int64 // thread id
        ,let node_dict = dict["node"] as? [String : Any] // node dict
        ,let member_dict = dict["member"] as? [String : Any] // user dict
        ,let thread_url = dict["url"] as? String
        ,let created_ts = dict["created"] as? Int64 // unix timestamp
        ,let num_replies = dict["replies"] as? Int64
        ,let last_replied_by = dict["last_reply_by"] as? String// user name
        ,let last_touched = dict["last_touched"] as? Int64 // unix timestamp
        ,let title = dict["title"] as? String
        ,let content_rendered = dict["content_rendered"] as? String // html
        ,let content_str = dict["content"] as? String // string
        {
            print(type(of: title), type(of: threadid), type(of: member_dict) , type(of: node_dict), type(of: thread_url), type(of: created_ts), type(of: num_replies),type(of: last_replied_by),type(of: last_touched),type(of: content_rendered),type(of: content_str))
        }
        
        
    }
    
}

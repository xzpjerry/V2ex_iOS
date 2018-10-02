//
//  localdatabaseService.swift
//  V2ex_iOS
//
//  Created by zippo on 9/20/18.
//  Copyright © 2018 zippo. All rights reserved.
//

import Foundation
import CoreData

enum thisAppErrors : Error {
    case solvingError
}

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
    
//    func updateWithNodeDict(_ dict : [String : Any]) -> Node {
//        // if this node is not found in coredata, then create this node
//    }
//
    func updateWithMemberDict(_ dict : [String : Any]) throws -> Member {
        // if this member is not found in coredata, then create this member
//        print(dict.keys)
        // ["tagline", "avatar_mini", "location", "twitter", "github", "username", "created", "avatar_normal", "id", "avatar_large", "bio", "website", "btc", "url", "psn"]
        guard let avator = dict["avatar_mini"] as? String,
            let created = dict["created"] as? Int64,
            let id = dict["id"] as? Int64,
            let url = dict["url"] as? String,
            let username = dict["username"] as? String
            else {
                print("Corrupt dict")
                throw thisAppErrors.solvingError
        }
        
        let context : NSManagedObjectContext = persistentContainer.newBackgroundContext()
        let result = Member(context: context)
        
        result.avatar = avator
        result.created = Date(timeIntervalSince1970: TimeInterval.init(exactly: created)!)
        result.id = id
        result.url = url
        result.username = username
        
        try context.save()
        
        return result
    }
    
    func updateWithThreadJsonDict(_ dict : [String : Any]) {
        let context : NSManagedObjectContext = persistentContainer.newBackgroundContext()
        
        let request : NSFetchRequest<Thread> = NSFetchRequest(entityName: "Thread")
        request.sortDescriptors = [NSSortDescriptor.init(key: "last_touched", ascending: false)]
        
        guard let threadid = dict["id"] as? Int64 // thread id
        ,let node_dict = dict["node"] as? [String : Any] // node dict
        ,let member_dict = dict["member"] as? [String : Any] // user dict
        ,let thread_url = dict["url"] as? String
        ,let created_ts = dict["created"] as? Int64 // unix timestamp
        ,let num_replies = dict["replies"] as? Int64
        ,let last_replied_by = dict["last_reply_by"] as? String// user name
        ,let last_touched = dict["last_touched"] as? Int64 // unix timestamp
        ,let title = dict["title"] as? String
        ,let content_rendered = dict["content_rendered"] as? String // html
        ,let content_str = dict["content"] as? String, // string
        let author = try? updateWithMemberDict(member_dict)
        else {
            print("Corrupt json")
            // then dont update the database
            return
        }
        
//        print(type(of: title), type(of: threadid), type(of: member_dict) , type(of: node_dict), type(of: thread_url), type(of: created_ts), type(of: num_replies),type(of: last_replied_by),type(of: last_touched),type(of: content_rendered),type(of: content_str))
//
        
        //            let node = updateWithNodeDict(node_dict)
        
    }
    
}

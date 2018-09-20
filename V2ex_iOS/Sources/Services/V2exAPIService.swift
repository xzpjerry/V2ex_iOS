//
//  V2exAPIService.swift
//  V2ex_iOS
//
//  Created by zippo on 9/19/18.
//  Copyright © 2018 zippo. All rights reserved.
//
import CoreData
import Foundation

class V2exAPIService {
    private init(){}
    private let hot_json = "https://www.v2ex.com/api/topics/hot.json"
    static let shared = V2exAPIService()
    
    func get_hotest(completion_handler : @escaping (_ content : [String : Any]) -> Void) {
        guard let url = URL(string: hot_json) else {
            print("URLERROR")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                let json_array = try? JSONSerialization.jsonObject(with: data, options: []) as! [Any] else {
                    print("JSON error")
                    return
            }
            
            for obj in json_array {
                guard let obj = obj as? [String : Any] else {
                    print("Server has returned a corrupted json")
                    continue
                }
                completion_handler(obj)
                
            }
                
        }
        
        task.resume()
    }
    
    
    
//    func test_apis(completion_handler : @escaping (_ content : String) -> Void){
//        var result : [String] = []
//        let url = URL(string: hot_json)
//        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
//
//            guard let data = data, error == nil else {
//                print("Error")
//                return
//            }
//
//            if let json_array = try? JSONSerialization.jsonObject(with: data, options: []) as! [Any] {
//                for obj in json_array {
//                    if let dict = obj as? [String : Any] {
//                        print(dict.keys)
//                        print(dict["member"])
//
//                        print(dict["id"]) // thread id
//                        print(dict["node"]) // node dict
//                        print(dict["url"])
//                        print(dict["created"])// unix timestamp
//                        print(dict["replies"])
//                        print(dict["last_reply_by"])// user name
//                        print(dict["last_touched"])// unix timestamp
//                        print(dict["title"])
//                        print(dict["content_rendered"]) // html
//                        print(dict["content"]) // string
//                        break
//                    }
//                }
//            }
//
//            completion_handler(result[0])
//
//        }
//
//        task.resume()
//
//    }
}

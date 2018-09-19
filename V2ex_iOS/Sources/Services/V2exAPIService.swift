//
//  V2exAPIService.swift
//  V2ex_iOS
//
//  Created by zippo on 9/19/18.
//  Copyright © 2018 zippo. All rights reserved.
//

import Foundation

class V2exAPIService {
    private init(){}
    static var shared = V2exAPIService()
    
    func test(completion_handler : @escaping (_ content : String) -> Void){
        var result : [String] = []
        let url = URL(string: "https://www.v2ex.com/api/topics/hot.json")
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error")
                return
            }
            
            if let json_array = try? JSONSerialization.jsonObject(with: data, options: []) as! [Any] {
                for obj in json_array {
                    if let dict = obj as? [String : Any], let content = dict["content"] as? String {
                        print(content)
                        result.append(MarkdownService.shared.toString(content: content))
                        break
                    }
                }
            }
            
            completion_handler(result[0])
            
        }
        
        task.resume()
        
    }
}

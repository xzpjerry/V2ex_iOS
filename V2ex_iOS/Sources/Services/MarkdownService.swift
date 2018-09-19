//
//  MarkdownService.swift
//  V2ex_iOS
//
//  Created by zippo on 9/19/18.
//  Copyright © 2018 zippo. All rights reserved.
//

import Foundation
import JavaScriptCore


class MarkdownService {
    private var context : JSContext = JSContext()
    private var marked : JSValue?
    private let default_html = """
                <html>
                <body>
                <h1>Error!</h1>
                </body>
                </html>
                """
    private init(){
        do {
            try _ = context.evaluateScript(String(contentsOfFile: Bundle.main.path(forResource: "marked", ofType: "js")!))
            marked = context.objectForKeyedSubscript("marked")
        } catch {
            debugPrint("initialized marked js with error!")
        }
    }
    static var shared = MarkdownService()
    
    func toString(content : String) -> String {
        guard let value = marked?.call(withArguments: [content]) else {
            return default_html
        }
        var htmlContent = try! String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!)
        let range = htmlContent.range(of: "[markdown-content-flag]")
        htmlContent.replaceSubrange(range!, with: value.toString())
        
        
        return htmlContent
    }
    
}

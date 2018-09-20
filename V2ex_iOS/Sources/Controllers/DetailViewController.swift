//
//  ViewController.swift
//  V2ex_iOS
//
//  Created by zippo on 9/19/18.
//  Copyright © 2018 zippo. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    @IBOutlet var webView : WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    func update_webview(_ content : String) {
        DispatchQueue.main.sync {
            webView.stopLoading()
            webView.loadHTMLString(content, baseURL: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}


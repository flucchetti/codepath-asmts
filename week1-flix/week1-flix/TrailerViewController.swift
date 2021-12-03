//
//  TrailerViewController.swift
//  week1-flix
//
//  Created by Francesca on 12/3/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
        
        var webView: WKWebView!
        var movieURL : URL!
    
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.allowsInlineMediaPlayback = true
            
            let request:URLRequest = URLRequest(url: movieURL)
            self.webView.load(request)
        }
            

}

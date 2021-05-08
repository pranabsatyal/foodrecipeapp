//
//  DetailViewController.swift
//  Food Recipe
//
//  Created by Pranab Raj Satyal on 5/4/21.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    var pageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let webURL = pageURL {
            let safariView = SFSafariViewController(url: URL(string: webURL)!)
            present(safariView, animated: true, completion: nil)
        }
    }
    
}

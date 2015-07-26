//
//  ViewController.swift
//  CustomDesignableExample
//
//  Created by Ignacio Nieto Carvajal on 26/7/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // outlets
    @IBOutlet weak var awesomenessLabel: UILabel!
    @IBOutlet weak var awesomenessImageView: RoundedImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // keep the label up to date about our awesomeness level
        awesomenessLabel.text = "\(awesomenessImageView.completed)"
        awesomenessImageView.addObserver(self, forKeyPath: "completed", options: [.New, .Old], context: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        awesomenessImageView.removeObserver(self, forKeyPath: "completed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func increaseAwesomeness(sender: AnyObject) {
        awesomenessImageView.completed += 0.1
    }

    @IBAction func decreaseAwesomeness(sender: AnyObject) {
        awesomenessImageView.completed -= 0.1
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("Observe value caled for path \(keyPath)")
        if keyPath == "completed" {
            var newValue = change![NSKeyValueChangeNewKey] as! Double
            if newValue < 0.1 { newValue = 0.0 }
            awesomenessLabel.text = "\(newValue)"
        }
    }
    
}


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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // keep the label up to date about our awesomeness level
        awesomenessLabel.text = "\(awesomenessImageView.completed)"
        awesomenessImageView.addObserver(self, forKeyPath: "completed", options: [.new, .old], context: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        awesomenessImageView.removeObserver(self, forKeyPath: "completed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func increaseAwesomeness(_ sender: AnyObject) {
        awesomenessImageView.completed += 0.1
    }

    @IBAction func decreaseAwesomeness(_ sender: AnyObject) {
        awesomenessImageView.completed -= 0.1
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("Observe value caled for path \(keyPath)")
        if keyPath == "completed" {
            var newValue = change![NSKeyValueChangeKey.newKey] as! Double
            if newValue < 0.1 { newValue = 0.0 }
            awesomenessLabel.text = "\(newValue)"
        }
    }
    
}


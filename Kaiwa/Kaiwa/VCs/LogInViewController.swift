//
//  LogInViewController.swift
//  Kaiwa
//
//  Created by Tomoki William Takasawa on 10/7/18.
//  Copyright © 2018 Tomoki Takasawa. All rights reserved.
//

import Foundation
import UIKit
import TransitionButton

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = TransitionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.backgroundColor = .red
        
        button.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
    }
    
    @objc func tapped(_ button: TransitionButton) {
        button.startAnimation()
        let nextVC = CameraVideoViewController()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(3)
            DispatchQueue.main.async(execute: {
                () -> Void in
                
                button.stopAnimation(animationStyle: .expand, completion: {
                    
                    if let navigator = self.navigationController {
                        navigator.pushViewController(nextVC, animated: false)
                    }
                })
            })
        }
        
        
    }
}

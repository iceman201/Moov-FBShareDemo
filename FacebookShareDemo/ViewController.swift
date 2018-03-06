//
//  ViewController.swift
//  FacebookShareDemo
//
//  Created by Liguo Jiao on 6/03/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

import UIKit
import FacebookShare
import FBSDKShareKit
import FacebookLogin

class ViewController: UIViewController {
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookButton.addTarget(self, action: #selector(share), for: .touchUpInside)
    }
    
    @IBAction func login(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if let button = sender as? UIButton {
                    button.setTitle("LogOut", for: .normal)
                }
            }
        }
    }
    
    @objc func share() {
        let photo = Photo(image: #imageLiteral(resourceName: "testImage"), userGenerated: true)
        let content = PhotoShareContent(photos: [photo])

        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            print("haha: \(result)")
        }
        do {
            try shareDialog.show()
        } catch let err {
            print("-----------------------------")
            print(err.localizedDescription)
            print("-----------------------------")
        }
    }
}


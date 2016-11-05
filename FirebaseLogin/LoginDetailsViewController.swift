//
//  LoginDetailsViewController.swift
//  FirebaseLogin
//
//  Created by Kelvin Lau on 2016-11-04.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import UIKit

final class LoginDetailsViewController: UIViewController {
  @IBOutlet fileprivate var uidLabel: UILabel!
}

// MARK: - Life Cycle
extension LoginDetailsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    uidLabel.text = Server.currentUser?.uid
  }
}

// MARK: - @IBActions
private extension LoginDetailsViewController {
  @IBAction func logoutTapped() {
    Server.logout { success in
      if success {
        self.dismiss(animated: true, completion: nil)
      } else {
        fatalError("What could have happened")
      }
    }
  }
}

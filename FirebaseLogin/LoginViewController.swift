//
//  LoginViewController.swift
//  FirebaseLogin
//
//  Created by Kelvin Lau on 2016-10-18.
//  Copyright © 2016 Kelvin Lau. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

final class LoginViewController: UIViewController {
  @IBOutlet fileprivate var emailTextField: UITextField!
  @IBOutlet fileprivate var passwordTextField: UITextField!
}

// MARK: - Life Cycle
extension LoginViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
// MARK: - SegueHandlerType
extension LoginViewController: SegueHandlerType {
  enum SegueIdentifier: String {
    case loginSuccess
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segueIdentifierFor(segue: segue) {
    case .loginSuccess:
      break
    }
  }
}

// MARK: - FacebookLoginDelegate
extension LoginViewController: FBSDKLoginButtonDelegate {
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if let error = error {
      print(error.localizedDescription)
      return
    } else {
      Server.login(withFacebookToken: FBSDKAccessToken.current()) { response in
        switch response {
        case .success:
          self.performSegue(withIdentifier: .loginSuccess, sender: nil)
        case let .failure(message):
          print("failed to login using facebook: \(message)")
        }
      }

    }
  }
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    Server.logout { success in
    }
  }
}

// MARK: - @IBActions 
private extension LoginViewController {
  @IBAction func loginButtonTapped() {
    guard let email = emailTextField.text, let password = passwordTextField.text else { fatalError() }
    Server.login(withEmail: email, password: password) { authResponse in
      switch authResponse {
      case .success:
        self.performSegue(withIdentifier: .loginSuccess, sender: nil)
      case let .failure(message):
        print("failed to log in: \(message)")
      }
    }
  }
  
  @IBAction func createAccountButtonTapped() {
    guard let email = emailTextField.text, let password = passwordTextField.text else { fatalError() }
    Server.createAccount(withEmail: email, password: password) { authResponse in
      switch authResponse {
      case .success:
        print("successfully created account!")
      case let .failure(message):
        print("failed to create account: \(message)")
      }
    }
  }
}

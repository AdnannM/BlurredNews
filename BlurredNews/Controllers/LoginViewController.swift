//
//  ViewController.swift
//  BlurredNews
//
//  Created by Adnann Muratovic on 03.09.21.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var singInButton: UIButton! {
        didSet {
            singInButton.layer.cornerRadius = 13
        }
    }
    @IBOutlet weak var loginView: UIView!
    
    
    private let imageSet = ["cloud", "coffee", "food", "pmq", "temple"]
    private var blurEffectView: UIVisualEffectView?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        authenticateWithBiometric()
        loginView.isHidden = true
        applyBlurrView()
    }
    
    // MARK: - Applay Blur ImageView
    fileprivate func applyBlurrView() {
        // Randomly pick an image
        let selectedImageIndex = Int(arc4random_uniform(5))
        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        blurEffectView?.frame = view.bounds
    }
    
    func showDialog() {
        // Move loginScreen off the screen
        loginView.isHidden = false
        loginView.transform = CGAffineTransform(translationX: 0, y: -700)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.loginView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // MARK: - Action
    @IBAction func singInButtonTapped(_ sender: UIButton) {
        if emailTextField.text == "adnann@gmail.com" &&
            passwordTextField.text == "1234" {
            performSegue(withIdentifier: "showNewsScreen", sender: nil)
        } else {
            // Shake to indicate wrong password
            loginView.transform = CGAffineTransform(translationX: 25, y: 0)
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.15, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                self.loginView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        print("Sing In Tapped...")
    }
}

// MARK: - Touch ID/Face ID Authentication
extension LoginViewController {
    func authenticateWithBiometric() {
        // Get the local authentication context
        let localAuthContext = LAContext()
        let reasonText = "Authentication is required to Sing In to News"
        
        var authError: NSError?
        
        if !localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                               error: &authError) {
            if let error = authError {
                print(error.localizedDescription)
            }
            
            // Display the login dialog when Touch ID is not available
            showDialog()
            
            return
        }
        
        // Perform the Biometric authentication
        localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                        localizedReason: reasonText) { (success: Bool, error: Error?) -> Void in
            // Failure workflow
            if !success {
                if let error = error {
                    switch error {
                    case LAError.authenticationFailed:
                        print("Authentication Failed. try again!")
                    case LAError.passcodeNotSet:
                        print("Passcode is not set")
                    case LAError.systemCancel:
                        print("Authentication was canceled by system")
                    case LAError.userCancel:
                        self.loginView.isHidden = true
                        DispatchQueue.main.async {
                            self.showError(title: "Authentication Canceled", message: "Authentication Canceled by the user")
                            self.loginView.isHidden = false
                        }
                        
                    case LAError.biometryNotEnrolled:
                        print("Authentication could not start bacasuse you haven't enrolled either Touch ID/Face ID on your device")
                    case LAError.biometryNotAvailable:
                        print("Authentication could not start becasuse Touch ID/Face ID is not available")
                    case LAError.userFallback:
                        print("User tapped fallback button (Enter Password)")
                    default:
                        print(error.localizedDescription)
                    }
                }
                
                // Fallback to the password authentication
                OperationQueue.main.addOperation {
                    self.showDialog()
                }
            } else {
                // Success workflow
                OperationQueue.main.addOperation {
//                    self.showError(title: "Successfully Login", message: "Successefully authenticated")
                    self.performSegue(withIdentifier: "showNewsScreen", sender: nil)
                }
            }
        }
    }
    
    // MARK: - Prompt Error
    func showError(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
}

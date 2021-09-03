//
//  ViewController.swift
//  BlurredNews
//
//  Created by Adnann Muratovic on 03.09.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singInButton: UIButton! {
        didSet {
            singInButton.layer.cornerRadius = 13
        }
    }
    
    private let imageSet = ["cloud", "coffee", "food", "pmq", "temple"]
    private var blurEffectView: UIVisualEffectView?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        applyBlurrView()
    }
    
    // MARK: - Applay Blur ImageView
    fileprivate func applyBlurrView() {
        // Randomly pick an image
        let selectedImageIndex = Int.random(in: 0..<imageSet.count)
        
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
    
    // MARK: - Action
    @IBAction func singInButtonTapped(_ sender: UIButton) {
        print("Sing In Tapped...")
    }
}


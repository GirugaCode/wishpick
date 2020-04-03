//
//  LoginViewController.swift
//  wishpick
//
//  Created by Ryan Nguyen on 8/7/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import AuthenticationServices
import CryptoKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import UIKit

class LoginViewController: UIViewController {
    
    /// Unhashed Nonce for Apple Authentication
    fileprivate var currentNonce: String?
    
    //MARK: UI COMPONENTS
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wishpickIcon, wishpickLabel, wishpickSubLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let wishpickIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wishpick_icon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let wishpickLabel: UILabel = {
        let label = UILabel()
        label.text = "wishpick"
        label.textColor = #colorLiteral(red: 0.4039215686, green: 0.3215686275, blue: 0.3215686275, alpha: 1)
        label.font = UIFont(name: Fonts.proximaAltBold, size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wishpickSubLabel: UILabel = {
        let label = UILabel()
        label.text = "want & share"
        label.textColor = #colorLiteral(red: 1, green: 0.9387172013, blue: 0.6734803082, alpha: 1)
        label.font = UIFont(name: Fonts.proximaAltBold, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [facebookLoginButton, emailLoginButton, tosButton])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let facebookLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect with Facebook", for: .normal)
        button.titleEdgeInsets.left = 30
        button.imageEdgeInsets.right = 45
        button.setImage(#imageLiteral(resourceName: "facebook_icon"), for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.4745098039, blue: 0.7882352941, alpha: 1)
        button.addTarget(self, action: #selector(facebookSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up with E-mail", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.proximaBold, size: 20)
        button.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
        button.layer.cornerRadius = 40
        button.titleEdgeInsets.left = 10
        button.imageEdgeInsets.right = 20
        button.setImage(#imageLiteral(resourceName: "Email-Icon"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(emailSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tosButton: UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "By signing up, you agree to our ", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.proximaRegular, size: 18) as Any])
        attributedText.append(NSAttributedString(string: "Terms of Service ", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.proximaBold, size: 18) as Any]))
        attributedText.append(NSAttributedString(string: "and ", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.proximaRegular, size: 18) as Any]))
        attributedText.append(NSAttributedString(string: "Privacy Policy ", attributes: [NSAttributedString.Key.font : UIFont(name: Fonts.proximaBold, size: 18) as Any]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtonCornerRadius()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if #available(iOS 13.0, *) {
            appleSignIn()
        } else {
            // Fallback on earlier versions
            return
        }
    }
    
    override func loadView() {
        super.loadView()
        
        setupLoginView()
    }
    
    //MARK: AUTH
    @objc func facebookSignIn() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                if (AccessToken.current != nil) {
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    AppDelegate.shared.rootViewController.switchToMainScreen()
                    
                    // Firebase Analytics
                    Analytics.logEvent(AnalyticsEventLogin, parameters: [
                        "Login Error": error ?? "Error",
                        "Username": user ?? "User"
                    ])
                } else {
                    // Present failed login
                    let alert = UIAlertController(title: "Facebook Failed Attempt", message: "Error Processing, please try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @objc func emailSignIn() {
        AppDelegate.shared.rootViewController.switchToLoginWithEmail()
    }
    
    //MARK: UI SETUP
    fileprivate func setupLoginView() {
        
        // Adding Views
        view.addSubview(topStackView)
        view.addSubview(bottomStackView)
        
        // Constraining the UI
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 15),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            bottomStackView.topAnchor.constraint(equalToSystemSpacingBelow: topStackView.bottomAnchor, multiplier: 25),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Size of Facebook Login Button
            facebookLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            facebookLoginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            // Size of Email Login Button
            emailLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            emailLoginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
            
        ])
    }
    
    fileprivate func setupUI() {
        // Set up background gradient
        view.setGradientBackground(colorOne: #colorLiteral(red: 0.5019607843, green: 0.3647058824, blue: 0.1725490196, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.6561305523, blue: 0.171354413, alpha: 1))
    }
    
    fileprivate func setButtonCornerRadius() {
        facebookLoginButton.roundedButton(button: facebookLoginButton)
        emailLoginButton.roundedButton(button: emailLoginButton)
    }
}


@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    private func appleSignIn() {
        let siwaButton = ASAuthorizationAppleIDButton()
        
        // set this so the button will use auto layout constraint
        siwaButton.translatesAutoresizingMaskIntoConstraints = false
        
        // add the button to the view controller root view
        self.view.addSubview(siwaButton)
        
        // set constraint
        NSLayoutConstraint.activate([
            siwaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35.0),
            siwaButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35.0),
            siwaButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20.0),
            siwaButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        // the function that will be executed when user tap the button
        siwaButton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
    }
    
    @objc func handleAppleSignIn() {
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        // request full name and email from the user's Apple ID
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        // pass the request to the initializer of the controller
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        // similar to delegate, this will ask the view controller
        // which window to present the ASAuthorizationController
        authController.presentationContextProvider = self
        
        // delegate functions will be called when user data is
        // successfully retrieved or error occured
        authController.delegate = self
        
        // show the Sign-in with Apple dialog
        authController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    print(error.localizedDescription)
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                print("sucess!")
                UserDefaults.standard.setIsLoggedIn(value: true)
                AppDelegate.shared.rootViewController.switchToMainScreen()
                
            }
        }
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorization error")
        guard let error = error as? ASAuthorizationError else {
            return
        }
        
        switch error.code {
        case .canceled:
            // user press "cancel" during the login prompt
            print("Canceled")
        case .unknown:
            // user didn't login their Apple ID on the device
            print("Unknown")
        case .invalidResponse:
            // invalid response received from the login
            print("Invalid Respone")
        case .notHandled:
            // authorization request not handled, maybe internet failure during login
            print("Not handled")
        case .failed:
            // authorization failed
            print("Failed")
        @unknown default:
            print("Default")
        }
    }
}

import UIKit

class CreateAccountViewController: UIViewController {
    // MARK: - Views
    private let navigationLoginTitle = "Sign In"
    private let mainSignUpLabel = UILabel()
    private let subSignUpLabel = UILabel()
    private let backLoginButton = UIButton()
    private let nameSignUpTextField = FDTextField(fildType: .name, fieldLabelText: "FULL NAME")
    private let emailSignUpTextField = FDTextField(fildType: .email, fieldLabelText: "EMAIL ADDRESS")
    private let passwordSignUpTextField = FDTextField(fildType: .password, fieldLabelText: "PASSWORD")
    private let textFieldStackView = UIStackView()
    private let signUpButton = FDButton(titleType: .signUp)
    private let textLabel = UILabel()
    private let orLabel = UILabel()
    private let facebookButton = FDSocialLoginButton(type: .facebook)
    private let googleButton = FDSocialLoginButton(type: .google)
    private let socialButtonsStackView = UIStackView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    // MARK: - @objc
    @objc private func backLoginButtonPressed() {
        print("back Login")
    }
    @objc private func passwordButtonPressed() {
        print("passwordButtonPressed")
    }
    @objc private func signUpButtonPressed() {
        print("signUpButtonPressed")
    }
    @objc private func facebookButtonPressed() {
        print("facebookButtonPressed")
    }
    @objc private func googleButtonPressed() {
        print("coogleButtonPressed")
    }
}
private extension CreateAccountViewController {
    func setupLayout() {
        setupView()
        setupNavigationController()
        setupMainLoginLabel()
        setupSubLoginLabel()
        setupBackLoginButton()
        setupNameSignUpTextField()
        setupEmailSignUpTextField()
        setupPasswordLoginTextField()
        setupTextFieldStackView()
        setupSignUpButton()
        setupTextLabel()
        setupOrLabel()
        setupFacebookButton()
        setupGoogleButton()
        setupSocialButtonsStackView()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundWhiteColor
    }
    
    func setupNavigationController() {
        navigationController?.title = navigationLoginTitle
    }
    
    func setupMainLoginLabel() {
        view.addSubview(mainSignUpLabel)
        
        mainSignUpLabel.translatesAutoresizingMaskIntoConstraints = false
        mainSignUpLabel.text = "Create Account"
        mainSignUpLabel.numberOfLines = 2
        mainSignUpLabel.textAlignment = .left
        mainSignUpLabel.font = UIFont(name: "AvenirNext-Regular", size: 34)
        mainSignUpLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainSignUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            mainSignUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            mainSignUpLabel.widthAnchor.constraint(equalToConstant: 258),
            mainSignUpLabel.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    func setupSubLoginLabel() {
        view.addSubview(subSignUpLabel)
        
        subSignUpLabel.translatesAutoresizingMaskIntoConstraints = false
        subSignUpLabel.text = "Enter your Name, Email and Password\nfor sign up."
        subSignUpLabel.numberOfLines = 2
        subSignUpLabel.textAlignment = .left
        subSignUpLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subSignUpLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subSignUpLabel.topAnchor.constraint(equalTo: mainSignUpLabel.bottomAnchor),
            subSignUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            subSignUpLabel.widthAnchor.constraint(equalToConstant: 280),
            subSignUpLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupBackLoginButton() {
        view.addSubview(backLoginButton)
        
        backLoginButton.translatesAutoresizingMaskIntoConstraints = false
        backLoginButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        backLoginButton.setTitleColor(AppColors.accentOrangeColor, for: .normal)
        backLoginButton.setTitle("Already have account?", for: .normal)
        backLoginButton.addTarget(self,
                                  action: #selector(backLoginButtonPressed),
                                  for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            backLoginButton.topAnchor.constraint(equalTo: subSignUpLabel.centerYAnchor, constant: 6),
            backLoginButton.widthAnchor.constraint(equalToConstant: 165),
            backLoginButton.trailingAnchor.constraint(equalTo: subSignUpLabel.trailingAnchor, constant: -20),
            backLoginButton.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func setupNameSignUpTextField() {
        view.addSubview(nameSignUpTextField)
        
        nameSignUpTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupEmailSignUpTextField() {
        view.addSubview(emailSignUpTextField)
        
        emailSignUpTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPasswordLoginTextField() {
        view.addSubview(passwordSignUpTextField)
        
        passwordSignUpTextField.action = passwordButtonPressed
        passwordSignUpTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupTextFieldStackView() {
        view.addSubview(textFieldStackView)
        
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.spacing = 18
        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: subSignUpLabel.bottomAnchor, constant: 24),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        textFieldStackView.addArrangedSubview(nameSignUpTextField)
        textFieldStackView.addArrangedSubview(emailSignUpTextField)
        textFieldStackView.addArrangedSubview(passwordSignUpTextField)
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.action = signUpButtonPressed
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 24),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupTextLabel() {
        view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "By Signing up you agree to our Terms\nConditions & Privacy Policy."
        textLabel.textColor = AppColors.badyTextGreyColor
        textLabel.numberOfLines = 2
        textLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            textLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupOrLabel() {
        view.addSubview(orLabel)
        
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.text = "Or"
        orLabel.textColor = AppColors.mainBlackColor
        orLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        orLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 24),
            orLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 168),
            orLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -168),
            orLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    func setupFacebookButton() {
        view.addSubview(facebookButton)
        
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.action = facebookButtonPressed
    }
    
    func setupGoogleButton() {
        view.addSubview(googleButton)
        
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.action = googleButtonPressed
    }
    
    func setupSocialButtonsStackView() {
        view.addSubview(socialButtonsStackView)
        
        socialButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        socialButtonsStackView.axis = .vertical
        socialButtonsStackView.distribution = .fillEqually
        socialButtonsStackView.spacing = 16
        
        NSLayoutConstraint.activate([
            socialButtonsStackView.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 24),
            socialButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            socialButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            socialButtonsStackView.heightAnchor.constraint(equalToConstant: 104)
        ])
        
        socialButtonsStackView.addArrangedSubview(facebookButton)
        socialButtonsStackView.addArrangedSubview(googleButton)
    }
}

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: KeyboardDismissViewController {
    // MARK: - Views
    private let navigationLoginTitle = "Sign In"
    private let mainLoginLabel = UILabel()
    private let subLoginLabel = UILabel()
    private let emailLoginTextField = FDTextField(fildType: .email, fieldLabelText: "EMAIL ADDRESS")
    private let passwordLoginTextField = FDTextField(fildType: .password, fieldLabelText: "PASSWORD")
    private let forgotPasswordButton = UIButton()
    private let signInButton = FDButton(titleType: .signIn)
    private let noAccountLabel = UILabel()
    private let newAccountButton = UIButton()
    private let createAccountStackView = UIStackView()
    private let orLabel = UILabel()
    private let facebookButton = FDSocialButton(type: .facebook)
    private let googleButton = FDSocialButton(type: .google)
    private let socialButtonsStackView = UIStackView()
    private let loaderView = FDLoaderView()
    // MARK: - Properties
    private var viewModel: LoginViewModelType
    private let disposeBag = DisposeBag()
    // MARK: - Init
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        rxBindings()
    }
    // MARK: - @objc
    @objc private func facebookButtonPressed() {
        print("facebookButtonPressed")
    }
    @objc private func googleButtonPressed() {
        print("coogleButtonPressed")
    }
}
// MARK: - Extension methods
private extension LoginViewController {
    func setupLayout(){
        setupView()
        setupNavigationController()
        setupMainLoginLabel()
        setupSubLoginLabel()
        setupEmailLoginTextField()
        setupPasswordLoginTextField()
        setupForgotPasswordButton()
        setupSignInButton()
        setupNoAccountLabel()
        setupNewAccountButton()
        setupCreateAccountStackView()
        setupOrLabel()
        setupFacebookButton()
        setupGoogleButton()
        setupSocialButtonsStackView()
        setupLoaderView()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.inputWhiteColor
    }
    
    func setupNavigationController() {
        //navigationController?.title = navigationLoginTitle
    }
    
    func setupMainLoginLabel() {
        view.addSubview(mainLoginLabel)
        
        mainLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLoginLabel.text = "Welcome to Tamang\nFood Services"
        mainLoginLabel.numberOfLines = 2
        mainLoginLabel.textAlignment = .left
        mainLoginLabel.font = UIFont(name: "AvenirNext-Regular", size: 33)
        mainLoginLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainLoginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            mainLoginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            mainLoginLabel.widthAnchor.constraint(equalToConstant: 338),
            mainLoginLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupSubLoginLabel() {
        view.addSubview(subLoginLabel)
        
        subLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        subLoginLabel.text = "Enter your Phone number or Email address\nfor sign in. Enjoy your food :)"
        subLoginLabel.numberOfLines = 2
        subLoginLabel.textAlignment = .left
        subLoginLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subLoginLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subLoginLabel.topAnchor.constraint(equalTo: mainLoginLabel.bottomAnchor, constant: -10),
            subLoginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            subLoginLabel.widthAnchor.constraint(equalToConstant: 338),
            subLoginLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setupEmailLoginTextField() {
        view.addSubview(emailLoginTextField)
        
        emailLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLoginTextField.topAnchor.constraint(equalTo: subLoginLabel.bottomAnchor, constant: 24),
            emailLoginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLoginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailLoginTextField.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupPasswordLoginTextField() {
        view.addSubview(passwordLoginTextField)
        
        passwordLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordLoginTextField.topAnchor.constraint(equalTo: emailLoginTextField.bottomAnchor, constant: 18),
            passwordLoginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLoginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordLoginTextField.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 12)
        forgotPasswordButton.setTitleColor(AppColors.badyTextGreyColor, for: .normal)
        forgotPasswordButton.setTitle("Forget Password?", for: .normal)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordLoginTextField.bottomAnchor, constant: 20),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func setupSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupNoAccountLabel() {
        view.addSubview(noAccountLabel)
        
        noAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        noAccountLabel.text = "Don’t have account?"
        noAccountLabel.textColor = AppColors.badyTextGreyColor
        noAccountLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
    }
    
    func setupNewAccountButton() {
        view.addSubview(newAccountButton)
        
        newAccountButton.translatesAutoresizingMaskIntoConstraints = false
        newAccountButton.setTitle("Create new account.", for: .normal)
        newAccountButton.setTitleColor(AppColors.accentOrangeColor, for: .normal)
        newAccountButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 12)
    }
    
    func setupCreateAccountStackView() {
        view.addSubview(createAccountStackView)
        
        createAccountStackView.translatesAutoresizingMaskIntoConstraints = false
        createAccountStackView.axis = .horizontal
        createAccountStackView.distribution = .fillEqually
        createAccountStackView.spacing = 8
        
        NSLayoutConstraint.activate([
            createAccountStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            createAccountStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            createAccountStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            createAccountStackView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        createAccountStackView.addArrangedSubview(noAccountLabel)
        createAccountStackView.addArrangedSubview(newAccountButton)
    }
    
    func setupOrLabel() {
        view.addSubview(orLabel)
        
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.text = "Or"
        orLabel.textColor = AppColors.mainBlackColor
        orLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        orLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: createAccountStackView.bottomAnchor, constant: 20),
            orLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 168),
            orLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -168),
            orLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    func setupFacebookButton() {
        view.addSubview(facebookButton)
        
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.action = { [weak self] in
            guard let self = self else { return }
            self.facebookButtonPressed()
        }
    }
    
    func setupGoogleButton() {
        view.addSubview(googleButton)
        
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.action = { [weak self] in
            guard let self = self else { return }
            self.googleButtonPressed()
        }
    }
    
    func setupSocialButtonsStackView() {
        view.addSubview(socialButtonsStackView)
        
        socialButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        socialButtonsStackView.axis = .vertical
        socialButtonsStackView.distribution = .fillEqually
        socialButtonsStackView.spacing = 12
        
        NSLayoutConstraint.activate([
            socialButtonsStackView.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 24),
            socialButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            socialButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            socialButtonsStackView.heightAnchor.constraint(equalToConstant: 104)
        ])
        
        socialButtonsStackView.addArrangedSubview(facebookButton)
        socialButtonsStackView.addArrangedSubview(googleButton)
    }
    
    func setupLoaderView() {
        view.addSubview(loaderView)
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.isHidden = true
        
        NSLayoutConstraint.activate([
            loaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            loaderView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
// MARK: - RxSwift
private extension LoginViewController {
    func rxBindings() {
        inputBindings()
        outputBindings()
    }
    
    func inputBindings() {
        emailLoginTextField.textField.rx.text.orEmpty.bind(to: viewModel.inputs.emailText).disposed(by: disposeBag)
        passwordLoginTextField.textField.rx.text.orEmpty.bind(to: viewModel.inputs.passwordText).disposed(by: disposeBag)
        
        signInButton.button.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.signInButtonTapped()
        }.disposed(by: disposeBag)
        
        passwordLoginTextField.passwordVisibilityButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.updatePasswordVisibility()
        }.disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.forgotPasswordButtonTapped()
        }.disposed(by: disposeBag)
        
        newAccountButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.newAccountButtonTapped()
        }.disposed(by: disposeBag)
    }
    
    func outputBindings() {
        viewModel.outputs.isValidEmail
            .subscribe(onNext:  { [weak self] isValid in
                guard let self = self else { return }
                let targetColor: UIColor = isValid ? AppColors.accentOrangeColor : AppColors.badyTextGreyColor
                self.animateColorChange(of: self.emailLoginTextField.checkmarkImage, to: targetColor)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.outputs.passwordVisibilityChanged
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.animatePasswordVisibilityChange()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.startLoader
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.loaderView.animateLoader(start: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.stopLoader
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.loaderView.animateLoader(start: false)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.shakeEmailTextField
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.emailLoginTextField.textField.shakeWithColorChange()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.shakePasswordTextField
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.passwordLoginTextField.textField.shakeWithColorChange()
            })
            .disposed(by: disposeBag)
    }
}
// MARK: - Animating Methods
private extension LoginViewController {
    func animateColorChange(of view: UIView, to color: UIColor) {
        UIView.animate(withDuration: 0.3) {
            view.tintColor = color
        }
    }
    
    func animatePasswordVisibilityChange() {
        UIView.transition(with: passwordLoginTextField.textField, 
                          duration: 0.2,
                          options: .transitionCrossDissolve) {
            self.passwordLoginTextField.textField.isSecureTextEntry.toggle()
        }
        
        let newImage: UIImage = passwordLoginTextField.textField.isSecureTextEntry ? .invisible : .visible
        
        UIView.transition(with: passwordLoginTextField.passwordVisibilityButton,
                          duration: 0.2,
                          options: .transitionCrossDissolve) {
            self.passwordLoginTextField.passwordVisibilityButton.setImage(newImage, for: .normal)
        }
    }
}

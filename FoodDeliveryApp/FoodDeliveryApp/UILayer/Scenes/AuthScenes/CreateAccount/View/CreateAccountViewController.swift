import UIKit
import RxSwift
import RxCocoa

class CreateAccountViewController: KeyboardDismissViewController {
    // MARK: - Views
    private let navigationSignUpTitle = "Sign Up"
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
    private let facebookButton = FDSocialButton(type: .facebook)
    private let googleButton = FDSocialButton(type: .google)
    private let socialButtonsStackView = UIStackView()
    private let loaderView = FDLoaderView()
    // MARK: - Properties
    private var viewModel: CreateAccountViewModelType
    private let disposeBag = DisposeBag()
    // MARK: - Init
    init(viewModel: CreateAccountViewModelType) {
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
        setupLoaderView()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.inputWhiteColor
    }
    
    func setupNavigationController() {
        navigationController?.title = navigationSignUpTitle
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
private extension CreateAccountViewController {
    
        func rxBindings() {
            inputBindings()
            outputBindings()
        }
        
        func inputBindings() {
            nameSignUpTextField.textField.rx.text.orEmpty.bind(to: viewModel.inputs.fullNameText).disposed(by: disposeBag)
            emailSignUpTextField.textField.rx.text.orEmpty.bind(to: viewModel.inputs.emailText).disposed(by: disposeBag)
            passwordSignUpTextField.textField.rx.text.orEmpty.bind(to: viewModel.inputs.passwordText).disposed(by: disposeBag)
            
            signUpButton.button.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.viewModel.inputs.signUpButtonTapped()
            }.disposed(by: disposeBag)
            
            passwordSignUpTextField.passwordVisibilityButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.viewModel.inputs.updatePasswordVisibility()
            }.disposed(by: disposeBag)
        }
        
        func outputBindings() {
            viewModel.outputs.isValidName
                .subscribe(onNext:  { [weak self] isValid in
                    guard let self = self else { return }
                    let targetColor: UIColor = isValid ? AppColors.accentOrangeColor : AppColors.badyTextGreyColor
                    self.animateColorChange(of: self.nameSignUpTextField.checkmarkImage, to: targetColor)
                })
                .disposed(by: disposeBag)
            
            viewModel.outputs.isValidEmail
                .subscribe(onNext:  { [weak self] isValid in
                    guard let self = self else { return }
                    let targetColor: UIColor = isValid ? AppColors.accentOrangeColor : AppColors.badyTextGreyColor
                    self.animateColorChange(of: self.emailSignUpTextField.checkmarkImage, to: targetColor)
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
                    self.animateLoader(start: true)
                })
                .disposed(by: disposeBag)
            
            viewModel.outputs.stopLoader
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.animateLoader(start: false)
                })
                .disposed(by: disposeBag)
            
            viewModel.outputs.shakeFullNameTextField
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.nameSignUpTextField.textField.shakeWithColorChange()
                })
                .disposed(by: disposeBag)
            
            viewModel.outputs.shakeEmailTextField
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.emailSignUpTextField.textField.shakeWithColorChange()
                })
                .disposed(by: disposeBag)
            
            viewModel.outputs.shakePasswordTextField
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.passwordSignUpTextField.textField.shakeWithColorChange()
                })
                .disposed(by: disposeBag)
        }
    }
    // MARK: - Animating Methods
    private extension CreateAccountViewController {
        func animateColorChange(of view: UIView, to color: UIColor) {
            UIView.animate(withDuration: 0.3) {
                view.tintColor = color
            }
        }
        
        func animatePasswordVisibilityChange() {
            UIView.transition(with: passwordSignUpTextField.textField,
                              duration: 0.2,
                              options: .transitionCrossDissolve) {
                self.passwordSignUpTextField.textField.isSecureTextEntry.toggle()
            }
            
            let newImage: UIImage = passwordSignUpTextField.textField.isSecureTextEntry ? .invisible : .visible
            
            UIView.transition(with: passwordSignUpTextField.passwordVisibilityButton,
                              duration: 0.2,
                              options: .transitionCrossDissolve) {
                self.passwordSignUpTextField.passwordVisibilityButton.setImage(newImage, for: .normal)
            }
        }
        
        func animateLoader(start: Bool) {
            UIView.animate(withDuration: 0.3) {
                self.loaderView.isHidden = !start
                if start {
                    self.loaderView.startLoader()
                } else {
                    self.loaderView.stopLoader()
                }
            }
        }
    }

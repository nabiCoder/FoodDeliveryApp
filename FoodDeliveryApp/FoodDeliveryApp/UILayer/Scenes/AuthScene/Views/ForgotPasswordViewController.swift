import UIKit

class ForgotPasswordViewController: UIViewController {
    // MARK: - Views
    private let navigationForgotPasswordTitle = "Forgot Password"
    private let mainForgotPasswordLabel = UILabel()
    private let subForgotPasswordLabel = UILabel()
    private let emailForgotPasswordTextField = FDTextField(fildType: .email, fieldLabelText: "EMAIL ADDRESS")
    private let resetPasswordButton = FDButton(titleType: .resetPassword)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    // MARK: - @objc
    
}
// MARK: - Extension methods
private extension ForgotPasswordViewController {
    func setupLayout() {
        setupView()
        setupNavigationController()
        setupMainForgotPasswordLabel()
        setupSubForgotPasswordLabel()
        setupEmailForgotPasswordTextField()
        setupResetPasswordButton()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundWhiteColor
    }
    
    func setupNavigationController() {
        navigationController?.title = navigationForgotPasswordTitle
    }
    
    func setupMainForgotPasswordLabel() {
        view.addSubview(mainForgotPasswordLabel)
        
        mainForgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        mainForgotPasswordLabel.text = "Forgot password"
        mainForgotPasswordLabel.textAlignment = .left
        mainForgotPasswordLabel.font = UIFont(name: "AvenirNext-Regular", size: 34)
        mainForgotPasswordLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainForgotPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            mainForgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            mainForgotPasswordLabel.widthAnchor.constraint(equalToConstant: 263),
            mainForgotPasswordLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupSubForgotPasswordLabel() {
        view.addSubview(subForgotPasswordLabel)
        
        subForgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        subForgotPasswordLabel.text = "Enter your email address and we\nwill send you a reset instructions."
        subForgotPasswordLabel.numberOfLines = 2
        subForgotPasswordLabel.textAlignment = .left
        subForgotPasswordLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subForgotPasswordLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subForgotPasswordLabel.topAnchor.constraint(equalTo: mainForgotPasswordLabel.bottomAnchor, constant: 14),
            subForgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            subForgotPasswordLabel.widthAnchor.constraint(equalToConstant: 280),
            subForgotPasswordLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupEmailForgotPasswordTextField() {
        view.addSubview(emailForgotPasswordTextField)
        
        emailForgotPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailForgotPasswordTextField.topAnchor.constraint(equalTo: subForgotPasswordLabel.bottomAnchor,
                                                              constant: 34),
            emailForgotPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailForgotPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailForgotPasswordTextField.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupResetPasswordButton() {
        view.addSubview(resetPasswordButton)
        
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
//        resetPasswordButton.action = signInButtonPressed
        
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailForgotPasswordTextField.bottomAnchor, constant: 24),
            resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

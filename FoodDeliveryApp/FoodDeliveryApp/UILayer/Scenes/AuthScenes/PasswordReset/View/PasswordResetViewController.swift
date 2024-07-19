import UIKit
import RxSwift
import RxCocoa

class PasswordResetViewController: KeyboardDismissViewController {
    // MARK: - Views
    private let navigationTitle = "Forgot Password"
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let emailTextField = FDTextField(fildType: .email, fieldLabelText: "EMAIL ADDRESS")
    private let resetPasswordButton = FDButton(titleType: .resetPassword)
    // MARK: - Properties
    private var viewModel: PasswordResetViewModelType
    private let disposeBag = DisposeBag()
    // MARK: - Init
    init(viewModel: PasswordResetViewModelType) {
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
    @objc private func resetPasswordButtonPressed() {
        
    }
}
// MARK: - Extension methods
private extension PasswordResetViewController {
    func setupLayout() {
        setupView()
        setupNavigationController()
        setupMainLabel()
        setupSubLabel()
        setupEmailTextField()
        setupResetPasswordButton()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.inputWhiteColor
    }
    
    func setupNavigationController() {
        navigationController?.title = navigationTitle
    }
    
    func setupMainLabel() {
        view.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = "Forgot password"
        mainLabel.textAlignment = .left
        mainLabel.font = UIFont(name: "AvenirNext-Regular", size: 34)
        mainLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            mainLabel.widthAnchor.constraint(equalToConstant: 263),
            mainLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupSubLabel() {
        view.addSubview(subLabel)
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "Enter your email address and we\nwill send you a reset instructions."
        subLabel.numberOfLines = 2
        subLabel.textAlignment = .left
        subLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 14),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            subLabel.widthAnchor.constraint(equalToConstant: 280),
            subLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupEmailTextField() {
        view.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: subLabel.bottomAnchor,
                                                constant: 34),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupResetPasswordButton() {
        view.addSubview(resetPasswordButton)
        
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.action = resetPasswordButtonPressed
        
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
// MARK: - RxSwift
private extension PasswordResetViewController {
    func rxBindings() {
        inputBindings()
        outputBindings()
    }
    
    func inputBindings() {
        emailTextField.textField.rx.text.orEmpty.bind(to: viewModel.inputs.emailText).disposed(by: disposeBag)
        
        resetPasswordButton.button.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.resetButtonTapped()
        }.disposed(by: disposeBag)
    }
    
    func outputBindings() {
        viewModel.outputs.isValidEmail
            .subscribe(onNext:  { [weak self] isValid in
                guard let self = self else { return }
                let targetColor: UIColor = isValid ? AppColors.accentOrangeColor : AppColors.badyTextGreyColor
                self.animateColorChange(of: self.emailTextField.checkmarkImage, to: targetColor)
            })
            .disposed(by: disposeBag)
    
        viewModel.outputs.shakeEmailTextField
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.emailTextField.textField.shakeWithColorChange()
            })
            .disposed(by: disposeBag)
    }
}
// MARK: - Animating Methods
private extension PasswordResetViewController {
    func animateColorChange(of view: UIView, to color: UIColor) {
        UIView.animate(withDuration: 0.3) {
            view.tintColor = color
        }
    }
}

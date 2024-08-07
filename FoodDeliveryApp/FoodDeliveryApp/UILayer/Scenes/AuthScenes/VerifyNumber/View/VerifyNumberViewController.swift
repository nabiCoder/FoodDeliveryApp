import UIKit
import RxSwift
import RxCocoa

class VerifyNumberViewController: KeyboardDismissViewController {
    // MARK: - Views
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let navigationTitle = "Login to Foodly"
    private let verifyTextField = FDCodeVerifyView()
    private let continueButton = FDButton(titleType: .continueTitle)
    private let instructionLabel = UILabel()
    private let resendButton = UIButton()
    private let instructionButtonStackView = UIStackView()
    private let joinAgreementButton = UIButton()
    // MARK: - Properties
    private var viewModel: VerifyNumberViewModelType
    private let disposeBag = DisposeBag()
    private var phoneNumber = String()
    // MARK: - Init
    init(viewModel: VerifyNumberViewModelType, phoneNumber: String) {
        self.viewModel = viewModel
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        verifyTextField.verifyDelegate = self
        rxBindings()
        setupNavBar()
    }
    // MARK: - @objc
    @objc private func resendButtonPressed() {
        print("resendButtonPressed")
    }
    @objc private func joinAgreementButtonPressed() {
        print("joinAgreementButtonPressed")
    }
}
// MARK: - Extension methods
private extension VerifyNumberViewController {
    func setupLayout() {
        setupView()
        setupNavigationController()
        setupMainLabel()
        setupSubLabel()
        setupVerifyTextField()
        setupContinueButton()
        setupInstructionLabel()
        setupResendButton()
        setupInstructionButtonStackView()
        setupJoinAgreementButton()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.inputWhiteColor
    }
    
    func setupNavigationController() {
        title = navigationTitle
    }
    
    func setupMainLabel() {
        view.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = "Verify phone number"
        mainLabel.textAlignment = .center
        mainLabel.font = UIFont(name: "AvenirNext-Regular", size: 24)
        mainLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            mainLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupSubLabel() {
        view.addSubview(subLabel)
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "Enter the 4-Digit code sent to you at\n\(phoneNumber)"
        subLabel.numberOfLines = 2
        subLabel.textAlignment = .center
        subLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            subLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupVerifyTextField() {
        view.addSubview(verifyTextField)
        
        verifyTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verifyTextField.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 40),
            verifyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            verifyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            verifyTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 125),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupInstructionLabel() {
        view.addSubview(instructionLabel)
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.text = "Didn’t receive code?"
        instructionLabel.textColor = AppColors.badyTextGreyColor
        instructionLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
    }
    
    func setupResendButton() {
        view.addSubview(resendButton)
        
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        resendButton.setTitle("Resend Again.", for: .normal)
        resendButton.setTitleColor(AppColors.accentOrangeColor, for: .normal)
        resendButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 12)
        resendButton.addTarget(self,
                               action: #selector(resendButtonPressed),
                               for: .touchUpInside)
    }
    
    func setupInstructionButtonStackView() {
        view.addSubview(instructionButtonStackView)
        
        instructionButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        instructionButtonStackView.axis = .horizontal
        instructionButtonStackView.distribution = .fillEqually
        instructionButtonStackView.spacing = 8
        
        NSLayoutConstraint.activate([
            instructionButtonStackView.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            instructionButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            instructionButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            instructionButtonStackView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        instructionButtonStackView.addArrangedSubview(instructionLabel)
        instructionButtonStackView.addArrangedSubview(resendButton)
    }
    
    func setupJoinAgreementButton() {
        view.addSubview(joinAgreementButton)
        
        joinAgreementButton.translatesAutoresizingMaskIntoConstraints = false
        joinAgreementButton.titleLabel?.numberOfLines = 2
        joinAgreementButton.titleLabel?.textAlignment = .center
        joinAgreementButton.setTitle("By Signing up you agree to our Terms\nConditions & Privacy Policy.", for: .normal)
        joinAgreementButton.setTitleColor(AppColors.badyTextGreyColor, for: .normal)
        joinAgreementButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        joinAgreementButton.addTarget(self,
                                      action: #selector(joinAgreementButtonPressed),
                                      for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            joinAgreementButton.topAnchor.constraint(equalTo: instructionButtonStackView.bottomAnchor, constant: 34),
            joinAgreementButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            joinAgreementButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            joinAgreementButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
extension VerifyNumberViewController: VerifyProtocol {
    func verify() {
        //viewModel.inputs.continueButtonTapped()
        let combinedText = verifyTextField.codeTextFields.map { $0.text ?? "" }.joined()
        // Обновляем verifyCode вручную перед вызовом handleContinueButtonTapped
        viewModel.inputs.verifyCode.accept(combinedText)
        // Вызываем действие продолжения
        viewModel.inputs.continueButtonTapped()
    }
}

private extension VerifyNumberViewController {
    func rxBindings() {
        inputBindings()
        outputBindings()
    }
    
    func inputBindings() {
        let textFieldObservables = verifyTextField.codeTextFields.map({$0.rx.text.orEmpty.asObservable()})
        
        Observable.combineLatest(textFieldObservables) { textValues in
            textValues.joined()
        }
        .bind(to: viewModel.inputs.verifyCode)
        .disposed(by: disposeBag)
        
        continueButton.button.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.continueButtonTapped()
        }.disposed(by: disposeBag)
    }
    
    func outputBindings() {
        viewModel.outputs.shakeVerifyNumberTextFields
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.verifyTextField.codeTextFields.forEach({
                    $0.shakeWithColorChange()
                })
            })
            .disposed(by: disposeBag)
    }
}

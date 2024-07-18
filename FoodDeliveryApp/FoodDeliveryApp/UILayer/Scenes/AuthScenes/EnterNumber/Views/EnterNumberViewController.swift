import UIKit

class EnterNumberViewController: KeyboardDismissViewController {
    // MARK: - Views
    private let navigationTitle = "Forgot Password"
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let phoneNumberTextField = FDPhoneNumberTextField(flagType: .usa)
    private let signUpButton = FDButton(titleType: .signUp)
    // MARK: - Properties
    private let popUp = PopUpView(data: [CountryCodes(name: "Russia", dialCode: "+7", code: "RU"),
                                         CountryCodes(name: "USA", dialCode: "+1", code: "US"),
                                         CountryCodes(name: "Kazakhstan", dialCode: "+76", code: "KZ")])
    private var enterNumberViewOutput: EnterNumberViewOutput?
    private var isKeyboardShow = false
    // MARK: - Constraints
    private var bottomCTValue: CGFloat = 0.0
    private var signUpButtonButtonCT = NSLayoutConstraint()
    // MARK: - Init
    init(enterNumberViewOutput: EnterNumberViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.enterNumberViewOutput = enterNumberViewOutput
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopKeyboardListener()
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupListener()
    }
    // MARK: - @objc
    @objc private func signUpButtonPressed() {
        
    }
    @objc private func popUpButtonPressed() {
        popUp.toggleVisibility(withDuration: 0.4)
    }
}
// MARK: - Extension methods
private extension EnterNumberViewController {
    func setupLayout() {
        setupView()
        setupNavigationController()
        setupMainLabel()
        setupSubLabel()
        setupPhoneNumberTextField()
        setupSignUpButton()
        setupPopUpView()
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
        mainLabel.text = "Get started with Foodly"
        mainLabel.textAlignment = .left
        mainLabel.font = UIFont(name: "AvenirNext-Bold", size: 24)
        mainLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            mainLabel.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    func setupSubLabel() {
        view.addSubview(subLabel)
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "Enter your phone number to use foodly and\nenjoy your food :)"
        subLabel.numberOfLines = 2
        subLabel.textAlignment = .center
        subLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            subLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupPhoneNumberTextField() {
        view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.action = popUpButtonPressed
        
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: subLabel.bottomAnchor,
                                                      constant: 34),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.action = signUpButtonPressed
        bottomCTValue = -30
        signUpButtonButtonCT = signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                    constant: bottomCTValue)
        
        NSLayoutConstraint.activate([
            signUpButtonButtonCT,
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupPopUpView() {
        view.addSubview(popUp)
        popUp.translatesAutoresizingMaskIntoConstraints = false
        popUp.layer.cornerRadius = 8
        popUp.isHidden = true
        
        NSLayoutConstraint.activate([
            popUp.topAnchor.constraint(equalTo: phoneNumberTextField.topAnchor),
            popUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            popUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            popUp.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
// MARK: - Keyboard Listener
private extension EnterNumberViewController {
    func setupListener() {
        startKeyboardListener()
    }

    func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height

        if !isKeyboardShow {
            UIView.animate(withDuration: 0.3) {
                self.signUpButtonButtonCT.constant -= keyboardHeight
                self.view.layoutIfNeeded()
                self.isKeyboardShow = true
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShow {
            UIView.animate(withDuration: 0.3) {
                self.signUpButtonButtonCT.constant = self.bottomCTValue
                self.view.layoutIfNeeded()
                self.isKeyboardShow = false
            }
        }
    }
}
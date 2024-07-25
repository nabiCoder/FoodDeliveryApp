import UIKit
import RxSwift
import RxCocoa

class EnterNumberViewController: KeyboardDismissViewController {
    // MARK: - Views
    private let navigationTitle = "Forgot Password"
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let phoneNumberTextField = FDPhoneNumberTextField(flagType: .usa)
    private let signUpButton = FDButton(titleType: .signUp)
    private let popUp = PopUpView()
    private let loaderView = FDLoaderView()
    // MARK: - Properties
    private var viewModel: EnterNumberViewModelType
    private var isKeyboardShow = false
    private let disposeBag = DisposeBag()
    // MARK: - Constraints
    private var bottomCTValue: CGFloat = 0.0
    private var signUpButtonButtonCT = NSLayoutConstraint()
    // MARK: - Init
    init(viewModel: EnterNumberViewModelType) {
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
        setupListener()
        rxBindings()
    }
    
    override func handleTap(_ sender: UITapGestureRecognizer) {
        super.handleTap(sender)
        let tapLocation = sender.location(in: view)
        
        let isTapOutsidePhoneNumberTextField = !phoneNumberTextField.frame.contains(tapLocation)
        let isTapOutsidePopUp = !popUp.frame.contains(tapLocation)
        
        if isTapOutsidePhoneNumberTextField && isTapOutsidePopUp {
            dismissPopUp()
        }
    }
    
    
    private func dismissPopUp() {
        if !popUp.isHidden {
            phoneNumberTextField.rotateButtonImage()
            self.popUp.animateTransition {
                self.popUp.isHidden = true
            }
        }
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
        setupLoaderView()
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
// MARK: - RxSwift
private extension EnterNumberViewController {
    func rxBindings() {
        bindTableView()
        inputBindings()
        outputBindings()
    }
    
    func bindTableView() {
        viewModel.outputs.countries
            .bind(to: popUp.tableView.rx.items(cellIdentifier: PopUpCell.identifier,
                                               cellType: PopUpCell.self)) { row, item, cell in
                cell.configure(with: item)
            }
                                               .disposed(by: disposeBag)
        
        popUp.tableView.rx.modelSelected(CountryCode.self)
            .bind(to: viewModel.inputs.selectedCountry)
            .disposed(by: disposeBag)
        
        viewModel.inputs.selectedCountry
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.dismissPopUp()
                self.phoneNumberTextField.changeFlagImage(imageName: item.code)
                self.phoneNumberTextField.changeCountryCode(code: item.dialCode)
            })
            .disposed(by: disposeBag)
    }
    
    func inputBindings() {
        phoneNumberTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.inputs.phoneNumberText)
            .disposed(by: disposeBag)
        
        signUpButton.button.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.signUpButtonTapped()
        }.disposed(by: disposeBag)
        
        phoneNumberTextField.selectCountryButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.viewModel.inputs.selectCountryButtonTapped()
        }.disposed(by: disposeBag)
    }
    
    func outputBindings() {
        viewModel.outputs.selectCountryButtonTap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.phoneNumberTextField.rotateButtonImage()
                self.popUp.animateTransition {
                    self.popUp.isHidden.toggle()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.shakePhoneNumberTextField
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.phoneNumberTextField.textField.shakeWithColorChange()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.formattedPhoneNumber
            .bind(to: phoneNumberTextField.textField.rx.text)
            .disposed(by: disposeBag)
    }
}


import Foundation
import RxSwift
import RxCocoa

protocol LoginViewOutput: AnyObject {
    var startLoader: PublishSubject<Void> { get }
    var stopLoader: PublishSubject<Void> { get }
    var shakeEmailTextField: PublishSubject<Void> { get }
    var shakePasswordTextField: PublishSubject<Void> { get }
    var isValidEmail: Observable<Bool> { get }
    var passwordVisibilityChanged: PublishSubject<Void> { get }
}

protocol LoginViewInput: AnyObject {
    var emailText: BehaviorRelay<String> { get }
    var passwordText: BehaviorRelay<String> { get }
    
    func signInButtonTapped()
    func updatePasswordVisibility()
    func forgotPasswordButtonTapped()
    func newAccountButtonTapped()
}

protocol MyViewModelType {
    var inputs: LoginViewInput { get }
    var outputs: LoginViewOutput { get }
}

class LoginViewModel: LoginViewInput, LoginViewOutput, MyViewModelType {
    
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
    // MARK: - LoginViewModel Methods
    private func authenticateUser() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                self.stopLoader.onNext(())
                self.authCoordinator?.finish()
            }
        }
    }
    
    private func showError() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.stopLoader.onNext(())
            print("неверный емайл или пароль!")
        }
    }
    
    // MARK: - LoginViewInput
    var emailText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    
    func signInButtonTapped() {
        guard !emailText.value.isEmpty else {
            shakeEmailTextField.onNext(())
            if passwordText.value.isEmpty {
                shakePasswordTextField.onNext(())
            }
            return
        }
        
        guard emailText.value.isEmail else {
            shakeEmailTextField.onNext(())
            if passwordText.value.isEmpty {
                shakePasswordTextField.onNext(())
            }
            return
        }
        
        guard !passwordText.value.isEmpty else {
            shakePasswordTextField.onNext(())
            return
        }
        
        startLoader.onNext(())
        
        if emailText.value == "admin@mail.ru" && passwordText.value == "admin" {
            authenticateUser()
        } else {
            showError()
        }
    }
    
    func updatePasswordVisibility() {
        passwordVisibilityChanged.onNext(())
    }
    
    func forgotPasswordButtonTapped() {
        authCoordinator?.goToPasswordReset()
    }
    
    func newAccountButtonTapped() {
        authCoordinator?.goToCreateAccount()
    }
    // MARK: - LoginViewOutput
    var startLoader = RxSwift.PublishSubject<Void>()
    var stopLoader = RxSwift.PublishSubject<Void>()
    var shakeEmailTextField = PublishSubject<Void>()
    var shakePasswordTextField = PublishSubject<Void>()
    
    var isValidEmail: Observable<Bool> {
        return emailText
            .map { _ in
                self.emailText.value.isEmail
            }
            .asObservable()
    }
    
    var passwordVisibilityChanged = RxSwift.PublishSubject<Void>()
    // MARK: - MyViewModelType
    var inputs: LoginViewInput { return self }
    var outputs: LoginViewOutput { return self }
}

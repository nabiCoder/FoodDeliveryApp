import Foundation
import RxSwift
import RxCocoa

protocol CreateAccountViewOutput: AnyObject {
    var startLoader: PublishSubject<Void> { get }
    var stopLoader: PublishSubject<Void> { get }
    var shakeFullNameTextField: PublishSubject<Void> { get }
    var shakeEmailTextField: PublishSubject<Void> { get }
    var shakePasswordTextField: PublishSubject<Void> { get }
    var isValidName: Observable<Bool> { get }
    var isValidEmail: Observable<Bool> { get }
    var passwordVisibilityChanged: PublishSubject<Void> { get }
}

protocol CreateAccountViewInput: AnyObject {
    var fullNameText: BehaviorRelay<String> { get }
    var emailText: BehaviorRelay<String> { get }
    var passwordText: BehaviorRelay<String> { get }
    
    func signUpButtonTapped()
    func updatePasswordVisibility()
}

protocol CreateAccountViewModelType {
    var inputs: CreateAccountViewInput { get }
    var outputs: CreateAccountViewOutput { get }
}

class CreateAccountViewModel: CreateAccountViewModelType, CreateAccountViewInput, CreateAccountViewOutput {
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
                self.authCoordinator?.goToEnterNumber()
            }
        }
    }
    // MARK: - LoginViewInput
    var fullNameText = BehaviorRelay<String>(value: "")
    var emailText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    
    func signUpButtonTapped() {
        var validationFailed = false
        if !fullNameText.value.isFullName {
            shakeFullNameTextField.onNext(())
            validationFailed = true
        }
        
        if !emailText.value.isEmail {
            shakeEmailTextField.onNext(())
            validationFailed = true
        }
        
        if passwordText.value.isEmpty {
            shakePasswordTextField.onNext(())
            validationFailed = true
        }
        if validationFailed {
            return
        }
        
        startLoader.onNext(())
        print("Ваше имя - \(fullNameText.value)")
        print("Ваш емайл - \(emailText.value)")
        print("Ваш пароль - \(passwordText.value)")
        authenticateUser()
    }
    
    func updatePasswordVisibility() {
        passwordVisibilityChanged.onNext(())
    }
    // MARK: - LoginViewOutput
    var startLoader = RxSwift.PublishSubject<Void>()
    var stopLoader = RxSwift.PublishSubject<Void>()
    var shakeFullNameTextField = PublishSubject<Void>()
    var shakeEmailTextField = PublishSubject<Void>()
    var shakePasswordTextField = PublishSubject<Void>()
    
    var isValidName: Observable<Bool> {
        return fullNameText
            .map { _ in
                self.fullNameText.value.isFullName
            }
            .asObservable()
    }
    
    var isValidEmail: Observable<Bool> {
        return emailText
            .map { _ in
                self.emailText.value.isEmail
            }
            .asObservable()
    }
    
    var passwordVisibilityChanged = RxSwift.PublishSubject<Void>()
    // MARK: - LoginViewModelType
    var inputs: CreateAccountViewInput { return self }
    var outputs: CreateAccountViewOutput { return self }
}

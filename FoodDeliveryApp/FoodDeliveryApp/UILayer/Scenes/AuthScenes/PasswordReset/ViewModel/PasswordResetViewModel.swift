import Foundation
import RxSwift
import RxCocoa

protocol PasswordResetViewOutput: AnyObject {
    var shakeEmailTextField: PublishSubject<Void> { get }
    var isValidEmail: Observable<Bool> { get }
    var passwordVisibilityChanged: PublishSubject<Void> { get }
}

protocol PasswordResetViewInput: AnyObject {
    var emailText: BehaviorRelay<String> { get }
    
    func resetButtonTapped()
}

protocol PasswordResetViewModelType {
    var inputs: PasswordResetViewInput { get }
    var outputs: PasswordResetViewOutput { get }
}

class PasswordResetViewModel: PasswordResetViewModelType, PasswordResetViewInput, PasswordResetViewOutput {
    
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
    // MARK: - PasswordResetViewOutput
    var shakeEmailTextField = PublishSubject<Void>()
    
    var isValidEmail: Observable<Bool> {
        return emailText
            .map { _ in
                self.emailText.value.isEmail
            }
            .asObservable()
    }
    
    var passwordVisibilityChanged = RxSwift.PublishSubject<Void>()
    
    // MARK: - PasswordResetViewInput
    var emailText = BehaviorRelay<String>(value: "")
    
    func resetButtonTapped() {
        guard !emailText.value.isEmpty else {
            shakeEmailTextField.onNext(())
            return
        }
        
        if emailText.value.isEmail {
            let email = emailText.value
            authCoordinator?.goToPasswordResetSuccess(email: email)
        } else {
            shakeEmailTextField.onNext(())
        }
    }
    
    // MARK: - MyViewModelType
    var inputs: PasswordResetViewInput { return self }
    var outputs: PasswordResetViewOutput { return self }
}

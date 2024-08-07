import Foundation
import RxSwift
import RxCocoa

protocol VerifyNumberViewOutput: AnyObject {
    var shakeVerifyNumberTextFields: PublishSubject<Void> { get }
}

protocol VerifyNumberViewInput: AnyObject {
    var verifyCode: BehaviorRelay<String> { get }
    func continueButtonTapped()
}

protocol VerifyNumberViewModelType {
    var inputs: VerifyNumberViewInput { get }
    var outputs: VerifyNumberViewOutput { get }
}

class VerifyNumberViewModel: VerifyNumberViewModelType, VerifyNumberViewInput, VerifyNumberViewOutput {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
    // MARK: - EnterNumberViewInput
    var verifyCode = BehaviorRelay<String>(value: "")
    
    func continueButtonTapped() {
        if verifyCode.value.count == 4 {
            authCoordinator?.finish()
        } else {
            shakeVerifyNumberTextFields.onNext(())
        }
    }
    // MARK: - EnterNumberViewOutput
    var shakeVerifyNumberTextFields = PublishSubject<Void>()
    // MARK: - LoginViewModelType
    var inputs: VerifyNumberViewInput { return self }
    var outputs: VerifyNumberViewOutput { return self }
}

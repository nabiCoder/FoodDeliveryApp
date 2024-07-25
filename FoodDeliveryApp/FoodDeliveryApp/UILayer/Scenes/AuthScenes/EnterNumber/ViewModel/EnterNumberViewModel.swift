import Foundation
import RxSwift
import RxCocoa

protocol EnterNumberViewOutput: AnyObject {
    var shakePhoneNumberTextField: PublishSubject<Void> { get }
    var countries: BehaviorRelay<[CountryCode]> { get }
    var formattedPhoneNumber: Observable<String> { get }
    var selectCountryButtonTap: PublishSubject<Void> { get }
}

protocol EnterNumberViewInput: AnyObject {
    var phoneNumberText: BehaviorRelay<String> { get }
    var selectedCountry: PublishSubject<CountryCode> { get }
    
    func selectCountryButtonTapped()
    func signUpButtonTapped()
}

protocol EnterNumberViewModelType {
    var inputs: EnterNumberViewInput { get }
    var outputs: EnterNumberViewOutput { get }
}

class EnterNumberViewModel: EnterNumberViewModelType, EnterNumberViewInput, EnterNumberViewOutput {
    // MARK: - Properties
    weak var authCoordinator: AuthCoordinator?
    var countries: BehaviorRelay<[CountryCode]>
    // MARK: - Init
    init(authCoordinator: AuthCoordinator, countries: [CountryCode]) {
        self.authCoordinator = authCoordinator
        self.countries = BehaviorRelay(value: countries)
    }
    // MARK: - EnterNumberViewInput
    var phoneNumberText = BehaviorRelay<String>(value: "")
    var selectedCountry = PublishSubject<CountryCode>()
    
    func selectCountryButtonTapped() {
        selectCountryButtonTap.onNext(())
    }
    
    func signUpButtonTapped() {
        if !phoneNumberText.value.isPhoneNumber {
            shakePhoneNumberTextField.onNext(())
            return
        }
        
        authCoordinator?.goToVerifyNumber()
    }
    // MARK: - EnterNumberViewOutput
    var shakePhoneNumberTextField = PublishSubject<Void>()
    var selectCountryButtonTap = PublishSubject<Void>()
    
    var formattedPhoneNumber: Observable<String> {
        return phoneNumberText
            .map { text in
                text.formatPhoneNumber(withMask: "X (XXX) XXX-XXXX")
            }
            .distinctUntilChanged()
    }
    
    // MARK: - LoginViewModelType
    var inputs: EnterNumberViewInput { return self }
    var outputs: EnterNumberViewOutput { return self }
}

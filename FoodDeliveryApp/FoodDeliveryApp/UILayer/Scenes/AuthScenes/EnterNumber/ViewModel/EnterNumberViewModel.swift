import Foundation
import RxSwift
import RxCocoa
import UserNotifications

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
    
    func scheduleNotification() {
        // Создаем код из 4 цифр
        let code = String(format: "%04d", Int.random(in: 0...9999))
        // Создаем контент уведомления
        let content = UNMutableNotificationContent()
        content.title = "Verification Code"
        content.body = "Your verification code is \(code)"
        content.sound = .default
        // Настраиваем триггер на 15 секунд
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // Создаем запрос на уведомление
        let request = UNNotificationRequest(identifier: "VerificationCode", content: content, trigger: trigger)
        // Добавляем уведомление в центр уведомлений
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
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
        
        authCoordinator?.goToVerifyNumber(phoneNumber: phoneNumberText.value)
        scheduleNotification()
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

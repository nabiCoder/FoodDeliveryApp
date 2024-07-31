import Foundation
 
class AuthCoordinator: BaseCoordinator {
    
    private let faktory = SceneFactory.self
    private let userStorage = UserStorage.shared
    
    override func start() {
        showLogin()
    }
    
    override func finish() {
        print("AuthCoordinator finish")
        userStorage.passedAuth = true
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func goToPasswordReset() {
        showPasswordReset()
    }
    
    func goToCreateAccount() {
        showCreateAccount()
    }
    
    func goToPasswordResetSuccess(email: String) {
        showPasswordResetSuccess(email: email)
    }
    
    func goToEnterNumber() {
        showEnterNumber()
    }
    
    func goToVerifyNumber(phoneNumber: String) {
        showVerifyNumber(phoneNumber: phoneNumber)
    }
}
private extension AuthCoordinator {
    func showLogin() {
        let loginVC = faktory.makeLoginScene(coordinator: self)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func showCreateAccount() {
        let createAccountVC = faktory.makeCreateAccountScene(coordinator: self)
        navigationController?.pushViewController(createAccountVC, animated: true)
    }
    
    func showPasswordReset() {
        let loginViewController = faktory.makePasswordResetScene(coordinator: self)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showPasswordResetSuccess(email: String) {
        let loginViewController = faktory.makePasswordResetSuccessScene(coordinator: self, email: email)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showEnterNumber() {
        let loginViewController = faktory.makeEnterNumberScene(coordinator: self)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showVerifyNumber(phoneNumber: String) {
        let loginViewController = faktory.makeVerifyNumberScene(coordinator: self, phoneNumber: phoneNumber)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

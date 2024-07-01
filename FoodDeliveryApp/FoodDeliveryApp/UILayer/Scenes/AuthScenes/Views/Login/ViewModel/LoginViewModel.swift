import Foundation

protocol LoginViewOutput: AnyObject {
    
}

class LoginViewModel {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
}
// MARK: - Extensions
extension LoginViewModel: LoginViewOutput {
    
}

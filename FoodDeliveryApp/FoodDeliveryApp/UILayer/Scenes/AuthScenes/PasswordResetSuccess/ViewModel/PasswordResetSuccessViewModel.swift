import Foundation

protocol PasswordResetSuccessViewOutput: AnyObject {
    
}

class PasswordResetSuccessViewModel {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
}
// MARK: - Extension
extension PasswordResetSuccessViewModel: PasswordResetSuccessViewOutput {
    
}

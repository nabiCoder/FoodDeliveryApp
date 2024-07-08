import Foundation

protocol PasswordResetViewOutput: AnyObject {
    
}

class PasswordResetViewModel {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
}
// MARK: - Extension
extension PasswordResetViewModel: PasswordResetViewOutput {
    
}

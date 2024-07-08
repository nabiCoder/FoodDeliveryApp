import Foundation

protocol CreateAccountViewOutput: AnyObject {
    
}

class CreateAccountViewModel {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
}
// MARK: - Extensions
extension CreateAccountViewModel: CreateAccountViewOutput {
    
}

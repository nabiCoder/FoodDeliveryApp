import Foundation

protocol VerifyNumberViewOutput: AnyObject {
    
}

class VerifyNumberViewModel {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
}
// MARK: - Extensions
extension VerifyNumberViewModel: VerifyNumberViewOutput {
    
}

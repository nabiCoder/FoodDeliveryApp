import Foundation

protocol EnterNumberViewOutput: AnyObject {
    
}

class EnterNumberViewModel {
    // MARK: - Propertys
    weak var authCoordinator: AuthCoordinator?
    // MARK: - Init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
}
// MARK: - Extensions
extension EnterNumberViewModel: EnterNumberViewOutput {
    
}

import Foundation
 
class AuthCoordinator: BaseCoordinator {
    
    private let faktory = SceneFactory.self
    
    override func start() {
        showLogin()
    }
    
    override func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
private extension AuthCoordinator {
    func showLogin() {
        let loginViewController = faktory.makeLoginScene(coordinator: self)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

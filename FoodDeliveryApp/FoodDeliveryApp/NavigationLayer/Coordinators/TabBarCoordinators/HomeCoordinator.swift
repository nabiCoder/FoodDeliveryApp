import Foundation

class HomeCoordinator: BaseCoordinator {
    
    private let faktory = SceneFactory.self
    
    override func start() {
        showHomeScene()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
private extension HomeCoordinator {
    func showHomeScene() {
        let homeVC = faktory.makeHomeScene(coordinator: self)
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

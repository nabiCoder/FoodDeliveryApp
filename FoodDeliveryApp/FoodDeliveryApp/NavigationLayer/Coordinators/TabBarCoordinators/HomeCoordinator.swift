import Foundation

class HomeCoordinator: BaseCoordinator {
    
    override func start() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
private extension HomeCoordinator {
    func showHomeScene() {
        
    }
}

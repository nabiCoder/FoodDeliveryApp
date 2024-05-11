import UIKit

enum CoordinatorType {
    case app
    case onboarding
    case authorization
    case home
    case search
    case orders
    case profile
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    var navigationController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        let filteredChildCoordinators = childCoordinators.filter({ $0 !== childCoordinator })
        childCoordinators = filteredChildCoordinators
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

class Coordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]
    var type: CoordinatorType
    var navigationController: UINavigationController?
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(childCoordinators: [CoordinatorProtocol] = [],
         type: CoordinatorType,
         navigationController: UINavigationController,
         finishDelegate: CoordinatorFinishDelegate? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }
    
    deinit {
        print("Coordinator deinit")
        childCoordinators.forEach({ $0.finishDelegate = nil })
        childCoordinators.removeAll()
    }
    
    func start() {
        print("Coordinator start")
    }
    
    func finish() {
        print("Coordinator finish")
    }
}

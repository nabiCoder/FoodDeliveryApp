import Foundation

protocol HomeViewOutput {
    
}

protocol HomeViewInput {

}

protocol HomeViewModelType {
    var inputs: HomeViewInput { get }
    var outputs: HomeViewOutput { get }
}

struct HomeViewModel: HomeViewModelType, HomeViewOutput, HomeViewInput {
    // MARK: - Propertys
    weak var homeCoordinator: HomeCoordinator?
    // MARK: - Init
    init(homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator
    }
    // MARK: - LoginViewModelType
    var inputs: HomeViewInput { return self }
    var outputs: HomeViewOutput { return self }
}

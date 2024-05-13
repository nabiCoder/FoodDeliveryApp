import Foundation

protocol OnboardingViewOutput: AnyObject {
    func onboardingFinish()
}

class OnboardingViewModel {
    // MARK: - Propertys
    weak var onboardingCoordinator: OnboardingCoordinator?
    // MARK: - Init
    init(onboardingCoordinator: OnboardingCoordinator) {
        self.onboardingCoordinator = onboardingCoordinator
    }
}
// MARK: - Extensions
extension OnboardingViewModel: OnboardingViewOutput {
    func onboardingFinish() {
        onboardingCoordinator?.finish()
    }
}

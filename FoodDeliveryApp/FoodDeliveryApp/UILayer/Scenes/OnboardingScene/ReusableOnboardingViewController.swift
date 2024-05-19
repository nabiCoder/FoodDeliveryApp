import UIKit

enum OnboardingStep {
    case welcome
    case favorites
    case freeDelivery
    case foodChoice
}

class ReusableOnboardingViewController: UIViewController {
    // MARK: - Properties
    private var onboardinStep: OnboardingStep?
    
    init(isCircleImageView: Bool = false,
         onboardinStep: OnboardingStep) {
        super.init(nibName: nil, bundle: nil)
        self.onboardinStep = onboardinStep
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Views
    var circleImageView = UIImageView()
    var logoImageView = UIImageView()
    let headerLabel = UILabel()
    let illustrationImageView = UIImageView()
    let mainTextLabel = UILabel()
    let subTextLabel = UILabel()
    let multicoloredDotsImage = UIImageView()
    let foodVarietyImage = UIImageView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    // MARK: - Methods
    private func setupOnboardingImage() {
        switch onboardinStep {
        case .welcome:
            setupCircleImageView()
        case .freeDelivery:
            setupMulticoloredDotsImage()
        case .favorites:
            setupMulticoloredDotsImage()
        case .foodChoice:
            setupFoodVarietyImage()
        case .none:
            return
        }
    }
    
    private func rotateImageIfNeeded() {
        if onboardinStep == .favorites {
            let angleInRadians = 320 * CGFloat.pi / 180
            let rotationTransform = CGAffineTransform(rotationAngle: angleInRadians)
        
            multicoloredDotsImage.transform = rotationTransform
        }
    }
}
// MARK: - Extension
private extension ReusableOnboardingViewController {
    func setupLayout() {
        setupView()
        
        setupLogoImageView()
        setupHeaderLabel()
        setupIllustrationImageViewl()
        
        setupSubTextLabel()
        setupMainTextLabel()
    
        setupOnboardingImage()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundWhiteColor
    }
    
    func setupCircleImageView() {
        view.addSubview(circleImageView)
        
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        circleImageView.image = UIImage(resource: .circleBackground)
        circleImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            circleImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: -424),
            circleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -39)
        ])
    }
    
    func setupLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(resource: .logo)
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 25),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor,
                                               constant: 100)
        ])
    }
    
    func setupHeaderLabel() {
        view.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.textColor = AppColors.mainBlackColor
        headerLabel.font = UIFont(name: "AvenirNext-Bold", size: 37)
        headerLabel.text = "Tamang\nFoodService"
        headerLabel.numberOfLines = 2
        headerLabel.textAlignment = .center
        headerLabel.setLineHeight(lineHeight: 0.8)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor,
                                                 constant: 10),
            headerLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor, constant: 8)
        ])
    }
    
    func setupIllustrationImageViewl() {
        view.addSubview(illustrationImageView)
        
        illustrationImageView.translatesAutoresizingMaskIntoConstraints = false
        illustrationImageView.contentMode = .center
        
        NSLayoutConstraint.activate([
            illustrationImageView.topAnchor.constraint(equalTo: view.topAnchor,
                                                       constant: 212),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.widthAnchor.constraint(equalToConstant: 299),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 299)
        ])
    }
    
    func setupMainTextLabel() {
        view.addSubview(mainTextLabel)
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.textColor = AppColors.mainBlackColor
        mainTextLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 28)
        
        NSLayoutConstraint.activate([
            mainTextLabel.bottomAnchor.constraint(equalTo: subTextLabel.topAnchor,
                                                  constant: -24),
            mainTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupSubTextLabel() {
        view.addSubview(subTextLabel)
        
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subTextLabel.textColor = AppColors.badyTextGreyColor
        subTextLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subTextLabel.numberOfLines = 0
        subTextLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            subTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                 constant: -180),
            subTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subTextLabel.widthAnchor.constraint(equalToConstant: 327)
        ])
    }

    func setupMulticoloredDotsImage() {
        view.addSubview(multicoloredDotsImage)
        
        multicoloredDotsImage.translatesAutoresizingMaskIntoConstraints = false
        multicoloredDotsImage.contentMode = .scaleAspectFit
        multicoloredDotsImage.image = UIImage(resource: .multicoloredDots)
        
        rotateImageIfNeeded()
        NSLayoutConstraint.activate([
            multicoloredDotsImage.centerYAnchor.constraint(equalTo: illustrationImageView.centerYAnchor),
            multicoloredDotsImage.centerXAnchor.constraint(equalTo: illustrationImageView.centerXAnchor),
        ])
    }
    
    func setupFoodVarietyImage() {
        view.addSubview(foodVarietyImage)
        
        foodVarietyImage.translatesAutoresizingMaskIntoConstraints = false
        foodVarietyImage.contentMode = .scaleAspectFit
        foodVarietyImage.image = UIImage(resource: .foodVariety)
        
        NSLayoutConstraint.activate([
            foodVarietyImage.centerYAnchor.constraint(equalTo: illustrationImageView.centerYAnchor),
            foodVarietyImage.centerXAnchor.constraint(equalTo: illustrationImageView.centerXAnchor),
        ])
    }
}

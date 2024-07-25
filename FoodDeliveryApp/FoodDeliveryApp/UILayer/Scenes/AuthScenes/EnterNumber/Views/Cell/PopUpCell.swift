import UIKit

class PopUpCell: UITableViewCell {
    static let identifier = "PopUpCell"
    
    private let flagImageView = UIImageView()
    private let countryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with countryInfo: CountryCode) {
        let imageName = countryInfo.code
        self.flagImageView.image = UIImage(named: imageName)
        self.countryLabel.text = countryInfo.name
    }
}
private extension PopUpCell {
    func setupViews() {
        setupFlagImageView()
        setupCountryLabel()
    }
    
    func setupFlagImageView() {
        addSubview(flagImageView)
        
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            flagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
    }
    
    func setupCountryLabel() {
        addSubview(countryLabel)
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.textColor = AppColors.mainBlackColor
        countryLabel.font = UIFont.systemFont(ofSize: 16)
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            countryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            countryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
    }
}

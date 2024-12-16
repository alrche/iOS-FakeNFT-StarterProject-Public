//
//  RatingStackView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 15.12.2024.
//

import UIKit

// MARK: - RatingStackView
final class RatingStackView: UIStackView {

    // MARK: - Private properties
    private var rating: Int = 0

    // MARK: - Initializers
    init(rating: Int = 0) {
        super.init(frame: .zero)
        prepareRating(rating)
        spacing = 2
        axis = .horizontal
        distribution = .fillEqually

        for _ in 0..<self.rating {
            let imageView = UIImageView()
            imageView.image = A.Icons.activeStar.image
            imageView.contentMode = .scaleAspectFit
            addArrangedSubview(imageView)
        }

        for _ in 0..<5-self.rating {
            let imageView = UIImageView()
            imageView.image = A.Icons.inactiveStar.image
            imageView.contentMode = .scaleAspectFit
            addArrangedSubview(imageView)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func setRating(rating: Int) {
        prepareRating(rating)
        for (index, subview) in subviews.enumerated() {
            guard let imageView = subview as? UIImageView else { break }
            imageView.image = index < self.rating
            ? A.Icons.activeStar.image
            : A.Icons.inactiveStar.image
        }
    }

    // MARK: - Private methods
    private func prepareRating(_ rating: Int) {
        switch rating {
        case 5...:
            self.rating = 5
        case ...0:
            self.rating = 0
        default:
            self.rating = rating
        }
    }

}

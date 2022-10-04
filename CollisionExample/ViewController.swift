//
//  ViewController.swift
//  CollisionExample
//
//  Created by Ray on 2022/10/05.
//

import UIKit

class ViewController: UIViewController {

    private let items = ["paperplane.circle.fill",
                         "pawprint.circle",
                         "flame.circle.fill",
                         "heart.circle.fill",
                         "bolt.circle.fill"]

    private var collisionAnimator: CollisionAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollision()
    }

    private func setupCollision() {
        let referenceView: UIView = view
        let collisionAnimator = CollisionAnimator(referenceView: referenceView)

        for i in 0..<100 {
            let symbolImageView = UIImageView(image: image(for: i))
            symbolImageView.frame = CGRect(x: CGFloat.random(in: 0.0...referenceView.frame.size.width),
                                           y: CGFloat.random(in: 0.0...referenceView.frame.size.height),
                                           width: symbolImageView.frame.size.width,
                                           height: symbolImageView.frame.size.height)

            symbolImageView.layer.cornerRadius = symbolImageView.frame.size.width / 2.0
            symbolImageView.tintColor = UIColor.random
            referenceView.addSubview(symbolImageView)
            collisionAnimator.addItem(symbolImageView)
        }

        self.collisionAnimator = collisionAnimator
    }

    private func image(for index: Int) -> UIImage? {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: CGFloat.random(in: 12.0...44.0))
        return UIImage(systemName: items[index % items.count])?.applyingSymbolConfiguration(symbolConfiguration)
    }
}

//
//  CollisionAnimator.swift
//  CollisionExample
//
//  Created by Ray on 2022/10/05.
//

import UIKit
import CoreMotion

class CollisionAnimator {

    private let animator: UIDynamicAnimator

    private lazy var gravity: UIGravityBehavior = {
        let gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        animator.addBehavior(gravity)
        return gravity
    }()

    private lazy var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        return collision
    }()

    private lazy var behavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.elasticity = 0.3
        animator.addBehavior(behavior)
        return behavior
    }()

    private lazy var motionManager: CMMotionManager = {
        let motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 0.1
        return motionManager
    }()

    init(referenceView: UIView) {
        animator = UIDynamicAnimator(referenceView: referenceView)
    }

    func addItem(_ view: UIView) {
        gravity.addItem(view)
        collision.addItem(view)
        behavior.addItem(view)

        if !motionManager.isDeviceMotionActive {
            startDeviceMotion()
        }
    }
}

// MARK: - Device Motion
extension CollisionAnimator {
    func stopDeviceMotion() {
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }

    func startDeviceMotion() {
        motionManager.startDeviceMotionUpdates(to: .main) { [unowned self] motion, _ in
            guard let motion else { return }
            var point = CGPoint(x: CGFloat(motion.gravity.x),
                                y: CGFloat(motion.gravity.y))

            if let orientation = UIApplication.shared.windowScene?.interfaceOrientation {
                if orientation == .landscapeLeft {
                    let temp = point.x
                    point.x = 0 - point.y
                    point.y = temp
                } else if orientation == .landscapeRight {
                    let temp = point.x
                    point.x = point.y
                    point.y = 0 - temp
                } else if orientation == .portraitUpsideDown {
                    point.x *= -1
                    point.y *= -1
                }
            }

            let vector = CGVector(dx: 2.5 * point.x, dy: 2.5 * (0 - point.y))
            gravity.gravityDirection = vector
        }
    }
}

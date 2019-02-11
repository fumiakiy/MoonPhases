//
//  MoonView.swift
//  MoonPhases
//
//  Created by Fumiaki Yoshimatsu on 2/11/19.
//  Copyright © 2019 luckypines. All rights reserved.
//

import UIKit

class MoonView: UIView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clear
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let context = UIGraphicsGetCurrentContext() else { return }

    let pi_2 = CGFloat.pi / 2
    let angle: CGFloat = pi_2 * 0.60    // how much of a crescent do you want (must be less than M_PI_2 and greater than zero)
    let radius: CGFloat = min(frame.maxX, frame.maxY) / 8
    let center = CGPoint(x: (frame.maxX - frame.minX) / 2, y: (frame.maxY - frame.minY) / 2)

    let path: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -pi_2, endAngle: pi_2, clockwise: true)
    path.addArc(withCenter: CGPoint(x: center.x - radius * tan(angle), y: center.y), radius: CGFloat(radius) / CGFloat(cosf(Float(angle))), startAngle: pi_2 - (angle), endAngle: angle - pi_2, clockwise: false)
    path.close()
    
    context.addPath(path.cgPath)
    context.setStrokeColor(UIColor.green.cgColor)
    context.strokePath()
  }
}

//
//  MoonView.swift
//  MoonPhases
//
//  Created by Fumiaki Yoshimatsu on 2/11/19.
//  Copyright © 2019 luckypines. All rights reserved.
//

import UIKit

class MoonView: UIView {
  private static let PI_2 = CGFloat.pi / 2
  private var _angle: CGFloat = 0.01

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clear
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
  
  var angle: CGFloat {
    get {
      return _angle
    }
    set {
      _angle = newValue
    }
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let context = UIGraphicsGetCurrentContext() else { return }

    let radius: CGFloat = min(frame.maxX, frame.maxY) / 8
    let center = CGPoint(x: (frame.maxX - frame.minX) / 2, y: (frame.maxY - frame.minY) / 2)

    let path: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -MoonView.PI_2, endAngle: MoonView.PI_2, clockwise: true)
    path.addArc(withCenter: CGPoint(x: center.x - radius * tan(MoonView.PI_2 * _angle), y: center.y), radius: CGFloat(radius) / CGFloat(cosf(Float(MoonView.PI_2 * _angle))), startAngle: MoonView.PI_2 - (MoonView.PI_2 * _angle), endAngle: MoonView.PI_2 * _angle - MoonView.PI_2, clockwise: false)
    path.close()
    
    context.addPath(path.cgPath)
    context.setStrokeColor(UIColor.green.cgColor)
    context.strokePath()
  }
  
  
}

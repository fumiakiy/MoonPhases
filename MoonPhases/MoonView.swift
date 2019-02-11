//
//  MoonView.swift
//  MoonPhases
//
//  Created by Fumiaki Yoshimatsu on 2/11/19.
//  Copyright © 2019 luckypines. All rights reserved.
//

import UIKit

@IBDesignable
public class MoonView: UIView {
  private static let PI_2 = CGFloat.pi / 2
  private var _angle: CGFloat = 0.01
  private var _fillColor: UIColor = UIColor.yellow

  @IBInspectable
  public var angle: CGFloat {
    get {
      return _angle
    }
    set {
      if (newValue > 0 && newValue < 2) {
        _angle = newValue
      }
    }
  }

  @IBInspectable
  public var color: UIColor {
    get {
      return _fillColor
    }
    set {
      _fillColor = newValue
    }
  }
  
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let context = UIGraphicsGetCurrentContext() else { return }

    let radius: CGFloat = min(rect.maxX, rect.maxY) / 2
    let x = (rect.maxX - rect.minX) / 2
    let y = rect.height - ((rect.height / 2) - rect.width) * _angle - rect.width
    let center = CGPoint(x: x, y: y)

    // Outside arc - the shape of the moon
    let path: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -MoonView.PI_2, endAngle: MoonView.PI_2, clockwise: true)
    // Inside arc - the cutoff part of the moon (i.e. the shadow of the earth)
    if _angle < 1 {
      path.addArc(withCenter: CGPoint(x: center.x - radius * tan(MoonView.PI_2 * _angle), y: center.y), radius: CGFloat(radius) / CGFloat(cosf(Float(MoonView.PI_2 * _angle))), startAngle: MoonView.PI_2 - (MoonView.PI_2 * _angle), endAngle: MoonView.PI_2 * _angle - MoonView.PI_2, clockwise: false)
    } else if (_angle > 0.999999999999997 && _angle < 1.000000000000002) {
      // HACK: just close the path to add the straight line
    } else {
      path.addArc(withCenter: CGPoint(x: center.x + radius * tan(MoonView.PI_2 * -_angle), y: center.y), radius: CGFloat(radius) / CGFloat(cosf(Float(MoonView.PI_2 * -_angle))), startAngle: MoonView.PI_2 - (MoonView.PI_2 * _angle), endAngle: (MoonView.PI_2 * _angle) - MoonView.PI_2, clockwise: true)
    }

    path.close()
    
    context.addPath(path.cgPath)
    context.setFillColor(_fillColor.cgColor)
    context.fillPath()
  }
}

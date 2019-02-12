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

    // Radius is a half of the rect's width
    let radius: CGFloat = rect.width / 2
    // X position is always the center of the rect
    let x = rect.width / 2
    // Y position moves depending on the angle from the bottom (the smallest angle) to the top (the largest angle)
    // `rect.width` is used as the height of the circle here
    let y = rect.height - ((rect.height / 2) - (rect.width / 2)) * _angle - (rect.width / 2)
    let center = CGPoint(x: x, y: y)

    // The whole (full) moon that appears shadowed by the earth in the back
    context.setFillColor(_fillColor.withAlphaComponent(0.2).cgColor)
    context.fillEllipse(in: CGRect(x: 0, y: (y - rect.width / 2), width: rect.width, height: rect.width))

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
  
  public func draw2(_ rect: CGRect) {
    super.draw(rect)
    guard let context = UIGraphicsGetCurrentContext() else { return }
    
    // Radius is a half of the rect's width
    let radius: CGFloat = rect.width / 2
    // X position is always the center of the rect
    let x = rect.width / 2
    // Y position moves depending on the angle from the bottom (the smallest angle) to the top (the largest angle)
    // `rect.width` is used as the height of the circle here
    let y = rect.height - ((rect.height / 2) - (rect.width / 2)) * _angle - (rect.width / 2)
    let center = CGPoint(x: x, y: y)

    context.setFillColor(UIColor(displayP3Red: 1, green: 1, blue: 0, alpha: 0.5).cgColor)
    context.fillEllipse(in: CGRect(x: 0, y: 0, width: rect.width, height: rect.width))
  }
}

//
//  ViewController.swift
//  MoonPhases
//
//  Created by Fumiaki Yoshimatsu on 2/11/19.
//  Copyright © 2019 luckypines. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var v: MoonView!

  private var tapStart: CGPoint = CGPoint()

  override func viewDidLoad() {
    super.viewDidLoad()
    v.angle = 0.01
  }

  @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
    let p = sender.translation(in: view)
    switch sender.state {
    case .began:
      tapStart = CGPoint(x: p.x, y: p.y)
    case .ended:
      tapStart = CGPoint()
    case .changed:
      fillMoonAt(point: p)
      v.setNeedsDisplay()
      tapStart = CGPoint(x: p.x, y: p.y)
    default:
      break
    }
  }

  private func fillMoonAt(point: CGPoint) {
    let delta = point.y - tapStart.y
    if (delta > 0) {
      v.angle -= delta / 100
    } else {
      v.angle += -delta / 100
    }
  }
}


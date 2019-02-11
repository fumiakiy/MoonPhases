//
//  ViewController.swift
//  MoonPhases
//
//  Created by Fumiaki Yoshimatsu on 2/11/19.
//  Copyright © 2019 luckypines. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var v: MoonView?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.blue
    v = MoonView(frame: view.frame)
    v?.layer.borderWidth = 2
    v?.layer.borderColor = UIColor.orange.cgColor
    view.addSubview(v!)
  }

  private var start: CGPoint = CGPoint()
  @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
    let p = sender.translation(in: view)
    switch sender.state {
    case .began:
      start = CGPoint(x: p.x, y: p.y)
    case .ended:
      start = CGPoint()
    case .changed:
      let delta = p.y - start.y
      if (delta > 0) {
        v?.angle -= delta / 100
      } else {
        v?.angle += -delta / 100
      }
      v?.setNeedsDisplay()
      print(">>>>> \(v!.angle)")
      start = CGPoint(x: p.x, y: p.y)
    default:
      break
    }
  }
}


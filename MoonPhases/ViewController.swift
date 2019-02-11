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


}


//
//  VoucherViewController.swift
//  CobayaCoreML
//
//  Created by keenan warouw on 10/06/19.
//  Copyright © 2019 Keenan Warouw. All rights reserved.
//

import UIKit

class VoucherViewController: UIViewController {
    @IBOutlet weak var lock1: UIImageView!
    @IBOutlet weak var lock2: UIImageView!
    @IBOutlet weak var lock3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ud = UserDefaults.standard
        let ach = ud.bool(forKey: "achievementUnlocked")
        if ach {
            lock1.isHidden = true
            lock2.isHidden = true
            lock3.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

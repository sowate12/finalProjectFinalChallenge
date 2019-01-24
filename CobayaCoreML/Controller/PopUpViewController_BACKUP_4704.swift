//
//  PopUpViewController.swift
//  UIPageViewController2
//
//  Created by Ivan Riyanto on 10/01/19.
//  Copyright © 2019 Ivan Riyanto. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    //MARK: - Variabel
    let hijau = UIColor(rgb: 0x3D8238)
    let hijauTua = UIColor(rgb: 0x718821)
    let orangeKuning = UIColor(rgb: 0xF0A616)
    let orange = UIColor(rgb: 0xE5711C)
    let merah = UIColor(rgb: 0xD42024)
<<<<<<< HEAD
    
    //MARK: - Outlet
=======
    let viewAnimationDelegate = AnimationHelper()
>>>>>>> 313c88a5ef6d043add3c94c91d741de9f6639fe4
    @IBOutlet weak var tulisanHasil: UILabel!
    @IBOutlet weak var nilaiOutlet2: UILabel!
    @IBOutlet weak var nilaiOutlet: UILabel!
    @IBOutlet weak var ijoIjoAtas: UIImageView!
    @IBOutlet weak var backViewAtas: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageBackground: UIImageView!
    
<<<<<<< HEAD
    //MARK: - Button Action
=======
    //MARK: - Outlet and Action
>>>>>>> 313c88a5ef6d043add3c94c91d741de9f6639fe4
    @IBAction func showLessButton(_ sender: Any) {
        backViewAtas.isHidden = true
        backView.isHidden = false
    }
    @IBAction func showMoreDetailButton(_ sender: Any) {
    //ketika pencet showmore, tunjukin view controller satu lagi
    backViewAtas.isHidden = false
    backView.isHidden = true
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hasilScan()
        backViewAtas.isHidden = true
        backView.layer.cornerRadius = 50
        imageBackground.layer.cornerRadius = 50
        imageBackground.layer.masksToBounds = true
        
        
        backViewAtas.layer.cornerRadius = 50
        backViewAtas.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        ijoIjoAtas.layer.cornerRadius = 50
        ijoIjoAtas.layer.masksToBounds = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        viewAnimationDelegate.showAnimate()
        // Do any additional setup after loading the view.
    }

    //MARK: - Function
    func hasilScan() {
        let nilaiTotal = String(format: "%.1f", NilaiSementara.nilaiSementara)
        self.nilaiOutlet.text = "\(nilaiTotal) / 10.0"
        self.nilaiOutlet2.text = "\(nilaiTotal) / 10.0"
        
        if NilaiSementara.nilaiSementara >= 9 && NilaiSementara.nilaiSementara <= 10{
            imageBackground.backgroundColor = hijau
            ijoIjoAtas.backgroundColor = hijau
            tulisanHasil.text = "Great Eye!"
        }else if NilaiSementara.nilaiSementara >= 8 && NilaiSementara.nilaiSementara <= 8.9 {
            imageBackground.backgroundColor = hijauTua
            ijoIjoAtas.backgroundColor = hijauTua
            tulisanHasil.text = "Sweet"
        }else if NilaiSementara.nilaiSementara >= 7 && NilaiSementara.nilaiSementara <= 7.9 {
            imageBackground.backgroundColor = orangeKuning
            ijoIjoAtas.backgroundColor = orangeKuning
            tulisanHasil.text = "Okay."
        }else if NilaiSementara.nilaiSementara >= 5 && NilaiSementara.nilaiSementara <= 5.9 {
            imageBackground.backgroundColor = orange
            ijoIjoAtas.backgroundColor = orange
            tulisanHasil.text = "Almost There..."
        }else {
                imageBackground.backgroundColor = merah
                ijoIjoAtas.backgroundColor = merah
                tulisanHasil.text = "Meh."
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewAnimationDelegate.removeAnimate()
    }
}

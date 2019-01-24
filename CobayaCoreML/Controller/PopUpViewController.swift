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
    
    //MARK: - Outlet
    @IBOutlet weak var tulisanHasil: UILabel!
    @IBOutlet weak var nilaiOutlet2: UILabel!
    @IBOutlet weak var nilaiOutlet: UILabel!
    @IBOutlet weak var ijoIjoAtas: UIImageView!
    @IBOutlet weak var backViewAtas: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageBackground: UIImageView!
    
    //MARK: - Button Action
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
        self.showAnimate()
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
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0;
            self.view.transform = CGAffineTransform(translationX: 1.0, y: 1.0)
        }
    }

    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }) { (finished : Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAnimate()
    }
}
//MARK: - Extension
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

//
//  TipsViewController.swift
//  CobayaCoreML
//
//  Created by Steven on 31/01/19.
//  Copyright © 2019 Sania Monica. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

            @IBOutlet weak var buttonLayer9Outlet: UIButton!
            @IBOutlet weak var buttonLayer8Outlet: UIButton!
            @IBOutlet weak var buttonLayer7Outlet: UIButton!
            @IBOutlet weak var buttonLayer6Outlet: UIButton!
            @IBOutlet weak var buttonLayer5Outlet: UIButton!
            @IBOutlet weak var buttonLayer4Outlet: UIButton!
            @IBOutlet weak var buttonLayer3Outlet: UIButton!
            @IBOutlet weak var buttonLayer2Outlet: UIButton!
            @IBOutlet weak var buttonLayer1Outlet: UIButton!
            @IBOutlet weak var buttonSkipOutlet: UIButton!
    
            //halaman 1
            @IBOutlet weak var quickBrief: UIImageView!
            @IBOutlet weak var skip: UIImageView!
            @IBOutlet weak var tapToContinue: UILabel!
            
            //halaman 2
            @IBOutlet weak var siluet2: UIImageView!
            @IBOutlet weak var thisIsSuggestedAreaForScanning: UILabel!
            
            //halaman 3
            @IBOutlet weak var apelAtas: UIImageView!
            @IBOutlet weak var tomatAtas: UIImageView!
            @IBOutlet weak var jerukAtas: UIImageView!
            @IBOutlet weak var swipeToChooseTheFruit: UILabel!
            
            //halaman 4
            @IBOutlet weak var pressTheButtonToStartScanning: UILabel!
            
            //halaman 5
            @IBOutlet weak var silang: UIImageView!
            @IBOutlet weak var ifYouSeeThisButton: UILabel!
            
            //halaman 6
            @IBOutlet weak var pressThisButtonForQuickBrief: UILabel!
            @IBOutlet weak var tutorialButtonAtas: UIImageView!
            
            //halaman 7
            @IBOutlet weak var bgPolosKotakHijau: UIImageView!
            @IBOutlet weak var yourResultIs: UILabel!
            @IBOutlet weak var silangBgIjo: UIImageView!
            @IBOutlet weak var sepuluhGede: UILabel!
            @IBOutlet weak var atau: UILabel!
            @IBOutlet weak var sepuluhKecil: UILabel!
            @IBOutlet weak var greatEye: UILabel!
            @IBOutlet weak var arrowDown: UIImageView!
            @IBOutlet weak var aResultPopUp: UILabel!
            
            //halaman 8
            @IBOutlet weak var ijo: UIImageView!
            @IBOutlet weak var putih: UIImageView!
            @IBOutlet weak var silang2: UIImageView!
            @IBOutlet weak var yourResultIs2: UILabel!
            @IBOutlet weak var sepuluhGede2: UILabel!
            @IBOutlet weak var atau2: UILabel!
            @IBOutlet weak var sepuluhKecil2: UILabel!
            @IBOutlet weak var color: UILabel!
            @IBOutlet weak var excellent: UILabel!
            @IBOutlet weak var texture: UILabel!
            @IBOutlet weak var good: UILabel!
            @IBOutlet weak var theAppleDeiliciously: UILabel!
            @IBOutlet weak var arrowUp: UIImageView!
            @IBOutlet weak var youCanExpand: UILabel!
            @IBOutlet weak var greatEye2: UILabel!
            
            //halaman 9
            @IBOutlet weak var happyFruiting: UIImageView!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                quickBrief.isHidden = false
                tapToContinue.isHidden = false
                skip.isHidden = false
                // Do any additional setup after loading the view.
            }
            
            @IBAction func skipButton(_ sender: Any) {
                performSegue(withIdentifier: "skip", sender: self)
            }
            
            @IBAction func buttonLayer9(_ sender: Any) {
                buttonLayer9Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer8(_ sender: Any) {
                ijo.isHidden = true
                putih.isHidden = true
                silang2.isHidden = true
                yourResultIs2.isHidden = true
                sepuluhGede2.isHidden = true
                atau2.isHidden = true
                sepuluhKecil2.isHidden = true
                color.isHidden = true
                excellent.isHidden = true
                texture.isHidden = true
                good.isHidden = true
                theAppleDeiliciously.isHidden = true
                arrowUp.isHidden = true
                youCanExpand.isHidden = true
                greatEye2.isHidden = true
                
                
                happyFruiting.isHidden = false
                tapToContinue.isHidden = false
                buttonLayer8Outlet.isEnabled = false
                
            }
            
            @IBAction func buttonLayer7(_ sender: Any) {
                bgPolosKotakHijau.isHidden = true
                yourResultIs.isHidden = true
                silangBgIjo.isHidden = true
                sepuluhGede.isHidden = true
                atau.isHidden = true
                sepuluhKecil.isHidden = true
                greatEye.isHidden = true
                arrowDown.isHidden = true
                aResultPopUp.isHidden = true
                
                ijo.isHidden = false
                putih.isHidden = false
                silang2.isHidden = false
                yourResultIs2.isHidden = false
                sepuluhGede2.isHidden = false
                atau2.isHidden = false
                sepuluhKecil2.isHidden = false
                color.isHidden = false
                excellent.isHidden = false
                texture.isHidden = false
                good.isHidden = false
                theAppleDeiliciously.isHidden = false
                arrowUp.isHidden = false
                youCanExpand.isHidden = false
                greatEye2.isHidden = false
                buttonLayer7Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer6(_ sender: Any) {
                pressThisButtonForQuickBrief.isHidden = true
                tutorialButtonAtas.isHidden = true
                
                bgPolosKotakHijau.isHidden = false
                yourResultIs.isHidden = false
                silangBgIjo.isHidden = false
                sepuluhGede.isHidden = false
                atau.isHidden = false
                sepuluhKecil.isHidden = false
                greatEye.isHidden = false
                arrowDown.isHidden = false
                aResultPopUp.isHidden = false
                buttonLayer6Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer5(_ sender: Any) {
                silang.isHidden = true
                ifYouSeeThisButton.isHidden = true
                
                pressThisButtonForQuickBrief.isHidden = false
                tutorialButtonAtas.isHidden = false
                buttonLayer5Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer4(_ sender: Any) {
                apelAtas.isHidden = true
                pressTheButtonToStartScanning.isHidden = true
                
                silang.isHidden = false
                ifYouSeeThisButton.isHidden = false
                buttonLayer4Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer3(_ sender: Any) {
                tomatAtas.isHidden = true
                jerukAtas.isHidden = true
                swipeToChooseTheFruit.isHidden = true
                
                pressTheButtonToStartScanning.isHidden = false
                buttonLayer3Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer2(_ sender: Any) {
                siluet2.isHidden = true
                thisIsSuggestedAreaForScanning.isHidden = true
                
                apelAtas.isHidden = false
                tomatAtas.isHidden = false
                jerukAtas.isHidden = false
                swipeToChooseTheFruit.isHidden = false
                buttonLayer2Outlet.isEnabled = false
            }
            
            @IBAction func buttonLayer1(_ sender: Any) {
                quickBrief.isHidden = true
                tapToContinue.isHidden = true
                buttonSkipOutlet.isHidden = true
                skip.isHidden = true
                
                buttonLayer1Outlet.isEnabled = false
                siluet2.isHidden = false
                thisIsSuggestedAreaForScanning.isHidden = false
            }
    }

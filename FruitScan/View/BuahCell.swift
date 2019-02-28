//
//  BuahCell.swift
//  CobayaCoreML
//
//  Created by keenan warouw on 09/01/19.
//  Copyright © 2019 Sania Monica. All rights reserved.
//

import UIKit

class BuahCell: UICollectionViewCell {
    @IBOutlet weak var imageBuahSelected: UIImageView!
    @IBOutlet weak var imageBuah: UIImageView!
    var ditengah : Bool = false
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                imageBuah.isHidden = true
                imageBuahSelected.isHidden = false
                if ditengah == false {
                    self.transform = CGAffineTransform(scaleX: 75/55, y: 75/55)
                    ditengah = true
                } else if ditengah == true {
                    NilaiSementara.cellDiTengah = true
                }
            }
            else{
                imageBuahSelected.alpha = 1.0
                imageBuah.isHidden = false
                imageBuahSelected.isHidden = true
                ditengah = false
                NilaiSementara.cellDiTengah = false
                self.transform = CGAffineTransform.identity
                self.imageBuah.isHidden = false
            }
        }
    }
}

//
//  CartoonViewController.swift
//  finalAPP
//
//  Created by User20 on 2019/6/17.
//  Copyright © 2019 ouo. All rights reserved.
//

import UIKit

class CartoonViewController: UIViewController {
    
    var cartoons = [Cartoon]()

    @IBOutlet weak var cartoonImage: UIImageView!
    @IBOutlet weak var cartoonName: UILabel!
    @IBOutlet weak var cartoonCreater: UILabel!
    @IBOutlet weak var cartoonIntro: UILabel!
    @IBOutlet weak var cartoonGenderImage: UIImageView!
    @IBOutlet weak var genderText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cartoon = cartoons[0]
        let url = Cartoon.documentsDirectory.appendingPathComponent(cartoon.imageName).appendingPathExtension("jpg")

        cartoonName.text = cartoon.name
        cartoonCreater.text = cartoon.creater
        if cartoon.creater == "卡納赫拉"
        {
            let url = URL(string:cartoon.imageName)
            cartoonImage.kf.setImage(with: url)
        }
        else{
            
            cartoonImage.image = UIImage(contentsOfFile: url.path)
        }
        cartoonIntro.text = cartoon.intro
        cartoonGenderImage.image = UIImage(named: cartoon.gender+"Button.jpg")
        if cartoon.gender == "questionMark"
        {
            genderText.text = "unknow"
        }
        else
        {
            genderText.text = cartoon.gender
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  JSON_WIndow_ViewController.swift
//  AdvMediaLab Video Player
//
//  Created by Chris Seeger on 11/20/22.
//  Copyright © 2022 NBCUniversal. All rights reserved.
//

import UIKit

class JSON_WIndow_ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
     @IBAction func close() {
         dismiss(animated: true,completion: nil)
     }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func setTextButton(_ sender: UIButton) {
        //get text from text field
        let mText = textField.text
        //update previous text of textview
        textView.text = mText
        
    }
    
    
   @IBAction func appendTextButton(_ sender: UIButton) {
        //get text from text field
       let mText = textField.text
        //add text after previous text
       textView.text += mText ?? ""
    }
    
    
}

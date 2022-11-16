//
//  ViewController.swift
//  iOS_HLS_fmp_AVF
//
//  Created by Chris Seeger on 12/29/18.
//  Copyright © 2019 NBCUniversal. All rights reserved.
//

import UIKit
import AVKit



//Added Delegates for AVPlayer and UITextField along with normal UIViewController
class ViewController: UIViewController, AVAudioPlayerDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // This removes keyboard after entry of text in UI TextField
        CustomURLTextf.delegate = self
    
        
        // register settings bundle with user defaults
        registerSettingsBundle()
        

       // load root bundle to UserDefaults
        loadDefaults()
        
        
        setButtonLables()
    
        
        let notificationCenterForeground = NotificationCenter.default
        notificationCenterForeground.addObserver(self, selector: #selector(appMovedToForegroundUpdateButtonLabels), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    

    
// Labels for Buttons A, B, C
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
 
    
    @objc func appMovedToForegroundUpdateButtonLabels() {
        print("App moved to ForeGround!")
        
        setButtonLables()
        
    }
    
    
   
    // Label all buttons via root settings bundle
    func setButtonLables() {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        
        
        // Update button text from root preferences bundle
        let aButtonLabelText = userDefaults.string(forKey: "a_button_label")
        aButton.setTitle(aButtonLabelText, for: .normal)
        
        let bButtonLabelText = userDefaults.string(forKey: "b_button_label")
        bButton.setTitle(bButtonLabelText, for: .normal)
        
        let cButtonLabelText = userDefaults.string(forKey: "c_button_label")
        cButton.setTitle(cButtonLabelText, for: .normal)
        
        
    }
    
    
    @IBAction func butUHDStreamTapped(_ sender: Any) {
    
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "4k_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
            hideKeyboard()
    }
    
    
    @IBAction func but1080PStreamTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "1080p_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
            hideKeyboard()
    }
    
    
    @IBAction func but720PStreamTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "720p_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
            hideKeyboard()
    }
    
    
    @IBAction func butAppleRefStreamTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "apple_ref_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
        hideKeyboard()
    
    }
    
    @IBAction func butDolbyRefStreamTapped(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.synchronize()
        let streamURL = userDefaults.string(forKey: "dolby_ref_url")
        
        guard let VideoURL = URL(string: streamURL!) else {
            debugPrint ("URL not found")
            return
        }
        
        let player = AVPlayer(url: VideoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
        hideKeyboard()
    }
    
    //created a string variable
    var name: String = ""
    
    
    // Get Custom URL via Text Field
    @IBOutlet weak var CustomURLTextf: UITextField!
    

    
    @IBAction func butCustomStreamTapped(_ sender: UIButton) {
        
        //getting input from Text Field
        name = CustomURLTextf.text!
        
        let VideoURL = name as String
        let player = AVPlayer(url: URL(fileURLWithPath: VideoURL))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
    
        }
        hideKeyboard()
    }
   
    
// functions or methods

    func hideKeyboard() {
        
        CustomURLTextf.resignFirstResponder()
        
    }
   
    
// Declare delegate for Keyboard after input
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        CustomURLTextf.resignFirstResponder()
        return true
        
    }
    
    
    
    @IBAction func butSettingsTapped(_ sender: Any) {
        
        let alertController = UIAlertController (title: "NBC Video Player Settings", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "NBC Video Player Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    
    }
    
    
    
    // Set up Root Settings bundle and sync with user defaults
    
    // Register settings bundle
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    
    }
    
  // Newer function for syncing the root bundle and UserDefaults
    private func loadDefaults() {
        let userDefaults = UserDefaults.standard
        
        let pathStr = Bundle.main.bundlePath
        let settingsBundlePath = (pathStr as NSString).appendingPathComponent("Settings.bundle")
        let finalPath = (settingsBundlePath as NSString).appendingPathComponent("Root.plist")
        let settingsDict = NSDictionary(contentsOfFile: finalPath)
        guard let prefSpecifierArray = settingsDict?.object(forKey: "PreferenceSpecifiers") as? [[String: Any]] else {
            return
        }
        
        var defaults = [String: Any]()
        
        for prefItem in prefSpecifierArray {
            guard let key = prefItem["Key"] as? String else {
                continue
            }
            defaults[key] = prefItem["DefaultValue"]
        }
        userDefaults.register(defaults: defaults)
    }
    

    
    


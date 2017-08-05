//
//  NavigationController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
            configureUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI(){
        
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: Constants.defaultFontNavigation, size: Constants.defaultFontSizeNavigation)!,
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame =  (self.navigationBar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.addSubview(visualEffectView)
        
        self.navigationBar.sendSubview(toBack: visualEffectView)
        
//        self.navigationBar.barTintColor = Constants.navBarColor

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TabBarController.swift
//  MovieHawk
//
//  Created by Lakshmi on 8/5/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI(){
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.black

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

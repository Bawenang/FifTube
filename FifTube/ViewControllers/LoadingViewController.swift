//
//  LoadingViewController.swift
//  FifTube
//
//  Created by Poing on 1/28/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FifTubeManager.sharedInstance.login(completion: {()-> Void in
            //Do whatever you want with your returnedData JSON data.
            //when you finish working on data you can update UI
            self.next()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func next() {
        performSegue(withIdentifier: "startSegue", sender: self)
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

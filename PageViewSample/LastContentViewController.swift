//
//  LastContentViewController.swift
//  PageViewSample
//
//  Created by Kazuhiro Hayashi on 1/25/15.
//  Copyright (c) 2015 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

protocol LastContentViewControllerDelegate {
    func dismiss(viewController : LastContentViewController);
}

class LastContentViewController: UIViewController {
    
    var pageIndex = 0
    var delegate : LastContentViewControllerDelegate! = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func performDismiss(sender: AnyObject) {
        delegate.dismiss(self)
    }
}

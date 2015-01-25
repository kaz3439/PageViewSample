//
//  ContentViewController.swift
//  PageViewSample
//
//  Created by Kazuhiro Hayashi on 1/26/15.
//  Copyright (c) 2015 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

protocol ContentViewControllerDelegate {
    func nextPage(viewController : ContentViewController);
}

class ContentViewController: UIViewController {
    enum ButtonType {
        case Next
        case Last
    }
    @IBOutlet weak var nextButton: UIButton!
    var pageIndex = 0
    var delegate : ContentViewControllerDelegate! = nil
    var buttonType : ButtonType = .Next
    override func viewDidLoad() {
        super.viewDidLoad()
        switch buttonType {
        case .Next:
            nextButton.setTitle("次を見る", forState: UIControlState.Normal)
        case .Last:
            nextButton.setTitle("早速使ってみる", forState: UIControlState.Normal)
            nextButton.backgroundColor = UIColor.blueColor()
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performNextButton(sender: AnyObject) {
        delegate.nextPage(self)
    }
    
    func setButtonType(buttonType: ButtonType) {
        self.buttonType = buttonType

    }
}

//
//  ViewController.swift
//  PageViewSample
//
//  Created by Kazuhiro Hayashi on 1/26/15.
//  Copyright (c) 2015 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, ContentViewControllerDelegate {
    let pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    let mockCollection = ["Page1", "Page2", "Page3", "Page4"]
    var currentPage = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as ContentViewController
        viewController.delegate = self
        pageViewController.setViewControllers([viewController], direction: .Forward, animated: false, completion: nil)
        
        pageViewController.view.frame = self.view.frame
        pageViewController.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let nextPageIndex = (viewController as ContentViewController).pageIndex
        currentPage = nextPageIndex
        if nextPageIndex  >= mockCollection.count - 1 || nextPageIndex == NSNotFound { return nil }
        let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as ContentViewController
        contentViewController.delegate = self
        contentViewController.pageIndex = nextPageIndex + 1
        if contentViewController.pageIndex == mockCollection.count - 1 {
            contentViewController.setButtonType(.Last)
        }
        return contentViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let prevPageIndex = (viewController as ContentViewController).pageIndex
        currentPage = prevPageIndex
        if prevPageIndex <= 0 || prevPageIndex == NSNotFound { return nil }
        let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as ContentViewController
        contentViewController.delegate = self
        contentViewController.pageIndex = prevPageIndex - 1
        return contentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return mockCollection.count
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        println(currentPage)
        return currentPage
    }
    
    func nextPage(viewController: ContentViewController) {
        if viewController.pageIndex == mockCollection.count - 1 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.pageViewController.view.alpha = 0.0
            }, completion: { (complete) -> Void in
                self.pageViewController.view.removeFromSuperview()
                self.pageViewController.removeFromParentViewController()
            })
        } else {
            let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as ContentViewController
            contentViewController.delegate = self
            currentPage++
            contentViewController.pageIndex = currentPage
            if contentViewController.pageIndex == mockCollection.count - 1 {
                contentViewController.setButtonType(.Last)
            }
            pageViewController.setViewControllers([contentViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
}


//
//  WelcomeViewController.swift
//  mc2apps
//
//  Created by Melina Dewi on 26/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }

    private func configure() {
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Welcome 1", "Welcome 2", "Welcome 3"]
        for i in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(i) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+120+10, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 15))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            pageView.addSubview(label)
            label.text = titles[i]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome")
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Continue", for: .normal)
            if i == 2 {
                button.setTitle("Get Started", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = i+1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button:UIButton) {
        guard button.tag < 3 else {
            Core.shared.isNotNewUser()
            let destination = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
            self.present(destination, animated: true, completion: nil)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }

}

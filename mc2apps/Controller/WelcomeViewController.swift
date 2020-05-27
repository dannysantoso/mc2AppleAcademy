//
//  WelcomeViewController.swift
//  mc2apps
//
//  Created by Melina Dewi on 26/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
        setUpBottomControls()
    }

    private func configure() {
        scrollView.frame = holderView.bounds
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        holderView.addSubview(scrollView)
        
        let titles = ["Manage Your Project", "Don't Miss Your Deadline", "Take Care of Yourself"]
        let subtitles = ["Easily manage your projects \n by using milestones and tasks.", "Never miss a deadline \n through our built-in notification \n for approaching project deadlines.", "Work hard, play hard; \n our milestone reward system ensure \n to reward progress by taking care of yourselves."]
        for i in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(i) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: pageView.frame.size.width, height: pageView.frame.size.height))
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: pageView.frame.size.height - 300, width: pageView.frame.size.width, height: 120))
            let subtitleLabel = UILabel(frame: CGRect(x: 10, y: pageView.frame.size.height - 230, width: pageView.frame.size.width - 20, height: 120))
            
            let button = UIButton(frame: CGRect(x: 75, y: pageView.frame.size.height - 110, width: pageView.frame.size.width - 150, height: 50))
            
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "OnBoarding_0\(i+1)")
            pageView.addSubview(imageView)
            
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont(name: "SFProRounded-Bold", size: 25)
            titleLabel.textColor = UIColor(red: 0.208, green: 0.38, blue: 0.6, alpha: 1)
            pageView.addSubview(titleLabel)
            titleLabel.text = titles[i]
            
            subtitleLabel.textAlignment = .center
            subtitleLabel.font = UIFont(name: "SFProRounded-Medium", size: 16)
            subtitleLabel.numberOfLines = 3
            subtitleLabel.textColor = UIColor(red: 0.208, green: 0.38, blue: 0.6, alpha: 1)
            pageView.addSubview(subtitleLabel)
            subtitleLabel.text = subtitles[i]
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.984, green: 0.584, blue: 0.576, alpha: 1)
            button.layer.cornerRadius = 25
            
            button.setTitle("Next", for: .normal)
            if i == titles.count - 1 {
                button.setTitle("Start!", for: .normal)
            }
            button.titleLabel?.font = UIFont(name: "SFProRounded-SemiBold", size: 22)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = i+1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
        holderView.addSubview(pageControl)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset[0].x)
        pageControl.currentPage = Int(targetContentOffset[0].x / holderView.frame.size.width)
    }
    
    @objc func didTapButton(_ button:UIButton) {
        guard button.tag < 3 else {
//            Core.shared.isNotNewUser()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "navigation")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)

            return
        }
        if pageControl.currentPage < 2 {
            pageControl.currentPage = pageControl.currentPage + 1
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl(frame: CGRect(x: 0, y: holderView.frame.size.height - 400, width: 100, height: 120))
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 0.5)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    fileprivate func setUpBottomControls() {
        NSLayoutConstraint.activate([pageControl.centerXAnchor.constraint(equalTo: holderView.centerXAnchor), pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)])
    }
    
}

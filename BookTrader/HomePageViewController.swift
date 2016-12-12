//
//  HomePageViewController.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var TitleMapView: MapTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViews() {
        
        let rightPlusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddListingTap(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightPlusButton
    }
    
    func handleAddListingTap( sender : UIBarButtonItem ) {
        self.performSegue(withIdentifier: Segues.HomeToAddListing, sender: nil)
    }
}

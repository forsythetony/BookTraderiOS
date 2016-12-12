//
//  MapTitleView.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit
import MapKit

class MapTitleView: UIView {

    var SchoolName : String = "Mizzou"
    
    var SchoolCoordinates : CLLocationCoordinate2D = Defaults.SchoolCoordinates {
        didSet {
            backgroundMapView.setRegion(MKCoordinateRegion.DefaultRegionWithCenter(coordinates: SchoolCoordinates), animated: true)
        }
    }
    var SchoolListingCount : Int = 44
    
    private var schoolNameLabel = UILabel()
    private var backgroundMapView : MKMapView = {
       
        let m = MKMapView()
        m.alpha = 0.95
        m.mapType = .satelliteFlyover
        return m
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    private func setupViews() {
        
        //  Map View Frame
        var map_frame = CGRect()
        
        map_frame = self.bounds
        
        backgroundMapView.frame = map_frame
        backgroundMapView.setRegion(MKCoordinateRegion.DefaultRegionWithCenter(coordinates: SchoolCoordinates), animated: false)
        self.addSubview(self.backgroundMapView)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundMapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundMapView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundMapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundMapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundMapView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]);
        
        //  School Title
        
        let title_height_perc : CGFloat = 0.3
        
        var title_frame = CGRect()
        title_frame.size.width = self.frame.size.width
        title_frame.size.height = self.frame.size.height * title_height_perc
        title_frame.origin.y = (self.frame.size.height.divideInHalf()) - title_frame.height.divideInHalf()
        schoolNameLabel.frame = title_frame
        
        
        schoolNameLabel.font = UIFont.FontWithType(fontType: .Bold, size: 30.0)
        schoolNameLabel.text = SchoolName
        schoolNameLabel.backgroundColor = Color.MizzouGold
        schoolNameLabel.textAlignment = .center
        
        self.addSubview(schoolNameLabel)
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            schoolNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            schoolNameLabel.heightAnchor.constraint(equalToConstant: 40.0),
            schoolNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            schoolNameLabel.topAnchor.constraint(equalTo: self.topAnchor)
            ]);
        
        
    }
    
    
}

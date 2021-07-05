//
//  ViewController.swift
//  map1
//
//  Created by WEB on 2020/07/17.
//  Copyright © 2020 WEB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var displayMap: MKMapView!
    @IBOutlet weak var serchText: UITextField!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!

    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    var myLocationManager: CLLocationManager!
    var nowAnnotations: [MKAnnotation] = []

    
    
    //起動時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //位置情報の許可を求めるメッセージ
        myLocationManager = CLLocationManager()
        myLocationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            myLocationManager.delegate = self
        }
        
        //起動時に表示する座標を指定
        let center = CLLocationCoordinate2D(latitude: 35.691646,longitude: 139.696939)
        
        //マップ範囲を指定
        let region = MKCoordinateRegion(center: center, span: span)
        displayMap.setRegion(region, animated:true)
        
        //HAL東京にピンを立てる
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = "HAL東京"
        pin.subtitle = "https://www.hal.ac.jp/tokyo"
        displayMap.addAnnotation(pin)
        
        //検索窓の処理
        serchText.delegate = self
        
        //callout
        displayMap.delegate = self
        
    }
    
    
    //戻るボタン
    @IBAction func ReturnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MAPタイプ切替処理
    @IBAction func ChangeType(_ sender: Any) {
        if displayMap.mapType == .hybrid{ displayMap.mapType = .standard
        }else if displayMap.mapType == .standard{
            displayMap.mapType = .satellite
        }else if displayMap.mapType == .satellite{
            displayMap.mapType = .hybrid
        }
    }
    
    
    
    //検索窓delegate処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        serchText.resignFirstResponder()
        //検索処理
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(serchText.text!, completionHandler: {(placemarks:[CLPlacemark]?, error:Error?) in
            
            if let placemark = placemarks?[0] {
                if placemark.location?.coordinate != nil {
                    if let targetCoordinate = placemark.location?.coordinate {
                        let region = MKCoordinateRegion(center: targetCoordinate, span: self.span)
                        self.displayMap.setRegion(region, animated: true)
                        let pin = MKPointAnnotation()
                        pin.coordinate = targetCoordinate
                        pin.title = self.serchText.text!
                        self.displayMap.addAnnotation(pin)
                    }
                }
            }
        })
        return true
    }
    
    
    
    //キャンセルボタンの処理
    @IBAction func cansel(_ sender: Any) {
        serchText.text! = ""
    }
    
    
    
    //HAL大阪,大阪駅前,HAL名古屋の処理
    func makePin() {
        
    }
    @IBAction func myButtonAction(_ sender: Any) {
        let buttonTagButton:UIButton = sender as! UIButton
        print(buttonTagButton.tag)
        let buttonTag = buttonTagButton.tag
        
        if buttonTag == 1 {
            //座標を指定
            let center = CLLocationCoordinate2D(latitude: 34.699900,longitude: 135.493024)
            //マップの範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: center, span: span)
            displayMap.setRegion(region, animated:true)
            //ピンを立てる
            let pin = MKPointAnnotation()
            pin.coordinate = center
            pin.title = "HAL大阪"
            pin.subtitle = "https://www.hal.ac.jp/osaka"
            displayMap.addAnnotation(pin)
        }
        else if buttonTag == 2 {
            //座標を指定
            let center = CLLocationCoordinate2D(latitude: 34.702612,longitude: 135.495980)
            //マップの範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: center, span: span)
            displayMap.setRegion(region, animated:true)
            //ピンを立てる
            let pin = MKPointAnnotation()
            pin.coordinate = center
            pin.title = "大阪駅"
            pin.subtitle = "https://www.jr-odekake.net/eki/premises?id=0610130"
            displayMap.addAnnotation(pin)
        }
        else if buttonTag == 3 {
            //座標を指定
            let center = CLLocationCoordinate2D(latitude: 35.168128,longitude: 136.885651)
            //マップの範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: center, span: span)
            displayMap.setRegion(region, animated:true)
            //ピンを立てる
            let pin = MKPointAnnotation()
            pin.coordinate = center
            pin.title = "HAL名古屋"
            pin.subtitle = "https://www.hal.ac.jp/nagoya"
            displayMap.addAnnotation(pin)
        }
    }
    
    
    
    //トラッキング処理
    //緯度・経度情報(GPS)が変わった時に動く
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        print("緯度: "+(manager.location?.coordinate.latitude.description)!)
        print("経度: "+(manager.location?.coordinate.longitude.description)!)
        //緯度経度表示
        latitudeLabel.text = ("緯度: "+(manager.location?.coordinate.latitude.description)!)
        longitudeLabel.text = ("経度: "+(manager.location?.coordinate.longitude.description)!)
        //座標を指定
        let center = CLLocationCoordinate2D(latitude: atof(manager.location?.coordinate.latitude.description), longitude: atof(manager.location?.coordinate.longitude.description))
        //マップの範囲を指定
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: center, span: span)
        displayMap.setRegion(region, animated:true)
        //ピンを立てる
        let pin = MKPointAnnotation()
        pin.coordinate = center
        displayMap.addAnnotation(pin)
        nowAnnotations.append(pin)
    }
    //緯度・経度情報(GPS)が取れなかった時に動く
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
       print(error)
    }
    //トラッキングボタン
    @IBAction func trackingButton(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        if button.currentTitle == "トラッキングを開始" {
            button.setTitle("停止", for: .normal)
            //ピンの一括削除
            for nowAnnotation in nowAnnotations { displayMap.removeAnnotation(nowAnnotation)
            }
            //現在位置の取得開始
            myLocationManager.startUpdatingLocation()
        }
        else {
            button.setTitle("トラッキングを開始", for: .normal)
            //現在位置の取得終了
            myLocationManager.stopUpdatingLocation()
        }
        print(button.currentTitle!)//デバッグ時にログに表示
    }
    
    
    
    //Callout処理
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            view.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.infoLight)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl) {
        let strUrl:String = view.annotation!.subtitle! ?? ""
        if let url = URL(string: strUrl){ // urlに値がある時
        UIApplication.shared.open(url) }
    }

}

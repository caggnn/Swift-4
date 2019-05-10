//
//  DetailViewController.swift
//  brcd
//
//  Created by Mac User on 24.04.2019.
//  Copyright © 2019 Mac User. All rights reserved.
//

import UIKit
/*
struct barcodes: Codable {
    let logicalref: Int
    let barcode: Int
    let urunbilgisi: String
    let birimi: String
    let listeFiyati: Double
    let stokMik: Double
}*/

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblBarkod: UITextField!
    @IBOutlet weak var lblUAdi: UILabel!
    @IBOutlet weak var lblStok: UILabel!
    @IBOutlet weak var lblBirim: UILabel!
    @IBOutlet weak var lblFiyat: UILabel!
    
    //var arrdata = [barcodes]()
    var Barkod: String = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
        //getdata()
        lblBarkod.text = Barkod
    }
    
    /*
    func getdata() {
        let url = URL(string: "http://88.247.77.21:72/api/Barcodes/3")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                if error == nil{
                    self.arrdata = try JSONDecoder().decode([barcodes].self, from: data!)
                }
                
                for mainarr in self.arrdata{
                    
                    print(mainarr.logicalref,":", mainarr.barcode,":")
                }
            }
            catch{
                print("Error in get json data")
            }
            
        }.resume()
    }*/
    
    @IBAction func btnAra(_ sender: Any) {
    }
    
   
    @IBAction func btnSatis(_ sender: Any) {
    }
    
    @IBAction func btnStok(_ sender: Any) {
    }
    
    
}

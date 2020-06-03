//
//  SecondViewController.swift
//  SmokeCalculator
//
//  Created by Cengiz Baygın on 2.06.2020.
//  Copyright © 2020 Cengiz Baygın. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    // MARK: Objects
    var defaults = UserDefaults.standard
    var currentDay : Int {
          let dateObject = Date()
          let dayVar = Calendar.current.component(.day, from: dateObject)
          return dayVar
      }
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var userSmokePriceTextField: UITextField!
    @IBOutlet weak var userManyTextField: UITextField!
    //MARK: Variables & Arrays
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let dateObject = Date()
        let dayVar = Calendar.current.component(.day, from: dateObject)
        let monthVar = Calendar.current.component(.month, from: dateObject)
        let yearVar = Calendar.current.component(.year, from: dateObject)
        dateTextField.isEnabled = false
        dateTextField.text = "Başlama Tarihi:\(dayVar) . \(monthVar) . \(yearVar)"
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        if userSmokePriceTextField.text != "" && userManyTextField.text != "" && dateTextField.text != nil {
            print("Koşuldan geçti.")
            
            if let userSmokePrice = Double(userSmokePriceTextField.text!){
                if let userManyVar = Double(userManyTextField.text!){
                    resetAllData()
                    defaults.set(userSmokePrice, forKey: "userSmokePrice")
                    print("Paket Fiyat kaydedildi.",userSmokePrice)
                    defaults.set(userManyVar, forKey: "userHowMany")
                    print("ManyVar kaydedildi.",userManyVar)
                    defaults.set(1, forKey: "userCreated")
                    saveCurrentDate()
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                print("Çevirme Hatası")
                setAlertMessage(Title: "HATA!", SubTitle: "Girdiğiniz değeler sayısal ifadeler içermesi gerekmektedir ve gerekli bilgileri boş bırakmayınız.")
            }
            
            
            
            
        }else{
               setAlertMessage(Title: "HATA!", SubTitle: "Girdiğiniz değeler sayısal ifadeler içermesi gerekmektedir ve gerekli bilgileri boş bırakmayınız.")
            print("Koşuldan geçilmedi.")
        }
        
    }
    func resetAllData(){
        defaults.set(0.0, forKey: "userSavedMoney")
        defaults.set(0.0, forKey: "userHowMany")
        defaults.set(0.0, forKey: "userSmokePrice")
        defaults.set(0, forKey: "userDay")
        defaults.set(0, forKey: "userMonth")
        defaults.set(0, forKey: "userYear")
        defaults.set(0.0, forKey: "userSaveSmokes")
        defaults.set(currentDay, forKey: "latestUpdateDay")
        defaults.set(0, forKey: "userCreated")
        print("Değerler sıfırlandı")
    }
    func saveCurrentDate(){
        let dateObject = Date()
        let dayVar = Calendar.current.component(.day, from: dateObject)
        let monthVar = Calendar.current.component(.month, from: dateObject)
        let yearVar = Calendar.current.component(.year, from: dateObject)
        defaults.set(dayVar, forKey: "userDay")
        defaults.set(monthVar, forKey: "userMonth")
        defaults.set(yearVar, forKey: "userYear")
        print("Tarih kaydedildi.")
    }
    func setAlertMessage (Title:String , SubTitle:String){
        let alertMessage = UIAlertController.init(title: Title, message: SubTitle, preferredStyle: UIAlertController.Style.actionSheet)
        let okButton = UIAlertAction.init(title: Title, style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            self.userManyTextField.text = ""
            self.userSmokePriceTextField.text = ""
            self.resetAllData()
        }
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true, completion: nil)
    }
}

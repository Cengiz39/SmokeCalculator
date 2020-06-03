

import UIKit

class ViewController: UIViewController {
    // MARK: Objects
    // MARK: View 1
    
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var SBTLabel: UILabel!
    @IBOutlet weak var SBTDateLabel: UILabel!
    // MARK: View 2
    
    @IBOutlet weak var SBTCounterTitle: UILabel!
    @IBOutlet weak var SBTCounter: UILabel!
    
    // MARK: View 3
    @IBOutlet weak var SmokeTitleLabel: UILabel!
    @IBOutlet weak var SmokeCounterLabel: UILabel!
    // MARK: View 4
    
    @IBOutlet weak var SavedMoneyCounterLabel: UILabel!
    @IBOutlet weak var SavedMoneyTitle: UILabel!
    // MARK: View 5
    
    @IBOutlet weak var SavedDayCounterLabel: UILabel!
    @IBOutlet weak var SavedDayTitle: UILabel!
    //MARK: Variables & Arrays
    var defaults = UserDefaults.standard
    var userSavedMoney = Double()
    var userManyTimes = Double()
    var userSmokePrice = Double()
    var userDay = Int()
    var userMonth = Int()
    var userYear = Int()
    var userSaveSmoke = Double()
    var userCreatedCheckVar = Int()
    var packetSmoke = 20.0
    var differanceDay = Int()
    var differanceMonth = Int()
    var differanceYear = Int()
    var differentDayCheck = Bool()
    var getLatestUpdateDay = Int()
    var differantDayCheck = Bool()
    var totalDay = Int()
    var totalSavedDay = Int()
    var currentDay : Int {
        let dateObject = Date()
        let dayVar = Calendar.current.component(.day, from: dateObject)
        return dayVar
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.layer.cornerRadius = 20
        view2.layer.cornerRadius = 20
        view3.layer.cornerRadius = 20
        view4.layer.cornerRadius = 20
        view5.layer.cornerRadius = 20
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(addButtonClicked))
        
    }// MARK: LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        getData()
        if userCreatedCheckVar == 0 || userCreatedCheckVar == nil {
                print("Kaydedilmiş veri yok.")
                SavedDayCounterLabel.text = "Kaydedilmiş bir verin yok."
                SBTCounter.text = "Kaydedilmiş bir verin yok."
                SavedMoneyCounterLabel.text = "Kaydedilmiş bir verin yok."
                SmokeCounterLabel.text = "Kaydedilmiş bir verin yok."
                SavedDayCounterLabel.text = "Kaydedilmiş bir verin yok."
                SBTDateLabel.text = "Kaydedilmiş bir verin yok."
                performSegue(withIdentifier: "FirstSegue", sender: nil)
        }else{
        SBTDateLabelFunc()
        SBTCounterLabelFunc()
        savedLifeFunc()
       
         if getLatestUpdateDay == userDay && totalDay == 0 && userCreatedCheckVar == 1 {
            print("Kaydedildikten sonra ilk gün.")
            SavedDayCounterLabel.text = "İlk günün."
            SBTCounter.text = "İlk günün."
            SavedMoneyCounterLabel.text = "İlk günün."
            SmokeCounterLabel.text = "İlk günün"
            SavedDayCounterLabel.text = "İlk Günün"
         }else{
        if getLatestUpdateDay == currentDay && userCreatedCheckVar == 1 {
            print("Aynı gündesin.")
            differentDayCheck = false
            print(getLatestUpdateDay)
            SmokeCounterLabel.text = "İçilmeyen Sigara:\(userSaveSmoke)"
            SavedMoneyCounterLabel.text = "Biriktirdiğim Para: \(userSavedMoney)₺"
        }else{
            print("Farklı gün.")
            differentDayCheck = true
            savedMoneyCounter()
            smokesCounter()
        }
    }
        }
    }
    func getData(){
        if let storedUserMonth = defaults.object(forKey: "userMonth") as? Int {
        print("Get Data Func : Ay:",storedUserMonth)
            userMonth = storedUserMonth
        }
        if let storedUserYear = defaults.object(forKey: "userYear") as? Int {
            print("Get Data Func : Yıl:",storedUserYear)
            userYear = storedUserYear
        }
        if let storedUserDay = defaults.object(forKey: "userDay") as? Int {
            print("Get Data Func : Gün:",storedUserDay)
            userDay = storedUserDay
        }
        if let storedSmokePrice = defaults.object(forKey: "userSmokePrice") as? Double {
            print("Get Data Func : Fiyat:",storedSmokePrice)
            userSmokePrice = storedSmokePrice
        }
        if let createdUserCheck = defaults.object(forKey: "userCreated") as? Int {
               userCreatedCheckVar = createdUserCheck
               print(userCreatedCheckVar)
             }
        if let storedManyTimes = defaults.object(forKey: "userHowMany") as? Double {
            print("Get Data Func : Kaç kere:",storedManyTimes)
            userManyTimes = storedManyTimes
        }
        if let storedUserSaveMoney = defaults.object(forKey: "userSavedMoney") as? Double {
            print("Get Data Func : birikmiş para:",storedUserSaveMoney)
            userSavedMoney = storedUserSaveMoney
        }
        if let storedSaveSmokes = defaults.object(forKey: "userSaveSmokes") as? Double{
            userSaveSmoke = storedSaveSmokes
            print("stored save smoke",storedSaveSmokes)
        }
        if let latestUpdateDay = defaults.object(forKey: "latestUpdateDay") as? Int {
            getLatestUpdateDay = latestUpdateDay
            print("latestupdateday",latestUpdateDay)
        }
    }//MARK:GetData Dead Line
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "FirstSegue", sender: nil)
    }
    //MARK: Functions
    func SBTCounterLabelFunc(){
        differanceMonth = 0
        differanceYear = 0
        differanceDay = 0
        let dateObject = Date()
        let dayVar = Calendar.current.component(.day, from: dateObject)
        let monthVar = Calendar.current.component(.month, from: dateObject)
        let yearVar = Calendar.current.component(.year, from: dateObject)
        if userDay > dayVar {
            differanceDay = userDay - dayVar
        }else if dayVar > userDay {
            differanceDay = dayVar - userDay
        }else{
        }
        // Ay Kıyaslaması
        if userMonth > monthVar {
            differanceMonth = userMonth - monthVar
        }else if monthVar > userMonth {
            differanceMonth = monthVar - userMonth
        }else{
            differanceMonth = monthVar - userMonth
        }
        // Yıl Kıyaslaması
        if userYear > yearVar {
            
            differanceYear = userYear - yearVar
        }else if yearVar > userYear {
            
            differanceYear = yearVar - userYear
        }else{
            
            differanceYear = yearVar - userYear
        }
        SBTCounter.text = "\(differanceYear) Yıl \(differanceMonth) Ay \(differanceDay) Gün oldu."
        let monthToDay = differanceMonth * 30
        let yearToDay = differanceYear * 360
        totalDay = (monthToDay + yearToDay) + differanceDay
        totalDay =  (monthToDay + yearToDay) + differanceDay
    }
    func smokesCounter(){
        if let storedSaveSmokes = defaults.object(forKey: "userSaveSmokes") as? Double{
            userSaveSmoke = storedSaveSmokes
        }
        userSaveSmoke = (packetSmoke * userManyTimes) + userSaveSmoke
        if totalDay > 1 && differentDayCheck == true {
            userSaveSmoke = userSaveSmoke * Double(totalDay)
        }
        defaults.set(userSaveSmoke, forKey: "userSaveSmokes")
        SmokeCounterLabel.text = "İçilmeyen Sigara:\(userSaveSmoke)"
        defaults.set(currentDay, forKey: "latestUpdateDay")
    }
    func savedMoneyCounter(){
        print("savedMoney Called")
   if let storedUserSaveMoney = defaults.object(forKey: "userSavedMoney") as? Double {
             
             userSavedMoney = storedUserSaveMoney
         }
        userSavedMoney = (userManyTimes * userSmokePrice) + userSavedMoney
        if totalDay > 1 && differentDayCheck == true {
            userSavedMoney = userSavedMoney * Double(totalDay)
        }
        print("çarptıktan sonra",userSavedMoney)
        defaults.set(userSavedMoney, forKey: "userSavedMoney")
        SavedMoneyCounterLabel.text = "Biriktirdiğim Para: \(userSavedMoney)₺"
        defaults.set(currentDay, forKey: "latestUpdateDay")
    }
    func savedLifeFunc(){
        totalSavedDay = (totalDay / 10) + totalSavedDay
//        totalSavedDay = totalSavedDay * 1000
        SavedDayCounterLabel.text = "Biriktirdiğim Hayat:\(totalSavedDay)"
    }
    func SBTDateLabelFunc(){
        var commentMonth = String()
        switch userMonth {
        case 1:
            print("Ocak")
            commentMonth = "Ocak"
        case 2:
            print("Şubat")
            commentMonth = "Şubat"
        case 3:
            print("Mart")
            commentMonth = "Mart"
        case 4:
            print("Nisan")
            commentMonth = "Nisan"
        case 5:
            print("Mayıs")
            commentMonth = "Mayıs"
        case 6:
            print("Haziran")
            commentMonth = "Haziran"
        case 7:
            print("Temmuz")
            commentMonth = "Temmuz"
        case 8:
            print("Ağustos")
            commentMonth = "Ağustos"
        case 9:
            print("Eylül")
            commentMonth = "Eylül"
        case 10:
            print("Ekim")
            commentMonth = "Ekim"
        case 11:
            print("Kasım")
            commentMonth = "Kasım"
        case 12:
            print("Aralık")
            commentMonth = "Aralık"
        default:
            break
        }
        SBTDateLabel.text = "\(userDay).\(commentMonth).\(userYear)"
        
    }
    
    
    
    
    
    
    
}//MARK: Viewcontroller dead line


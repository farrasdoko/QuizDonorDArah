//
//  TableViewController.swift
//  Info Donor DArah
//
//  Created by Gw on 08/11/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let studentURL = "https://script.googleusercontent.com/macros/echo?user_content_key=R4kCEI8L5b8p1UJqgvrvR9FIvnMTSQb6Hjx9ljuCzWnN5V9GkQk04LH0S4gt_cHLSocF86mDIuCDKIlMkW5skQVqqRTXJIsuOJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuB6lHT6qnqYcmFWggwoSVQQXTsQ1HqKa1CgDXQROm1OeNR5ibYVAaRxAeOtzLmbRZcVjrce7Uveb8iU1s-L39A_CLDTUaq6azCNVhRMhi1rsPEMUK-CH6pys1RvMr_dgaGkoVsMt9XllB7kFByHUCzY&lib=M-tpZm-Fm1QX9Yr80nZn_p-WXe3zpGnIr"
    var student = [Donor]()
    var instansiSelected:String?
    var alamatSelected:String?
    var jamSelected:String?
    var rencana_donorSelected:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStudentsData()
        
        //set row height to 92
        tableView.estimatedRowHeight = 92.0
        //set row table height to automatic dimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return student.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.labelHeight.text = student[indexPath.row].instansi
        cell.labelCountry.text = student[indexPath.row].jam
        cell.labelName.text = student[indexPath.row].rencana_donor
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        let dataTask = student[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        instansiSelected = dataTask.instansi
        alamatSelected = dataTask.alamat
        jamSelected = dataTask.jam
        var rencana_donorSelected:String? = dataTask.rencana_donor
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "segue"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke ViewController
            let sendData = segue.destination as! ViewController
            sendData.passName = instansiSelected
            sendData.passDob = alamatSelected
            sendData.passCountry = jamSelected
            sendData.passHeight = rencana_donorSelected
        }
    }
    func getStudentsData() {
        guard let studentsURL = URL(string: studentURL) else {
            return //this return is for back up the value that got when call variable loanURL
        }
        let request = URLRequest(url: studentsURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                //condition when error
                //print error
                print(error)
                return //back up value error that we get
            }
            //parse JSON data
            //declare variable data to call data
            if let data = data {
                //for this part will call method parseJsonData that we will make in below
                self.student = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation({
                    //reload data again
                    self.tableView.reloadData()
                })
            }
        })
        //task will resume to call the json data
        task.resume()
    }
    func parseJsonData(data: Data) -> [Donor] {
        var student = [Donor]()
        do{
            //declare jsonResult for take data from the json
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            //parse json data
            //declare jsonLoans for call data array jsonResult with name Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //will call data be repeated for jsonLoan have data json array from variable jsonLoans
            for jsonLoan in jsonLoans {
                //declare loan as object from class loan
                let studentss = Donor()
                studentss.instansi = jsonLoan["instansi"] as! String
                studentss.alamat = jsonLoan["alamat"] as! String
                studentss.jam = jsonLoan["jam"] as! String
                studentss.rencana_donor = jsonLoan["rencana_donor"] as! String
                
                student.append(studentss)
            }
        }catch{
            print(error)
        }
        return student
    }
}


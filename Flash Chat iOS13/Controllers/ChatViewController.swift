//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages = [
        
        Message(sender: "dhruval123@gmail.com", body: "Hi"),
        Message(sender: "dhruval123@gmail.com", body: "Hello"),
        Message(sender: "dhruval123@gmail.com", body: "How are you ? fine how are you ? great how are you ?  badhiya how are you? jakkas how are you? jalasa how are you? moje moj")
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        
        //        title = "⚡️FlashChat"
        title = K.title
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            
            self.messageTextfield.text = ""
            
            //aanthi nichenuc eh e background che ane aanthi upar nu che e forgroud ma forground ma lakhavu hoy to DispatchQueue.main.async { aa code no varvano ane jo badk ground mathi for ground ma aavu hooy to aa code vaprvo pade
            db.collection(K.FStore.collectionName).addDocument(data: [
                //K.Fstore.collectionName che e messages che ene messages name store karyu che fire base ma
            // collection nu nam messages
                K.FStore.senderField: messageSender,
              // sender che e messageSender che
                K.FStore.bodyField: messageBody,
                
                //k.Fstore.bodyField e "body" che e constant static mathi lakhyu che
                //[string:any] string che e key che any che e value che
                // body che e messagebody che
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let err = error{
                    print("not able to save the data", err)
                } else {
                    print("your message is successfully submited")
                    
// upar nu kam badhu background ma thai che api call karvo, data add karvo
// background pote ui ma ferfar no kari shake e ferfar karvanu kam ui (main) nu che etle background ne ui sathe jodava mate etle ke background na code ma sathe ui(main) no code lakhavo hoy to dispatchQueue.main.async ni andar lakhavu (asyncronas etle ek pachi ek no hoy evu ane syncronas etle ek pachi ek) dispatchQueue (queue etle line & line ni pachal jodavu dispatchqueue na code ne main(ui) sathe jodi de & send button upar click kari e e deta store thai jay pachi e main ne ke ke have text ne khali kari dyo
                  
                    
//                    DispatchQueue.main.async {
//                        self.messageTextfield.text = ""
//                    }
                }
            }
        }
    }
    
    func loadMessages(){
       
        //K.FStore.collection name ni jagya e aapde "messages"pan lakhi shakiye
        //.documents ni jagya e addSnapshotListener lakhyu e send button pressed kari e tyare table veiw nam no code and laod massages nam no code run thai & addSnapshot e real time data darshava mate vapray che reat time data dekhade screen ma && date order valu aapdo je data strore thai firebase ma e 1970 thi atryre ketalami second e print thayo e dekhade ane navo data niche aave ane juno upar em line ma print thai
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            if let err = error{
                print ("some problem while fetching your data", err)
            } else {
                if let documents = querySnapshot?.documents {
                    for doc in documents {
                        // one by one data nikale che documents mathi ane doc ma store thai che ane documents no data access karv hoy to .data thi karvo pade
                        let oneData = doc.data()
                        print (" one sender and  one body data", oneData)
                        
                        let newMessage = Message(sender: oneData[K.FStore.senderField] as! String, body: oneData[K.FStore.bodyField] as! String)
                        
                        //navo message bne che ema k.Fstore.senderField ni jagy e "sender" pan lakhay ane e string type nu che e apde blueprint ma kidhu che ke e string ma hashe etle as! String lakhyu che ... aarray mathi koi vastu access karva mate oneData[k.fstore.senderfield] one data e ek data che je documentmathi male che e malela data mathi aapde sender no data lidho che ane biji jagya e aapde body no data lidho che [string:any] dabi baju che e key che ane string key che ane jamani baju che e value che any aama sender ane body che e key che ane sender ma ane body ma lakheli vastu che e eni value che sender ni andar aapde  dhruval123@gmail.com lakhelu che ane body ni andar aapde aapdo koi pan massage lakhelo che jem ke hii hello how are you ..
                        
                        self.messages.append(newMessage)
                        
                        
                        
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //table view reaload thai background mathi data ave e pela baki badhi prepration thai jay pachi direct deta ema display thai text lakhay e block banavo ke pani side ma aapdo photo hoy e darshavo
                    //row ketala mi row e javanu che e
                    let indexPath = IndexPath(row: self.messages.count - 1 , section: 0)
                    
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    
                }
                
                
            }
            
            
        }
    }
    
   // func getDataError(querysnapshot:QuerySnapshot?, error:Error) upar na funcation ma getDAtaError lakhine call kari getDataError shakay pan upar aapde trailing closer ni rit kari che, trailing closer ma aagal nu nam nikali jay (completion) kem ke e last ma che etale
     //aen QuerySnapshot? ne nam apyu che querySnapshot
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
    // MARK: - UITableViewDataSource
    
    extension ChatViewController: UITableViewDataSource {
        
        //ketali row jove che kevanu che
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count //total length ketali che array ni e batave
        }
        
        //jetali row hashe etali var niche nu function run thashe ane etali vaar cell devo padashe pachi e display thashe
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
            
            let message = messages[indexPath.row]
            
            // massage sender e aama array ma sender ma lakhelu email je alag alag email id hoy shake ane je accout mathi message send kare(kya email nu accout) e same che to image jamani banu aavashe nakar dabi baju aavashe
            
            // badha message ek sathe load thai che etale banne ma color aapya
            if message.sender == Auth.auth().currentUser?.email{
                cell.leftAvatarImage.isHidden = true
                cell.rightAvatarImage.isHidden = false
                
                cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
                cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
                
            } else {
                cell.leftAvatarImage.isHidden = false
                cell.rightAvatarImage.isHidden = true
                
                cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
                cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
            }
             
            
            
        //.row che e ketala mi row che eno number batave che etlae upar messages.count ma total row ketali che e khabar pade ane index.row ma aapde ketalami row specific joi e che ekhabar pade etale messages[0] etlae array ni peli row ma cell banavyo ane e cell ma je text lakhavano hoy e message.text thi lakhayo
            // cell.textLabel?.text = message[indexPath.row].body
            cell.messageLabel.text = messages[indexPath.row].body
            return cell
            
            
        }
    }


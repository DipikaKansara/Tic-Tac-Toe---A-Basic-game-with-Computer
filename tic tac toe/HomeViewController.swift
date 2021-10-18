//
//  HomeViewController.swift
//  tic tac toe
//
//  Created by Dipika Kansara on 18/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var playernameLbl: UILabel!
    @IBOutlet var platerScoreLbl: UILabel!
    @IBOutlet var computerLbl: UILabel!
    @IBOutlet var computerScoreLbl: UILabel!
    
    
    @IBOutlet var square1: UIImageView!
    @IBOutlet var square2: UIImageView!
    @IBOutlet var square3: UIImageView!
    @IBOutlet var square4: UIImageView!
    @IBOutlet var square5: UIImageView!
    @IBOutlet var square6: UIImageView!
    @IBOutlet var square7: UIImageView!
    @IBOutlet var square8: UIImageView!
    @IBOutlet var square9: UIImageView!
    
    var playername : String!
    
    var lastValue = "o"
    
    var playerchoice: [Square] = []
    var computerChoice: [Square] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playernameLbl.text = playername + ":"
        
        
        tapOnSquare(on: square1, type: .one)
        tapOnSquare(on: square2, type: .two)
        tapOnSquare(on: square3, type: .three)
        tapOnSquare(on: square4, type: .four)
        tapOnSquare(on: square5, type: .five)
        tapOnSquare(on: square6, type: .six)
        tapOnSquare(on: square7, type: .seven)
        tapOnSquare(on: square8, type: .eight)
        tapOnSquare(on: square9, type: .nine)
        

    }
    
    func tapOnSquare(on imageview: UIImageView, type squaredata: Square){
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector(self.sqaureClicked(_:)))
        
        tap.name = squaredata.rawValue
        imageview.isUserInteractionEnabled = true
        imageview.addGestureRecognizer(tap)
        
        
    }
    
    @objc func  sqaureClicked(_ sender : UITapGestureRecognizer){
        
        let selectedSquare = getsquare(from: sender.name ?? "")
        
      makechoice(selectedSquare)
        
        playerchoice.append(Square(rawValue: sender.name!)!)
        checkifWon()
        	
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.computerPlay()
        }
        
    }
    
    func computerPlay(){
        var availableSpace = [UIImageView]()
        var availableSquare = [Square]()
        
        
        for name in Square.allCases{
            let box =  getsquare(from: name.rawValue)
            if box.image == nil{
                availableSpace.append(box)
                availableSquare.append(name)
            }
        }
        
        guard availableSquare.count > 0 else {return}
        
        let rendomindex = Int.random(in: 0..<availableSpace.count)
        makechoice(availableSpace[rendomindex])
        
        computerChoice.append(availableSquare[rendomindex ])
        
        checkifWon()
    }
    
    
    func makechoice(_ selectedSquare: UIImageView){
        
        guard selectedSquare.image == nil else {return}
        
        if lastValue ==  "x" {
            
            selectedSquare.image = #imageLiteral(resourceName: "Zero")
            lastValue = "o"
        }
        else{
            selectedSquare.image = #imageLiteral(resourceName: "cross")
            lastValue = "x"
            
        }
    }
    
    
    func checkifWon(){
        var correctarray = [[Square]]()
        
        let upperRow : [Square] =  [.one, .two, .three]
        let middleRow : [Square] =  [.four, .five, .six]
        let bottomRow : [Square] =  [.seven, .eight, .nine]
        
        
        
        let firstCol : [Square] =  [.one, .two, .three]
        let secondCol : [Square] =  [.four, .five, .six]
        let thirdCol : [Square] =  [.seven, .eight, .nine]
        
        
        
        let backslash : [Square] =  [.one, .five, .nine]
        let forwardslash : [Square] =  [.three, .five, .seven]
      
        
        correctarray.append(upperRow)
        correctarray.append(middleRow)
        correctarray.append(bottomRow)
        correctarray.append(firstCol)
        correctarray.append(secondCol)
        correctarray.append(thirdCol)
        correctarray.append(backslash)
        correctarray.append(forwardslash)
        
        
        for validdata in correctarray {
            let usermatch = playerchoice.filter {
                validdata.contains($0)
            }.count
            let computermatch = computerChoice.filter {
                validdata.contains($0)
            }.count
            
            
            if usermatch == validdata.count {
                
                platerScoreLbl.text = String((Int(platerScoreLbl.text ?? "0") ?? 0) + 1)
                resetGame()
                break
                
            }
            else if computermatch == validdata.count{
                
                computerScoreLbl.text = String((Int(computerScoreLbl.text ?? "0") ?? 0) + 1)
                
                resetGame()
                break
                
            }
            else if computerChoice.count + playerchoice.count == 9{
               resetGame()
                break
            }
        }
        
        
    }
    
    
    func resetGame(){
        for name in Square.allCases{
            let Box  = getsquare(from: name.rawValue)
            Box.image = nil
        }
        
        lastValue = "o"
        playerchoice = []
        computerChoice = []
        
    }
    
    
    func getsquare (from name: String) -> UIImageView{
        
        let squaredata = Square(rawValue: name) ?? .one
        
        switch squaredata {
        case .one:
            return square1
        case .two:
            return square2
        case .three:
            return square3
        case .four:
            return square4
        case .five:
            return square5
        case .six:
            return square6
        case .seven:
            return square7
        case .eight:
            return square8
        case .nine:
            return square9
            
        }
        
    }
    
    
   
    @IBAction func closebtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
       
    }
    
}


enum Square : String, CaseIterable {
    
    case one, two, three, four, five, six, seven, eight, nine
    
    
}


import UIKit

class firstVC: UIViewController {
    @IBOutlet var btn: [UIButton]!
    @IBOutlet weak var turnlbl: UILabel!
    var X:[Int] = []
    @IBOutlet weak var restartbtn: UIButton!
    
    var isXplay :Bool = true
    
    var Xwin:Bool = false
    var Owin:Bool = false
    
    var Xcase:[Int] = []
    var Ocase:[Int] = []
    
    var Xwincount = 0
    var Owincount = 0
    
    var wintyp : [[Int]] = [
    [0,1,2],[0,3,6],[1,4,7],
    [2,5,8],[3,4,5],[6,7,8],
    [0,4,8],[2,4,6]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func btnHeigh() {
        for i in btn {
            i.frame.size.width = (self.view.frame.width - 64)/3
        }
    }
    func Animation(Wincase:[Int]) {
        self.turnlbl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        for i in btn.enumerated() {
            if Wincase.contains(i.offset) {
                UIView.animate(withDuration: 0.6, delay: 0) {
                    i.element.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                } completion: { _ in
                    UIView.animate(withDuration: 0.4, delay: 0) {
                        i.element.transform = .identity
                        self.turnlbl.transform = .identity
                }
            }
        }
    }
    }
    
    func enablebtn(isEnable:Bool,title:UIImage? = nil) {
        for i in btn {
            i.isEnabled = isEnable
            if title != nil {
                i.setImage(nil, for: .normal)
            }
        }
    }
    
    
    
    
    
    @IBAction func btntap(_ sender: UIButton) {
        if sender.currentTitle == nil {
            if isXplay {
                Xcase.append(sender.tag)
                turnlbl.text = "turn O"
                sender.setImage(UIImage(named: "X"), for: .normal)
                isXplay = false
                
            } else {
                Ocase.append(sender.tag)
                turnlbl.text = "turn X"
                sender.setImage(UIImage(named: "O"), for: .normal)

                isXplay = true
            }
            for i in btn {
                
                i.isEnabled = i.currentTitle == nil
            }
            if Xcase.count >= 3 || Ocase.count >= 3 {
                for win in wintyp {
                    Xwincount = 0
                    Owincount = 0
                    for j in win {
                        if Xcase.contains(j){
                            Xwin = true
                            Xwincount += 1
                        } else {
                            Xwin = false
                        }
                        if Ocase.contains(j) {
                            Owin = true
                            Owincount += 1
                        } else {
                            Owin = false
                        }
                    }
                    
                    if Xwin && Xwincount >= 3 {
                        turnlbl.text = "X win!!!"
                        enablebtn(isEnable: false)
                        Animation(Wincase: win)
                        break
                    } else if Owin && Owincount >= 3 {
                        turnlbl.text = "O win!!!"
                        enablebtn(isEnable: false)
                        Animation(Wincase: win)
                        break
                    } else {
                        if (Xcase.count + Ocase.count) == 9 {
                            
                            if Xwin && Xwincount >= 3 {
                                turnlbl.text = "X win!!!"
                                enablebtn(isEnable: false)
                                
                            } else if Owin && Owincount >= 3 {
                                turnlbl.text = "O win!!!"
                                enablebtn(isEnable: false)
                            } else {
                                turnlbl.text = "It's a tie"
                                enablebtn(isEnable: false)
                            }
                    }
                    
                    
                }
            }
        }
        
        
    }
    }

   
    
    @IBAction func resetbtn(_ sender: UIButton) {
        isXplay = true
        
        Xwin = false
        Owin = false
        
        Xcase = []
        Ocase = []
        
        turnlbl.text = "turn X"
        enablebtn(isEnable: true,title: UIImage(named: "oqrasm"))
    
    }
    
}

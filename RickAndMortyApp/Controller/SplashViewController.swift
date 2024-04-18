//
//  SplashViewController.swift
//  RickAndMortyApp
//
//  Created by Noel H. Yusta on 18/4/24.
//
import Foundation
import UIKit


class SplashScreenViewController:UIViewController {
    

    @IBOutlet weak var animationImageView: UIImageView!
    
    
        
    //VARIABLES
    let animationDuration:TimeInterval = 4
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Esta va a ser la rueda
        animationImageView.image = UIImage(named: "rick3.png")
        
        loadAnimations()
        timer = Timer.scheduledTimer(timeInterval: animationDuration,
                                         target: self,
                                         selector: #selector(fireTimer),
                                         userInfo: nil,
                                         repeats: false)
    }
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
       
    override func viewWillDisappear(_ animated: Bool) {
           
    }
    
    
    func loadAnimations() {
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [],
                       animations:
                        {
                        self.animationImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
                       },
                       completion: {(finished: Bool) -> Void in
                       })
        
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.75,
                       options: [],
                       animations:
                        {
            self.animationImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi*2)
                        },
                       completion: nil)
        
        
        UIView.animate(withDuration: 0.4,
                       delay: 2.25,
                       options: [.autoreverse, .curveEaseIn],
                       animations: {
            self.animationImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.animationImageView.layer.repeatCount = 1
                       },
                       completion: {(finished: Bool) -> Void in
            
            self.animationImageView.layer.removeAllAnimations()
        })
        
        
    }
    
    func goToPresentationViewController(){
       
        
        let presentationViewController: PresentationViewController = self.storyboard?.instantiateViewController(withIdentifier: "PresentationViewController") as! PresentationViewController
        
        self.navigationController?.pushViewController(presentationViewController, animated: true)
    }
    
    @objc func fireTimer() {
        
        print("Se acabó la animación")
        
        self.animationImageView.stopAnimating()
        self.dismiss(animated: false, completion: nil)
        
        
        goToPresentationViewController()
    }
    
}


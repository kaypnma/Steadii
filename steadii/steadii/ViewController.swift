//
//  ViewController.swift
//  steadii
//
//  Created by Kay Arellano on 2019-10-26.
//  Copyright © 2019 iiStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*var scrollViewController: ScrollViewController!
    var visualEffectView:UIVisualEffectView!
    
    enum cardState {
        case expanded
        case collapsed
    }
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 65
    
    var cardVisible = false
    var nextState:cardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
 */
    
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupCard()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Following function is for a pull up view - may or may not be used
    /*
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        scrollViewController = ScrollViewController(nibName:"ScrollViewController", bundle:nil)
        self.addChild(scrollViewController)
        self.view.addSubview(scrollViewController.view)
        
        scrollViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        scrollViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target:self, action: #selector(ViewController.handleCardPan(recognizer:)))
        
        scrollViewController.handleArea.addGestureRecognizer(tapGestureRecognizer) //cardHandleAreaHeight - handleArea in video
        scrollViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
    }
    @objc
    func handleCardTap(recognizer:UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan(recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            //startTrabsutuib
            startInteractiveTransition(state:nextState, duration: 0.9)
        case .changed:
            //update Transition
            let translation = recognizer.translation(in: self.scrollViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted:fractionComplete)
            //updateInteractiveTransition(fractionCompleted: 0)
        case .ended:
            //continueTransition
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state:cardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                    case .expanded:
                        self.scrollViewController.view.frame.origin.y = self.view.frame.height
                            - self.cardHeight
                case .collapsed:
                        self.scrollViewController.view.frame.origin.y = self.view.frame.height
                            - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion{ _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.scrollViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.scrollViewController.view.layer.cornerRadius = 0
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                    
                }
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition (state:cardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            //run animations
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    func updateInteractiveTransition (fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
            
        }
    }
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    */
 
}


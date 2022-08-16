//
//  SpeechRecognitionViewController.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import UIKit

class SpeechRecognitionViewController: UIViewController, SpeechRecognitionViewable {
    
    var presenter: SpeechRecognitionPresentable!
    lazy var speechRecognitionView = view as! SpeechRecognitionView
    lazy var speechLabel = speechRecognitionView.label
    
    override func loadView() {
        view = SpeechRecognitionView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        handleOnCustomActions()
    }
    
    func set(text: String) {
        DispatchQueue.main.async {
            self.speechLabel.text = text
        }
    }
    
    private func handleOnCustomActions() {
        speechRecognitionView.didPressStopButton = {
            self.presenter.handleAddNote()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

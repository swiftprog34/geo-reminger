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
    
    func informUser(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                alert.dismiss(animated: true, completion: nil)
                self.presenter.afterAddNoteAction()
            }
        }
    }
    
    private func handleOnCustomActions() {
        speechRecognitionView.didPressStopButton = {
            self.presenter.handleAddNote(text: self.speechLabel.text!)
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

//
//  SpeechRecognitionPresenter.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import Foundation
import Speech

class SpeechRecognitionPresenter: NSObject, SpeechRecognitionPresentable, SFSpeechRecognizerDelegate {
    
    weak var coordinator: Coordinatable?
    weak var view: SpeechRecognitionViewable!
    
    /// Объект операции распознавания голоса
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ru"))
    /// Обработка запросов на распознавание голоса и предоставление голосового ввода для распознавания голоса
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    /// Сообщаем пользователю результат объекта распознавания голоса. Владеть этим объектом удобно, потому что вы можете использовать его для удаления или прерывания задач
    private var recognitionTask: SFSpeechRecognitionTask?
    /// Голосовой движок. Ответственный за обеспечение голосового ввода
    private let audioEngine = AVAudioEngine()
    
    //MARK: Initializers
    
    init(view: SpeechRecognitionViewable) {
        self.view = view
    }
    
    func onViewDidLoad() {
        enablingSpeechRecognizer()
    }
    
    func handleAddNote() {
        print("Handle add note")
    }
    
    private func enablingSpeechRecognizer() {
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized: // Пользователь авторизовал распознавание речи
                isButtonEnabled = true
                self.startRecording()
            case .denied: // Пользователь отказывается авторизовать распознавание речи
                isButtonEnabled = false
                print("User denied access to speech recognition")
            case .restricted: // Устройство не поддерживает распознавание голоса
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
            case .notDetermined: // результат неизвестен Пользователь не сделал выбор
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            @unknown default:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
        }
    }
    
    private func startRecording() {
        if recognitionTask != nil {/// Проверить, выполняется ли translationTask, если оно есть, отменить задачу и распознавание
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance () /// подготовиться к записи голоса
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        /// Создайте запрос RecRequest и используйте его для передачи голосовых данных в серверную часть Apple.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        /// Проверьте, имеет ли audioEngine (ваше устройство) функцию записи в качестве голосового ввода
        let inputNode = audioEngine.inputNode
        
        /// Проверяем, создан ли объект распознавания, или нет
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecongitionRequest object")
        }
        
        /// Позволяет RecReReest сообщать частичные результаты распознавания речи, когда пользователь говорит
        recognitionRequest.shouldReportPartialResults = true
        
        /// Включите распознавание речи, обратный вызов будет вызываться каждый раз, когда механизм распознавания получает ввод, завершает текущую информацию распознавания, или удаляется или останавливается, и, наконец, возвращает окончательный текст
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false // Определить логическое значение, чтобы определить, завершилось ли распознавание
            
            /// Если результат не ноль, установить значение textView.text для нашего оптимального текста. Если результат является окончательным, установите для isFinal значение true
            if result != nil {
                if let string = result?.bestTranscription.formattedString {
                    DispatchQueue.main.async {
                        self.view.set(text: string)
                    }
                }
                isFinal = (result?.isFinal)!
            }
            
            /// Если ошибки нет или результат является конечным результатом, остановите audioEngine (голосовой ввод) и остановите распознаваниеRequest иognistTask
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
//                self.microphoneButton.isEnabled = true
            }
        })
        
        /// Добавить голосовой ввод в распознавание запроса. Обратите внимание, что можно добавить голосовой ввод после запуска распознавания. SpeechFramework начнет анализ и распознавание, как только будет добавлен речевой ввод
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        /// Подготовить и запустить audioEngine
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error")
        }
        
        view.set(text: "Say something, I'm listening!")
    }
    
    
}




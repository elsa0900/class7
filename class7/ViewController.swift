//
//  ViewController.swift
//  class7
//
//  Created by 劉美君 on 2024/4/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentBlue: UIView!
    @IBOutlet weak var contentRed: UIView!
    @IBOutlet weak var pointBlueLabel: UILabel!
    @IBOutlet weak var pointRedLabel: UILabel!
    
    @IBOutlet weak var processBar: UIProgressView!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var numberSectionLabel: UILabel!
    
    @IBOutlet weak var playCountTimerBtn: UIButton!
    @IBOutlet weak var stopCountTimerBtn: UIButton!
    @IBOutlet weak var overtimeBtn: UIButton!
    
    var timer: Timer?
    var countdown: Int = 10 * 60 // 幾分鐘的秒數
    var totalProgress: Float = 0.0 // 進度
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 歸零
        processBar.setProgress(0.0, animated: false)
        // view
        stopCountTimerBtn.isHidden = true
        overtimeBtn.isHidden = true
    }
    
    @IBAction func playTime(_ sender: Any) {
        startCountdown()
        playCountTimerBtn.isHidden = true
        stopCountTimerBtn.isHidden = false
    }
    
    @IBAction func stopTime(_ sender: Any) {
        timer?.invalidate()
        playCountTimerBtn.isHidden = false
        stopCountTimerBtn.isHidden = true
    }
    
    @IBAction func addPointBlue(_ sender: UIButton) {
        let numPoint = Int(pointBlueLabel.text!) ?? 0
        let numBtnText = Int(sender.titleLabel!.text! ) ?? 0
        pointBlueLabel.text = String(numPoint + numBtnText)
    }
    
    @IBAction func addPointRed(_ sender: UIButton) {
        let numPoint = Int(pointRedLabel.text!) ?? 0
        let numBtnText = Int(sender.titleLabel!.text! ) ?? 0
        pointRedLabel.text = String(numPoint + numBtnText)
    }
    
    func startCountdown() {
        // 創建一個計時器，每秒執行一次 tickDown 方法
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                    self?.tickDown()
                }
    }
    
    func tickDown() {
        // 更新倒計時
        countdown -= 1
        updateLabel()
        
        // 判斷是否倒計時結束
        if countdown == 0 {
            timer?.invalidate()
            // 重置倒數
            countdown = 10 * 60
            
            updateProcessBar()
            playCountTimerBtn.isHidden = false
            stopCountTimerBtn.isHidden = true
        }
    }

    func updateLabel() {
         let minutes = countdown / 60
         let seconds = countdown % 60
         countdownLabel.text = String(format: "%02d:%02d", minutes, seconds)
     }
    
    func updateProcessBar() {
        // 每個 progress 對應到的進度
        totalProgress += 0.25
        processBar.setProgress(totalProgress, animated: true)
        if totalProgress == 0.25 {
            numberSectionLabel.text = "第２節"
        } else if totalProgress == 0.5 {
            numberSectionLabel.text = "第３節"
        } else if totalProgress == 0.75 {
            numberSectionLabel.text = "第４節"
        } else if totalProgress == 1.0 , pointRedLabel.text == pointBlueLabel.text{
            // 加時賽
            overtimeBtn.isHidden = false
        }
    }
    
    deinit {
        // 頁面銷毀時停止計時器
        timer?.invalidate()
    }
    
}

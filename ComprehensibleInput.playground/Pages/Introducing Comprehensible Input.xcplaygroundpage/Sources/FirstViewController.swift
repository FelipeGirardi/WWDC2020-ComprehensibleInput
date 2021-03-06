import UIKit
import AVFoundation

public class FirstViewController: UIViewController {
    
    var player: AVAudioPlayer? = AVAudioPlayer()
    var indexFlag: Int = -1
    var didPressWordToWordButton: Bool = false
    var audioPlayedCounter: Int = 0
    
    let juanButton = UIButton()
    let comeButton = UIButton()
    let laButton = UIButton()
    let manzanaButton = UIButton()
    let stackView1 = UIStackView()
    
    let imageLabel = UILabel()
    let relatedLabel = UILabel()
    let wordByWordButton = UIButton()
    let stackView2 = UIStackView()
    
    let juanLabel = UILabel()
    let eatsLabel = UILabel()
    let theLabel = UILabel()
    let appleLabel = UILabel()
    let translationStackView = UIStackView()
    
    var buttonsES: [UIButton] = []
    var labelsEN: [UILabel] = []
    let buttonTextsES = ["Juan", "come", "la", "manzana."]
    let labelTextsEN = ["Juan", "eats", "the", "apple."]
    let audioFileNames = ["Juan", "Come", "La", "Manzana"]
    let emojiList = ["", "🍽", "", "🍎"]
    let colorsList = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.5019607843137255, green: 0.5019607843137255, blue: 0.5019607843137255, alpha: 1.0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.807843137254902, green: 0.027450980392156862, blue: 0.3333333333333333, alpha: 1.0)]
    let fontsList = [UIFont.systemFont(ofSize: 40.0, weight: .regular), UIFont.systemFont(ofSize: 40.0, weight: .bold), UIFont.systemFont(ofSize: 40.0, weight: .regular), UIFont.systemFont(ofSize: 40.0, weight: .bold)]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLayout()
    }
    
    func prepareLayout() {
        self.view.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        buttonsES = [juanButton, comeButton, laButton, manzanaButton]
        labelsEN = [juanLabel, eatsLabel, theLabel, appleLabel]
        
        // Configure StackViews
        setStackViews()
        
        // Configure buttons iteratively
        for (index, button) in buttonsES.enumerated() {
            button.setTitle(buttonTextsES[index], for: .normal)
            button.setTitleColor(colorsList[index], for: .normal)
            button.titleLabel?.font = fontsList[index]
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.wordTapped), for: UIControl.Event.touchUpInside)
            
            stackView1.addArrangedSubview(button)
            button.sizeToFit()
        }
        
        stackView2.addArrangedSubview(stackView1)
        
        // Set related label
        setRelatedLabel()
        
        // Set word by word button
        setWordByWordButton()
        
        // Add main stack view to self.view
        self.view.addSubview(stackView2)
        stackView2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // Set image label
        setImageLabel()
    }
    
    func setStackViews() {
        stackView1.axis = NSLayoutConstraint.Axis.horizontal
        stackView1.distribution = UIStackView.Distribution.equalSpacing
        stackView1.alignment = UIStackView.Alignment.center
        stackView1.spacing = 100
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        
        stackView2.axis = NSLayoutConstraint.Axis.vertical
        stackView2.distribution = UIStackView.Distribution.equalSpacing
        stackView2.alignment = UIStackView.Alignment.center
        stackView2.spacing = 300
        stackView2.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setWordByWordButton() {
        wordByWordButton.setTitle("Word by word", for: .normal)
        wordByWordButton.titleLabel?.textAlignment = .center
        wordByWordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        wordByWordButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        wordByWordButton.setTitleColor(UIColor.black, for: .normal)
        wordByWordButton.backgroundColor = .green
        wordByWordButton.layer.borderWidth = 3
        wordByWordButton.layer.borderColor = UIColor.green.cgColor
        wordByWordButton.translatesAutoresizingMaskIntoConstraints = false
        wordByWordButton.addTarget(self, action: #selector(self.wordByWordButtonTapped), for: UIControl.Event.touchUpInside)
        
        stackView2.addArrangedSubview(wordByWordButton)
        wordByWordButton.sizeToFit()
        wordByWordButton.layer.cornerRadius = wordByWordButton.frame.size.height/2.0
        wordByWordButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // React to word tap
    @objc func wordTapped(_ sender: UIButton) {
        if(self.indexFlag == -1) {
            self.wordByWordButton.isEnabled = false
            
            // Movement animation
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.40),
                           initialSpringVelocity: CGFloat(6.0),
                           options: UIView.AnimationOptions.allowUserInteraction,
                           animations: {
                            sender.transform = CGAffineTransform.identity
            }, completion: nil)
            
            if sender === juanButton {
                self.indexFlag = 0
                playAudio(fileName: audioFileNames[self.indexFlag])
            } else if sender === comeButton {
                self.indexFlag = 1
                animateLabelHalf1(content: emojiList[self.indexFlag])
                playAudio(fileName: audioFileNames[self.indexFlag])
            } else if sender === laButton {
                self.indexFlag = 2
                playAudio(fileName: audioFileNames[self.indexFlag])
            } else if sender === manzanaButton {
                self.indexFlag = 3
                animateLabelHalf1(content: emojiList[self.indexFlag])
                playAudio(fileName: audioFileNames[self.indexFlag])
            }
        }
    }
    
    // Animations
    func animateLabelHalf1(content: String) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            self.relatedLabel.alpha = 0
        }, completion: { animation1Done in
            if(animation1Done) {
                self.imageLabel.text = content
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                    self.imageLabel.alpha = 1
                }, completion: nil)
            }
        })
    }
    
    func animateLabelHalf2() {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                self.imageLabel.alpha = 0
            }, completion: { animation3Done in
                if(animation3Done) {
                    self.imageLabel.text = ""
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                        self.relatedLabel.alpha = 1
                    }, completion: nil)
                }
            })
    }
    
    // Set label
    func setRelatedLabel() {
        relatedLabel.font = UIFont.systemFont(ofSize: 40.0, weight: .regular)
        relatedLabel.text = "Tap a colored word to see a related image"
        relatedLabel.numberOfLines = 0
        relatedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView2.addArrangedSubview(relatedLabel)
    }
    
    func setImageLabel() {
        imageLabel.text = ""
        imageLabel.font = UIFont.systemFont(ofSize: 200.0, weight: .regular)
        imageLabel.numberOfLines = 0
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.alpha = 0
        
        self.view.addSubview(imageLabel)
        imageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    // Audio
    func playAudio(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "m4a") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)            
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.delegate = self
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func prepareTranslationStackView() {
        translationStackView.axis = NSLayoutConstraint.Axis.horizontal
        translationStackView.distribution = UIStackView.Distribution.equalSpacing
        translationStackView.alignment = UIStackView.Alignment.center
        translationStackView.spacing = 20
        translationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, label) in labelsEN.enumerated() {
            label.text = labelTextsEN[index]
            label.textColor = colorsList[index]
            label.font = fontsList[index]
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            translationStackView.addArrangedSubview(label)
        }
        
        translationStackView.alpha = 0
    }
    
    @objc func wordByWordButtonTapped(_ sender: UIButton) {
        self.didPressWordToWordButton = true
        self.prepareTranslationStackView()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.wordByWordButton.alpha = 0
            self.relatedLabel.alpha = 0
        }, completion: { completion1 in
            if(completion1) {
                self.relatedLabel.text = "◼️" // Fix small tilt in words
                UIView.animate(withDuration: 0.5, animations: {
                    self.wordByWordButton.isHidden = true
                    self.relatedLabel.font = UIFont.systemFont(ofSize: 100.0, weight: .regular)
                    self.stackView1.spacing = 20
                    self.stackView2.spacing = 100
                    self.stackView2.addArrangedSubview(self.translationStackView)
                    self.stackView2.layoutIfNeeded()
                }, completion: { completion2 in
                    if(completion2) {
                        UIView.animate(withDuration: 0.5, animations: {
                            self.translationStackView.alpha = 1
                        }, completion: { completion3 in
                            if(completion3) {
                                for button in self.buttonsES {
                                    button.isEnabled = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.startWordByWordAnimation()
                                }
                                
                            }
                        })
                    }
                })
            }
        })
    }
    
    func startWordByWordAnimation() {
        // Set underline for Juan strings
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 40.0),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: buttonTextsES[0], attributes: attributes)
        
        UIView.transition(with: buttonsES[0], duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in self?.buttonsES[0].setAttributedTitle(attributeString, for: .normal)
            }, completion: nil)
        
        UIView.transition(with: self.labelsEN[0], duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in 
            self?.labelsEN[0].attributedText = attributeString
            }, completion: nil)
        
        // Movement animations
        self.buttonsES[0].transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.40),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.buttonsES[0].transform = CGAffineTransform.identity
        }, completion: nil)
        
        labelsEN[0].transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.40),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.labelsEN[0].transform = CGAffineTransform.identity
        }, completion: nil)
        
        playAudio(fileName: "Juan")
        
    }
    
}

extension FirstViewController: AVAudioPlayerDelegate {
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if(!self.didPressWordToWordButton) {
            if(flag && (self.indexFlag == 1 || self.indexFlag == 3) && !self.didPressWordToWordButton) {
                self.animateLabelHalf2()
            }
            self.indexFlag = -1
            self.wordByWordButton.isEnabled = true
        } else {
            if(flag) {
                audioPlayedCounter += 1
            }
            if(self.audioPlayedCounter != self.buttonTextsES.count) {
                wordByWordAnimations(counter: self.audioPlayedCounter)
            }
        }
    }
    
    func wordByWordAnimations(counter: Int) {
        removeAttributes(counter: counter)
        addAtributes(counter: counter)
        
        // Movement animations
        self.buttonsES[counter].transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.40),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.buttonsES[counter].transform = CGAffineTransform.identity
        }, completion: nil)
        
        labelsEN[counter].transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.40),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.labelsEN[counter].transform = CGAffineTransform.identity
        }, completion: nil)
        
        playAudio(fileName: audioFileNames[counter])
        
        // Animate label image
        if(counter == 1 || counter == 3) {
            UIView.animate(withDuration: 0.25, animations: {
                self.relatedLabel.text = self.emojiList[counter]
                self.relatedLabel.alpha = 1
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.relatedLabel.alpha = 0
            }, completion: nil)
        }
    }
    
    func removeAttributes(counter: Int) {
        let noAttributes: [NSAttributedString.Key: Any] = [:]
        let noAttributeStringES = NSMutableAttributedString(string: buttonTextsES[counter-1], attributes: noAttributes)
        let noAttributeStringEN = NSMutableAttributedString(string: labelTextsEN[counter-1], attributes: noAttributes)
        
        UIView.transition(with: self.buttonsES[counter-1], duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in self?.buttonsES[counter-1].setAttributedTitle(noAttributeStringES, for: .normal)
            }, completion: nil)
        UIView.transition(with: self.labelsEN[counter-1], duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in self?.labelsEN[counter-1].attributedText = noAttributeStringEN
            }, completion: nil)
    }
    
    func addAtributes(counter: Int) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: self.buttonsES[counter].titleLabel?.font ?? UIFont(),
            .foregroundColor: self.buttonsES[counter].titleLabel?.textColor ?? UIColor(),
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeStringES = NSMutableAttributedString(string: buttonTextsES[counter], attributes: attributes)
        let attributeStringEN = NSMutableAttributedString(string: labelTextsEN[counter], attributes: attributes)
        
        UIView.transition(with: self.buttonsES[counter], duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in self?.buttonsES[counter].setAttributedTitle(attributeStringES, for: .normal)
            }, completion: nil)
        UIView.transition(with: self.labelsEN[counter], duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in self?.labelsEN[counter].attributedText = attributeStringEN
            }, completion: nil)
    }
}

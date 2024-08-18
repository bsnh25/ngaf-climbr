//
//  ChooseCharacterVC.swift
//  climbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 13/08/24.
//

import Cocoa
import Swinject



class ChooseCharacterVC: NSViewController {
    private let containerBig = NSView()
    private let container1 = NSView()
    private let container2 = NSView()
    private let text1 = CLTextLabelV2(sizeOfFont: 20, weightOfFont: .bold, contentLabel: "Name your climbr")
    private let text2 = CLTextLabelV2(sizeOfFont: 20, weightOfFont: .bold, contentLabel: "Choose your climbr")
    private let malechar = NSImageView(image: .malechar1)
    private let femalechar = NSImageView(image: .femalecharacter)
    private let textField = CLTextField(placeholder: "Type your climbr's name here")
    private let buttonStart = CLTextButtonV2(title: "Start Climbing", backgroundColor: .cButton, foregroundColorText: .white, fontText: NSFont.systemFont(ofSize: 26, weight: .bold))
    private var containerIsClicked: Bool = false
    
    var genderChar: Gender?
    var charService: CharacterService?
    
    init(charService: CharacterService?){
        super.init(nibName: nil, bundle: nil)
        self.charService = charService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        configureContainerBig()
        configureText1()
        configureTextField()
        configureText2()
        configureContainer1()
        configureContainer2()
        configureFemaleChar()
        configureMaleChar()
        configureButtonStart()
    }
    
    private func configureContainerBig(){
        view.addSubview(containerBig)
        containerBig.wantsLayer = true
        containerBig.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        //        containerBig.layer?.backgroundColor = NSColor.red.cgColor
        containerBig.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerBig.topAnchor.constraint(equalTo: view.topAnchor),
            containerBig.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerBig.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerBig.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureText1(){
        view.addSubview(text1)
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.textColor = NSColor.grayChooseCharacter
        
        
        NSLayoutConstraint.activate([
            text1.topAnchor.constraint(equalTo: view.topAnchor, constant: 111),
            text1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 261)
        ])
    }
    
    private func configureTextField(){
        view.addSubview(textField)
        //        textField.delegate = self
        
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 15),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 261),
            textField.widthAnchor.constraint(equalToConstant: 322),
            textField.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func configureText2(){
        view.addSubview(text2)
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.textColor = .grayChooseCharacter
        
        NSLayoutConstraint.activate([
            text2.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 36),
            text2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 261)
        ])
    }
    
    
    private func configureContainer1(){
        view.addSubview(container1)
        container1.wantsLayer = true
        container1.layer?.cornerRadius = 10
        container1.layer?.backgroundColor = NSColor.femaleCharContainer.cgColor
        container1.translatesAutoresizingMaskIntoConstraints = false
        container1.layer?.borderWidth = 0
        
        let clickGesture1 = NSClickGestureRecognizer(target: self, action: #selector(container1Clicked(_:)))
        container1.addGestureRecognizer(clickGesture1)
        
        
        NSLayoutConstraint.activate([
            container1.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 15),
            container1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 261),
            container1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.248),
            container1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.443)
            
        ])
        
    }
    
    private func configureContainer2(){
        view.addSubview(container2)
        container2.wantsLayer = true
        container2.layer?.cornerRadius = 10
        container2.layer?.backgroundColor = NSColor.maleCharContainer.cgColor
        container2.translatesAutoresizingMaskIntoConstraints = false
        
        let clickGesture2 = NSClickGestureRecognizer(target: self, action: #selector(container2Clicked(_:)))
        container2.addGestureRecognizer(clickGesture2)
        
        NSLayoutConstraint.activate([
            container2.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 15),
            container2.leadingAnchor.constraint(equalTo: container1.trailingAnchor, constant: 39),
            container2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.248),
            container2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.443)
            
        ])
    }
    
    private func configureFemaleChar(){
        container1.addSubview(femalechar)
        femalechar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            femalechar.centerXAnchor.constraint(equalTo: container1.centerXAnchor),
            femalechar.centerYAnchor.constraint(equalTo: container1.centerYAnchor),
            femalechar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1208),
            femalechar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
        ])
    }
    
    private func configureMaleChar(){
        container2.addSubview(malechar)
        malechar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            malechar.centerXAnchor.constraint(equalTo: container2.centerXAnchor),
            malechar.centerYAnchor.constraint(equalTo: container2.centerYAnchor),
            malechar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1208),
            malechar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
        ])
    }
    
    
    private func configureButtonStart(){
        view.addSubview(buttonStart)
        
        buttonStart.target = self
        buttonStart.action = #selector(actButtonStart)
        
        
        buttonStart.isEnabled = false
        
        NSLayoutConstraint.activate([
            buttonStart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 466),
            buttonStart.topAnchor.constraint(equalTo: view.topAnchor, constant: 666),
            buttonStart.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.225),
            buttonStart.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.072),
        ])
    }
    
    
    @objc
    private func actButtonStart(){
        print("tapped and inputed \(textField.stringValue)")
        var gender: Gender!
        
        if let genderChar{
            gender = genderChar
        }else {
            print("user not choose character")
        }
        
        print("gender pal user is : \(String(describing: gender))")
        
        let userData = CharacterModel(name: textField.stringValue, gender: gender, point: 0)
        charService?.saveCharacterData(data: userData)
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.kTutorial)
        
        pop()
        
        if UserDefaults.standard.bool(forKey:UserDefaultsKey.kTutorial) {
            guard let tutorialVc = Container.shared.resolve(TutorialVC.self) else {return}
            push(to: tutorialVc)
        }
    }
    
    @objc private func container1Clicked(_ gesture: NSClickGestureRecognizer) {
        if gesture.state == .ended {
            resetBorderContainer()
            container1.layer?.borderWidth = 5
            container1.layer?.borderColor = .white
            containerIsClicked = true
            genderChar = Gender.female
            validateUserInput()
        }
    }
    
    @objc private func container2Clicked(_ gesture: NSClickGestureRecognizer) {
        if gesture.state == .ended {
            resetBorderContainer()
            container2.layer?.borderWidth = 5
            container2.layer?.borderColor = .white
            containerIsClicked = true
            genderChar = Gender.male
            validateUserInput()
        }
    }
    
    private func validateUserInput(){
        if textField.stringValue.isEmpty || !containerIsClicked{
            buttonStart.isEnabled = false
        }else{
            buttonStart.isEnabled = true
        }
    }
    
    private func resetBorderContainer(){
        container1.layer?.borderWidth = 0
        container2.layer?.borderWidth = 0
    }
    
}

//#Preview(traits: .defaultLayout, body: {
//    ChooseCharacterVC()
//})

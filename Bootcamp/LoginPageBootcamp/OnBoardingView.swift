//
//  OnBoardingView.swift
//  Bootcamp
//
//  Created by Dhruv Salot on 21/01/23.
//

import SwiftUI
import SPConfetti

// OnBoarding States:
/*
0. Wecome Screen
1. Add Name
2. Add Age
3. Add Gender
*/
enum onBoardingStates: String {
    case welcomeState = "Let's Sign Up!"
    case addNameState = "Add username 👁️"
    case addAgeState = "Add age"
    case selectGenderState = "Finish 🤩"
}

// MARK: MAIN VIEW SECTION
struct OnBoardingView: View {

    //State of onBoarding
    @State var currState: onBoardingStates = .welcomeState
    
    // User Login Inputs
    @State var name: String = ""
    @State var age: Double = 18.0
    @State var gender: Gender = Gender.others
    
    //App Storage
    @AppStorage("username") var currentUserName: String?
    @AppStorage("age")    var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: Gender?
    @AppStorage("signed_in") var userIsSignedIn: Bool = false

    
    //for allerts
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    //for confetti animation
    @State var confettiShown = false
    
    let onBoardingTransition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    var body: some View {
        VStack {
            Spacer()
            //content
            switch currState {
            case .welcomeState:
                welcomeScreen.transition(onBoardingTransition)
            case .addNameState:
                nameScreen.transition(onBoardingTransition)
            case .addAgeState:
                ageScreen.transition(onBoardingTransition)
            case .selectGenderState:
                genderScreen.transition(onBoardingTransition)
            }
            Spacer()
            //button
            joinButton
                .padding(.bottom)
                .confetti(isPresented: $confettiShown,
                           animation: .fullWidthToDown,
                           particles: [.triangle, .arc],
                           duration: 3.0)
                
        }
        
        .alert(Text(alertTitle), isPresented: $showAlert) { }
    }
}

// MARK: PREVIEW SECTION
struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            backGround
            OnBoardingView()
        }
    }
}

// MARK: COMPONENETS
extension OnBoardingView {
    
    private var joinButton: some View {
        Button {
            buttonAction()
        } label: {
            Text("\(currState.rawValue)")
                .font(.title)
                .frame(maxWidth: .infinity)
        }
        .padding(20)
        .buttonBorderShape(.roundedRectangle(radius: 20))
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
    
    private var welcomeScreen: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                
            
            VStack(spacing: 40) {
                
                Image(systemName: "heart.text.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(Color.pink.opacity(0.8))
                
                Text("Start Cuddling 🥰!")
                    .font(.title)
                    .bold()

                Text("This is the #1️⃣ app for finding your match online! In this tutorial we are practicing using AppStorage and other SwiftUI techniques. ❤️")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 30)
                    .font(.headline)
                    .bold()
            }
            
        }
        .padding(20)
        .padding(.vertical, 50)
        .cornerRadius(20)
    }
    
    private var nameScreen: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .padding(.vertical, 50)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("What should we call you?")
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .bold()
                    
                TextField("Your name here", text: $name)
                    .font(.title2)
                    .padding(20)
                    .background(.thickMaterial)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding(20)
            
        }
        .padding(20)
        .cornerRadius(20)
    }
    
    private var ageScreen: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .padding(.vertical, 50)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("How old are you?")
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .bold()
                Slider(value: $age, in: 18...100, step: 1)
                    .padding(.vertical)
                    .padding(.bottom)
                    .tint(Color.purple)
                Text("\(String(format: "%0.0f", age)) years old")
                    .font(.title)
                Spacer()
            }
            .padding(20)
        }
        .padding(20)
        .cornerRadius(20)
    }
    
    private var genderScreen: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .padding(.vertical, 50)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("How do you identify yourself?")
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .bold()
                
                
                HStack {
                    Text("I identify as ")
                        .font(.title2)
                        .bold()
                    Picker(selection: $gender) {
                        Text("Others 🧔🏻‍♀️").tag(Gender.others)
                        Text("Male    🧔🏻‍♂️").tag(Gender.male)
                        Text("Female 👩🏻").tag(Gender.female)
                    } label: { Text("Gender") }
                        .pickerStyle(InlinePickerStyle())
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.15))
                        
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            .padding(20)
            
        }
        .padding(20)
        .cornerRadius(20)
    }
}

// MARK: FUNCTIONS

extension onBoardingStates {
    mutating func toggle() -> Void {
        switch self {
        case .welcomeState:
            self = .addNameState
        case .addNameState:
            self = .addAgeState
        case .addAgeState:
            self = .selectGenderState
        case .selectGenderState:
            self = .welcomeState
        }
    }
}

extension OnBoardingView {
    private func buttonAction() {
        //Checking username inputs
        if (currState == .addNameState){
            guard name.count > 3 else {
                alertTitle = "Your name should be 3 characters long 😩"
                showAlert.toggle()
                return
            }
        }
        
        //Sign In Complete?
        if currState == .selectGenderState {
            confettiShown.toggle()
            signIn()
            
        } else {
            withAnimation {
                currState.toggle()
            }
        }
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring()) {
            userIsSignedIn = true
        }
    }
}

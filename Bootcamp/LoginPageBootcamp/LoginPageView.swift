//
//  LoginPageView.swift
//  Bootcamp
//
//  Created by Dhruv Salot on 21/01/23.
//

import SwiftUI

struct LoginPageView: View {
    
    @AppStorage("signed_in") var userIsSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            //background
            backGround
            
            //contents
            switch userIsSignedIn {
            case true:
                LoggedInView()
                    .transition(.move(edge: .leading))
            case false:
                OnBoardingView()
                    .transition(.move(edge: .trailing))
            }
        }
        
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

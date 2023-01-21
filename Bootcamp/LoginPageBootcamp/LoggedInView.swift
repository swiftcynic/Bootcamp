//
//  LoggedInView.swift
//  Bootcamp
//
//  Created by Dhruv Salot on 21/01/23.
//

import SwiftUI

struct LoggedInView: View {
    
    @AppStorage("username") var currentUserName: String?
    @AppStorage("age")    var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: Gender?
    @AppStorage("signed_in") var userIsSignedIn: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            // content
            content
            Spacer()
            //buttton
            signOutButton
            Spacer()
        }
    }
}
 

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        //background
        backGround
        //content
        LoggedInView()
    }
}

extension LoggedInView {
    private var content: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .padding()
            
            VStack {
                Image("profilepic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                Text("Hello \(currentUserName ?? "How did you get here 🤨")!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.black)
            }
        }
    }
    
    private var signOutButton: some View {
        Button {
            //SignOut
            signOut()
        } label: {
            Text("Sign Out")
                .font(.title)
                .frame(maxWidth: .infinity)
        }
        
        .padding(20)
        .buttonBorderShape(.roundedRectangle(radius: 20))
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

extension LoggedInView {
    func signOut() -> Void {
        currentUserName   = nil
        currentUserAge    = nil
        currentUserGender = nil
        userIsSignedIn    = false
    }
}

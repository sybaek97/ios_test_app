//
//  IntroView.swift
//  crepass-test1
//
//  Created by 백승용 on 9/19/24.
//

import SwiftUI

struct IntroView :View{
    @State private var navigateToMain = false
    @State private var fadeInOut = false
    
    var body: some View{
        
        
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            if navigateToMain {
                MainView()
                    .transition(.opacity) // 전환 애니메이션 설정
            } else {
                VStack {
                    
                    Image("crepass_logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal,40)
                        .frame(width: .infinity)
                        .opacity(fadeInOut ? 1 : 0) // 페이드 인 애니메이션
                        .animation(.easeInOut(duration: 0.2), value: fadeInOut)
                }
                
                
                .onAppear {
                    fadeInOut.toggle()
                    
//                     1초 후 메인 화면으로 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            navigateToMain = true
                        }
                    }
                }
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View{
        IntroView()
    }
}

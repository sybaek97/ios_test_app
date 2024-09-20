//
//  IntroView.swift
//  crepass-test1
//
//  Created by 백승용 on 9/19/24.
//

import SwiftUI

struct MainView :View{
    @State private var currentIndex = 0
    let views = [PhoneModelView(), PhoneModelView()]
    @State private var showNextView = false
    
    
    var body: some View{
        GeometryReader { geometry in
            let tabViewHeight = geometry.size.height * 0.55
            let titleHeight = geometry.size.height * 0.15
            ZStack(alignment: .topLeading){ // ZStack에서 이미지의 정렬을 왼쪽 상단으로 설정
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading){
                    Image("title_logo")
                        .padding(.top , 20)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("본 앱은 더욱 정확한 신용 평가를 위해\n다음과 같은 귀하의\n기기 정보를 수집합니다.")
                        .frame(height: titleHeight)
                        .padding(.leading, 20)
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .foregroundColor(Color("FontColor"))
                    
                    // 전체 높이의 35%
                    
                    TabView(selection: $currentIndex) {
                        
                        ForEach(0..<views.count){index in
                            views[index]
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: tabViewHeight)
                    
                    
                    
                    HStack(spacing: 10) {
                        Spacer()
                        ForEach(0..<views.count) { index in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(currentIndex == index ? Color("CrepassColor") : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        currentIndex = index
                                    }
                                }
                        }
                        Spacer()
                    }
                    .padding()
                    Button(action: {
                        if currentIndex == views.count - 1 {
                            // 마지막 페이지인 경우, 화면 전환
                            showNextView = true
                        } else {
                            // 다음 페이지로 이동
                            withAnimation {
                                currentIndex += 1
                            }
                        }
                    }) {
                        Text(currentIndex == views.count - 1 ? "확 인" : "다 음")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                            .background(Color("CrepassColor"))
                            .frame(height: 70)
                    }
                    .fullScreenCover(isPresented: $showNextView) {
                        DataAgreementView()
                    }
                    
                    
                }.ignoresSafeArea(edges: .bottom)
                
                
            }
            
            
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View{
        MainView()
    }
}

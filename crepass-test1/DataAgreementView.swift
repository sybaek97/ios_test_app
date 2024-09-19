//
//  swift
//  crepass-test1
//
//  Created by 백승용 on 9/19/24.
//

import SwiftUI

struct DataAgreementView : View{
    var body: some View{
        ZStack(alignment: .topLeading){ // ZStack에서 이미지의 정렬을 왼쪽 상단으로 설정
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                Image("title_logo")
                    .padding(.top , 20)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("데이터 수집 전,\n크레파스 솔루션 약관에 동의 해주세요.")
                    .padding(.top, 100)
                    .padding(.leading, 20)
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundColor(Color("FontColor"))
              
            }
           
            VStack{
                Spacer()
                Button(action: {
                    
                }){
                    Text("확 인")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
              
                      
                }
                .background(Color("CrepassColor"))
                .padding(.bottom, 0)
                .frame(height: 80)
            }
            .ignoresSafeArea(edges: .bottom)
            
        
            
        }
        
    }
}

struct DataAgreementView_Preview: PreviewProvider {
    static var previews: some View{
        DataAgreementView()
    }
}

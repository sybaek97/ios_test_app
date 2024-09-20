//
//  PhoneModelView.swift
//  crepass-test1
//
//  Created by 백승용 on 9/20/24.
//

import SwiftUI


struct PhoneModelView : View{
    var body: some View{
        ZStack(alignment: .topLeading){ // ZStack에서 이미지의 정렬을 왼쪽 상단으로 설정
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                Spacer()
                Text("-기기정보 : 기기 모델명, 제조사, 운영체제 버전, 빌드 정보 등")
                    .padding(.horizontal, 20)
                    .font(.system(size: 15, weight: .medium, design: .serif))
                    .foregroundColor(Color("FontColor"))
                Spacer()
                Image("somdang_2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200 )
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("수집된 기기 정보는 귀하의 기기 사용 패턴 및 환경을 분석하여\n맞춤형 서비스를 제공하고, 사용 경험을 개선하는데 활용됩니다.\n수집된 정보에는 귀하의 기기모델, 운영체제 및 기타 기기 식별자가 포함되며,\n이는 [개인정보 보호정책]에 따라 안전하게 관리되며,\n다른 목적으로 사용되지 않습니다.")
                    .padding(.leading, 20)
                    .font(.system(size: 12, weight: .medium, design: .serif))
                    .foregroundColor(Color("GrayColor"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct PhoneModelView_Previews : PreviewProvider{
    static var previews: some View{
        PhoneModelView()
    }
}

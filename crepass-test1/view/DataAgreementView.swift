import SwiftUI

struct DataAgreementView: View {
    // 각 개별 체크박스의 상태를 관리하는 @State 변수
    @State private var isAllAgree = false
    @State private var isAgree1 = false
    @State private var isAgree2 = false
    @State private var showDialog = false
    @State private var showNextView = false
    var body: some View {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    let titleHeight = geometry.size.height * 0.15
                    Color("BackgroundColor")
                        .edgesIgnoringSafeArea(.all)
                    // 전체 동의 버튼
                    VStack(alignment: .leading){
                        Image("title_logo")
                            .padding(.top , 20)
                            .padding(.leading, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                        Text("데이터 수집 전,\n크레파스 솔루션 약관에 동의해 주세요.")
                            .frame(height: titleHeight)
                            .padding(.horizontal, 40)
                            .font(.system(size: 22, weight: .bold, design: .serif))
                            .foregroundColor(Color("FontColor"))
                        Spacer()
                        Button(action: {
                            toggleAllAgree() // 전체 동의 버튼 클릭 시 모든 동의 상태를 토글
                        }) {
                            HStack {
                                Text("전체 동의")
                                    .font(.system(size: 32, weight: .bold, design: .serif))
                                    .foregroundColor(Color("FontColor"))
                                Spacer()
                                Image(systemName: isAllAgree ? "checkmark.circle" : "circle")
                                    .resizable()
                                    .foregroundColor(Color("CrepassColor"))
                                    .frame(width: 50,height: 50)
                            }
                            
                            .foregroundColor(.blue)
                            .padding(.horizontal, 40)
                        }
                        
                        Rectangle()
                            .fill(Color("DarkGrayColor")) // 원하는 색상
                            .frame(height: 1) // 높이 설정
                            .padding(.horizontal, 40) // 수평 패딩 적용

                        
                        HStack {
                            Text("약관 1 동의")
                                .onTapGesture {
                                    showDialog = true // 다이얼로그 표시
                                }
                                .font(.system(size: 25, weight: .bold, design: .monospaced))
                                .foregroundColor(Color("FontColor"))
                            Spacer()
                            Button(action: {
                                isAgree1.toggle()
                                updateAllAgreeStatus() // 상태 변경 후 전체 동의 상태 업데이트
                            }) {
                                Image(systemName: isAgree1 ? "checkmark.circle" : "circle")
                                    .resizable()
                                    .foregroundColor(Color("CrepassColor"))
                                    .frame(width: 40,height: 40)
                                    .padding(.horizontal, 5)
                            }
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal, 40)
                        
                        HStack {
                            Text("약관 2 동의")
                                .onTapGesture {
                                    showDialog = true // 다이얼로그 표시
                                }
                                .font(.system(size: 25, weight: .bold, design: .monospaced))
                                .foregroundColor(Color("FontColor"))
                            Spacer()
                            Button(action: {
                                isAgree2.toggle()
                                updateAllAgreeStatus() // 상태 변경 후 전체 동의 상태 업데이트
                            }) {
                                Image(systemName: isAgree2 ? "checkmark.circle" : "circle")
                                    .resizable()
                                    .foregroundColor(Color("CrepassColor"))
                                    .frame(width: 40,height: 40)
                                    .padding(.horizontal, 5)
                            }
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal, 40)
                        
                        Spacer()
                        
                        // 확인 버튼
                        Button(action: {
                            showNextView = true
                        }) {
                            Text("확 인")
                                .font(.system(size: 35, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                            
                                .frame(height: 80)
                                .background(isAllAgree ? Color("CrepassColor") : Color("DarkGrayColor"))
                        }
                        .disabled(!isAllAgree)
                        .fullScreenCover(isPresented: $showNextView) { // 전체 화면으로 전환
                            SdScoreView()
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .alert(isPresented: $showDialog) {
                    Alert(
                        title: Text("약관 내용"),
                        message: Text("약관의 자세한 내용을 확인하세요."),
                        dismissButton: .default(Text("확인"))
                    )
                }
            
    }
    
    // 전체 동의 상태를 토글하는 함수
    private func toggleAllAgree() {
        isAllAgree.toggle()
        isAgree1 = isAllAgree
        isAgree2 = isAllAgree
    }
    
    // 개별 동의 상태에 따라 전체 동의 상태를 업데이트하는 함수
    private func updateAllAgreeStatus() {
        isAllAgree = isAgree1 && isAgree2
    }
}

struct DataAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        DataAgreementView()
    }
}

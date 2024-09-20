import SwiftUI
import Lottie

// LottieView 애니메이션 이동 기능을 추가한 버전
struct LottieView: UIViewRepresentable {
    var animationName: String
    var animationSpeed: CGFloat
    var loopMode: LottieLoopMode = .loop
    
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        // Lottie 애니메이션 뷰 설정
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        if animationName == "animation_sdscore"{
            animationView.loopMode = loopMode
        }else {
            animationView.loopMode = .repeat(1)
        }
        
        
        animationView.animationSpeed = animationSpeed
        animationView.play()
        
        // 애니메이션 뷰를 컨테이너 뷰에 추가
        view.addSubview(animationView)
        
        // 애니메이션 뷰의 레이아웃 설정
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        // 애니메이션 이동 설정
        DispatchQueue.main.async {
            if animationName == "animation_sdscore"{
                startAnimation(animationView: animationView, in: view)
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // 업데이트가 필요하지 않으면 비워둡니다.
    }
    
    // 애니메이션 이동 기능
    private func startAnimation(animationView: LottieAnimationView, in view: UIView) {
        let containerWidth = view.bounds.width
        let containerHeight = view.bounds.height
        
        // 애니메이션 뷰 초기 위치 설정 (화면 밖 왼쪽)
        animationView.transform = CGAffineTransform(translationX: -containerWidth, y: 0)
        
        // 애니메이션 이동 경로 설정
        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [.calculationModeLinear, .repeat], animations: {
            
            // 첫 번째 키프레임: 애니메이션 뷰가 화면 밖 왼쪽에서 화면 중앙으로 이동
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                animationView.transform = CGAffineTransform(translationX: containerWidth, y: 0)
            }
            
            // 두 번째 키프레임: 애니메이션 뷰가 화면 중앙에서 화면 밖 오른쪽으로 이동
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.0) {
                animationView.transform = CGAffineTransform(translationX: -containerWidth, y: 0)
            }
            
        }, completion: nil)
    }
}

// SwiftUI에서 LottieView 사용 예시
struct SdScoreView: View {
    @State private var showLottie: Bool = true
    @State private var isImageVisible = false // 이미지의 가시성을 제어하는 상태 변수
    @State private var isTextVisible = false // 텍스트의 가시성을 제어하는 상태 변수
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                let titleHeight = geometry.size.height * 0.15
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    // Lottie 애니메이션 뷰
                    Spacer()
                    if showLottie {
                        // Lottie 애니메이션 뷰 및 텍스트
                        VStack {
                            LottieView(animationName: "animation_sdscore",animationSpeed: 5)
                                .frame(width: .infinity, height: titleHeight)
                                .padding(.horizontal,40)
                            Text("고객님의 정보를 수집하고 있습니다.\n잠시만 기다려 주세요.")
                                .font(.system(size: 15, weight: .bold, design: .serif))
                                .foregroundColor(Color("FontColor"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } else {
                        ZStack{
                            LottieView(animationName: "good",animationSpeed: 0.9)
                                .frame(width: .infinity, height: 250)
                                .padding(.horizontal,40)
                            Image("somdang_3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.top,10)
                                .frame(width: 150, height: 150)
                                .opacity(isImageVisible ? 1.0 : 0.2) // 페이드 인 효과 적용
                                .animation(.easeIn(duration: 0.5), value: isImageVisible)
                                .frame(maxWidth: .infinity, alignment: .center)
                              
                        }
                        .onAppear {
                            // 뷰가 나타날 때 이미지가 서서히 보이도록 설정
                            withAnimation {
                                isImageVisible = true
                            }
                        }
                        
                        
                        Text("고객님의 데이터 분석 및 점수 산출이\n완료되었습니다.")
                            .font(.system(size: 15, weight: .bold, design: .serif))
                            .foregroundColor(Color("FontColor"))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .opacity(isTextVisible ? 1.0 : 0.0) // 텍스트 페이드 인 효과 적용
                            .animation(.easeIn(duration: 1.5), value: isTextVisible)
                            .onAppear {
                                // 텍스트가 서서히 보이도록 설정
                                withAnimation(.easeIn(duration: 1.5).delay(0.5)) {
                                    isTextVisible = true
                                }
                            }
                    }
                    Spacer()
                    
                    
                    if !showLottie{
                        Button(action: {
                            exit(0)
                        }) {
                            Text("종료")
                                .font(.system(size: 35, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color("CrepassColor"))
                                .frame(height: 70)
                        }
                    }
                    
                }
                .ignoresSafeArea()
                .onAppear {
                    // 5초 후 Lottie 애니메이션을 감추고 이미지를 표시하도록 상태 변경
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            showLottie = false
                        }
                    }
                }
            }
        }
    }
}

struct SdScoreView_Previews: PreviewProvider {
    static var previews: some View {
        SdScoreView()
    }
}

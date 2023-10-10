import SwiftUI

struct AgreementSent: View {
    @AppStorage("dynamic_link_status") var dynamicLinkStatus: Bool = false
    @AppStorage("dynamic_link_client_id") var dynamicLinkClientId: String = ""
    @AppStorage("dynamic_link_client_name") var dynamicLinkClientName: String = ""
    @AppStorage("dynamic_link_content") var dynamicLinkContent: String = ""
    @AppStorage("dynamic_link_agreement_method") var dynamicLinkAgreementMethod: String = ""
    @AppStorage("dynamic_link_requesting_info") var dynamicLinkRequestingInfo: String = ""
    
    @AppStorage("tutorial_finished") var tutorialFinished: Bool = false
    

    
    /// Animation Properties
    var size: CGSize
    @State private var showView: Bool = false
    @Binding var hideViewSent : Bool
    
    func deleteAppStorageForDynamicLink(){
        dynamicLinkStatus = false
        dynamicLinkClientId = ""
        dynamicLinkClientName = ""
        dynamicLinkContent = ""
        dynamicLinkAgreementMethod = ""
        dynamicLinkRequestingInfo = ""
    }

    var body: some View {
        VStack{
            
            GeometryReader{
                let size = $0.size
                
                Image("team_success")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.width)
            }
            .offset(y: showView ? 0 : -size.height/2)
            .opacity(showView ? 1 : 0)
            
            VStack(alignment: .leading, spacing: 10){
                Text("DeepLinkAgreementSentTitle", bundle: .module)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                Text("DeepLinkAgreementSentSubTitle", bundle: .module)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                
                Spacer(minLength: 0)
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)){
                        hideViewSent = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        deleteAppStorageForDynamicLink()
                        if(!tutorialFinished){
                            tutorialFinished = true
                        }

                    }

                }){
                    Text("DeepLinkAgreementSentGoBackLabel", bundle: .module)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: size.width*0.4)
                        .padding(.vertical, 15)
                        .background{
                            Capsule()
                                .fill(.black)
                        }
                }
                .frame(maxWidth: .infinity)
                Spacer(minLength: 10)
            }
            .padding()
            .padding(.leading, 4)
            .padding(.trailing, 4)
            
            /// Moving Down
            .offset(y: showView ? 0 : size.height/2)
            .opacity(showView ? 1 : 0)
            
        }
        .offset(y: hideViewSent ? size.height/2 : 0)
        .opacity(hideViewSent ? 0 : 1)
        
        .onAppear{
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)){
                showView = true
            }
            
        }
        
    }
}
//
//struct AgreementSent_Previews: PreviewProvider {
//    static var previews: some View {
//        AgreementSent()
//    }
//}

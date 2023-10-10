import SwiftUI

public struct AgreementDetailModalView: View {
    @Binding var isPresented: Bool
    let ref_id: String
    let client_name: String
    let user_name: String
    let date: String
    var methods: AgreementMethod
    let content: String
    var agreementModel: AgreementModel
    
    public var body: some View {
        
        NavigationStack{
            
            List{
                Section {
                    if(ref_id != ""){
                        HStack(){
                            Text("AgreementDetailModalRefIdLabel")
                                .font(.subheadline)
                            Spacer()
                            Text(ref_id)
                                .font(.subheadline)
                        }
                    }
                    HStack(){
                        Text("AgreementDetailModalClientNameLabel")
                            .font(.subheadline)
                        Spacer()
                        Text(client_name)
                            .font(.subheadline)
                    }
                    
                    HStack(){
                        Text("AgreementDetailModalUserNameLabel")
                            .font(.subheadline)
                        Spacer()
                        Text(user_name)
                            .font(.subheadline)
                    }
                    if(date != ""){
                        HStack(){
                            Text("AgreementDetailModalDateLabel")
                                .font(.subheadline)
                            Spacer()
                            Text(date)
                                .font(.subheadline)
                        }
                    }
                } header: {
                    Text("AgreementDetailModalHeaderBasic")
                }
                
                Section {
                    if(methods.face_id){
                        HStack(){
                            Text("AgreementDetailModalAgreementMethodFaceIdLabel")
                        }
                    }
                    if(methods.my_number_card){
                        HStack(){
                            Text("AgreementDetailModalAgreementMethodMncLabel")
                        }
                    }
                    if(methods.signature){
                        HStack(){
                            Text("AgreementDetailModalAgreementMethodSignatureLabel")
                        }
                    }
                    
                } header: {
                    Text("AgreementDetailModalHeaderAgreementMethod")
                }
                
                Section {
                    
                    if(agreementModel.name){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoNameLabel")
                        }
                    }
                    if(agreementModel.birthday){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoBirthdayLabel")
                        }
                    }
                    if(agreementModel.age){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoAgeLabel")
                        }
                    }
                    if(agreementModel.sex){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoSexLabel")
                        }
                    }
                    if(agreementModel.address){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoAddressLabel")
                        }
                    }
                    if(agreementModel.email){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoEmailLabel")
                        }
                    }
                    if(agreementModel.phone){
                        HStack(){
                            Text("AgreementDetailModalRequestingInfoPhoneLabel")
                        }
                    }
                } header: {
                    Text("AgreementDetailModalHeaderRequestingInfo")
                }
                
                Section {
                    Text(content)
                        .font(.subheadline)
                } header: {
                    Text("AgreementDetailModalHeaderContent")
                }
            }
            .navigationTitle(String(localized: "AgreementDetailModalTitle"))
        }
    }
}

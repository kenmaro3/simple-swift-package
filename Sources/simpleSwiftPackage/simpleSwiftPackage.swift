// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

extension String {

    /// Transform Hiragana to Katakana.
    /// - Returns: The transformed string.
    /// - SeeAlso: ``toHiragana()``
    public func toKatakana() -> String? {
        applyingTransform(.hiraganaToKatakana, reverse: false)
    }

    /// Transform Katakana to Hiragana.
    /// - Returns: The transformed string.
    /// - SeeAlso: ``toKatakana()``
    public func toHiragana() -> String? {
        applyingTransform(.hiraganaToKatakana, reverse: true)
    }
}

import SwiftUI
 
@available(iOS 14, macOS 11.0, *)
public struct AnimatedMenuBar: View {
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
 
    var menuItems = [ "Travel", "Nature", "Architecture" ]
 
    public init(selectedIndex: Binding<Int>, menuItems: [String] = [ "Travel", "Nature", "Architecture" ]) {
        self._selectedIndex = selectedIndex
        self.menuItems = menuItems
    }
 
    public var body: some View {
 
        HStack {
            Spacer()
 
            ForEach(menuItems.indices) { index in
 
                if index == selectedIndex {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color.purple))
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
                } else {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color( red: 244, green: 244, blue: 244)))
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
 
                Spacer()
            }
 
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .animation(.easeInOut, value: selectedIndex)
 
    }
}

import SwiftUI
import TRETJapanNFCReader_MIFARE_IndividualNumber
import ASN1Decoder

public struct MNCRegister: View, IndividualNumberReaderSessionDelegate  {
    @State private var isSkipped: Bool = false
    // MARK: App Mnc Register Status
    @AppStorage("mnc_register_status") var mncRegisterStatus: Bool = false
    
    public init(){
    }
    
    public func individualNumberReaderSession(didRead individualNumberCardData: TRETJapanNFCReader_MIFARE_IndividualNumber.IndividualNumberCardData) {
        print("individualNumberReaderSession")
        print(individualNumberCardData)
        
        guard let tmp_pem_before = individualNumberCardData.certificate_pem_before else{
            return
        }
        
        guard let _ = try? X509Certificate(data: tmp_pem_before) else {
            //session.invalidate(errorMessage: "X509Certificate Parse Error")
            return
        }
        
        let INDENTATION = "\n"
        let BEGIN_CERT = "-----BEGIN CERTIFICATE-----"
        let END_CERT = "-----END CERTIFICATE-----"
        
        
        let encoded = tmp_pem_before.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        //individualNumberCard.data.certificate_pem = BEGIN_CERT + INDENTATION + encoded + INDENTATION + END_CERT
        let encoded_pem = BEGIN_CERT + INDENTATION + encoded + INDENTATION + END_CERT
        
//        APIClient.postCertificateToFastAPI(certificate_pem_string: encoded_pem){_ in
//            //MARK: User Logged in Successfully
//            print("Success!")
//            withAnimation(.easeInOut){
//                mncRegisterStatus = true
//            }
//        }
        
        
    }

    public func japanNFCReaderSession(didInvalidateWithError error: Error) {
        print("japanNFCReaderSession")
    }
    
    // MARK: Handling Error
    func handleError(error: Error) async{
        await MainActor.run(body: {
            //errorMessage = error.localizedDescription
            //showError.toggle()
        })
    }
    
    @State var reader: IndividualNumberReader!
    
//    func skipTapped(){
//        print("skipTapped")
//        isSkipped = true
//    }
    
    public var body: some View {
        if isSkipped{
            Text("skipped")
        }else{
            VStack(alignment: .leading, spacing: 15){
                
                
                VStack(alignment: .leading){
                    (Text(NSLocalizedString("MNCRegisterScanLabel", bundle: .module, comment: ""))
                        .foregroundColor(.black) +
                     Text(NSLocalizedString("MNCRegisterScanLabel2", bundle: .module, comment: ""))
                        .foregroundColor(.black)
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                    
                    (Text(NSLocalizedString("MNCRegisterScanSecondLabel1", bundle: .module, comment: "")) +
                     Text(NSLocalizedString("MNCRegisterScanSecondLabel2", bundle: .module, comment: "")) +
                     Text(NSLocalizedString("MNCRegisterScanSecondLabel3", bundle: .module, comment: ""))
                    )
                    .font(.callout)
                    .foregroundColor(.gray)
                    
                    Image("Password_Flatline")
                        .resizable()
                        .frame(width: 300, height: 225)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .padding(.horizontal)
                    
                }
                .padding(.trailing, 40)
                .padding(.leading, 40)
                
            }
            .onAppear{
                print("onAppear")
                reader = IndividualNumberReader(delegate: self)
                reader.get_no_need_pin(items: [.getCertificate])
            }
            
        }
    }
}

struct MNCRegister_Previews: PreviewProvider {
    static var previews: some View {
        MNCRegister()
    }
}


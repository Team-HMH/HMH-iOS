//
//  SwiftUIView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/10/24.
//

import SwiftUI
import FamilyControls

struct SwiftUIView: View {
    @EnvironmentObject var model: BlockingApplicationModel
    
    var body: some View {
        FamilyActivityPicker(selection: $model.newSelection)
        
    }
}

#Preview {
    SwiftUIView()
}

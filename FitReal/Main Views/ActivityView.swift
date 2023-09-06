//
//  ActivityView.swift
//  FitReal
//
//  Created by Prakhar Trivedi on 6/9/23.
//

import SwiftUI

struct ActivityView: View {
    var activity: Activity
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: AppState.loadSampleAppUserData(fireAuthID: "DEBUGID").extractedActivities.first!)
    }
}

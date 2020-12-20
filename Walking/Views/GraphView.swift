//
//  GraphView.swift
//  Walking
//
//  Created by Kris Reid on 25/11/2020.
//

import SwiftUI

struct GraphView: View {
    
    let steps: [Step]
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    var body: some View {
            
        VStack {
            
            Text("7 Day Step Count")
                .font(.system(size: 34))
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .padding(.top, 50)
            
            Spacer()
            
            HStack {
                ForEach(steps, id: \.id) {step in
                    BarChartView(step: step)
                }
            }
            .padding(.top, 24)
            .animation(.default)
            
            Spacer()
            
            Text("Total Steps: \(totalSteps)")
                .foregroundColor(Color.white)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct BarChartView: View {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    var step: Step
    
    var body: some View {
        
        let yValue = Swift.min(step.count/50, 300)
        
        VStack {
            Text("\(step.count)")
                .font(.caption)
                .foregroundColor(.white)
            
            ZStack (alignment: .bottom) {
                Capsule().frame(width: 30, height: 300)
                    .foregroundColor(Color.backgroundBar)
                Capsule().frame(width: 30, height: CGFloat(yValue))
                    .foregroundColor(Color.foregroundBar)
            }
            
            Text("\(step.date,formatter: Self.dateFormatter)")
                .padding(.top, 8)
                .font(.caption)
                .foregroundColor(Color.white)
        }
    }
}


struct GraphView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let steps = [
            Step.init(count: 4567, date: Date()),
            Step.init(count: 4422, date: Date()),
            Step.init(count: 7432, date: Date()),
            Step.init(count: 2233, date: Date()),
            Step.init(count: 15000, date: Date())
        ]
        
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            GraphView(steps: steps)
                .environment(\.colorScheme, .dark)
            
            GraphView(steps: steps)
                .environment(\.colorScheme, .light)
        }
    }
}

//
//  DatePicker.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 15/12/21.
//

import SwiftUI

struct DatePickers: View {
    @State private var birthdatepre = Date()
    @State private var birthdatefu = Date()
    @State private var birthtimepre = Date()
    @State private var birthtimefu = Date()
    @State private var birthdatetimepre = Date()
    @State private var birthdatetimefu = Date()
    @State private var birth = Date()
    
    @State private var selectedDate = Date()
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date()
    let endDate: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    
    var body: some View {
        VStack {
            Form {
                DatePicker("Birthdatetime future", selection: $birth)
                    .datePickerStyle(.wheel)
                // Or,
                DatePicker("Select event date and time", selection: $birth, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
            }
            ScrollView {
                VStack {
                    DatePicker("Birthdate previous dates only", selection: $birthdatepre, in: ...Date(), displayedComponents: .date)
                    
                    DatePicker("Birthdate future dates only", selection: $birthdatefu, in: Date()..., displayedComponents: .date)
                    
                    DatePicker("Birthtime previous time only", selection: $birthtimepre, in: ...Date(), displayedComponents: .hourAndMinute)
                    
                    DatePicker("Birthtime future time only", selection: $birthtimefu, in: Date()..., displayedComponents: .hourAndMinute)
                    
                    DatePicker("Birthdatetime previous", selection: $birthdatetimepre, in: ...Date())
                        .datePickerStyle(.automatic)
                    
                    DatePicker("Birthdatetime future", selection: $birthdatetimefu, in: ...Date())
                        .datePickerStyle(.graphical)
                }
                VStack {
                    Text("SELECTED DATE IS :")
                    Text(dateFormatter.string(from: selectedDate)
                         //                         selectedDate.description
                    )
                        .font(.title3)
                    DatePicker("Select a Date", selection: $selectedDate, in: startingDate...endDate, displayedComponents: [.date, .hourAndMinute])
                        .accentColor(Color.red)
                        .foregroundColor(Color.red)
                        .datePickerStyle(
                            // CompactDatePickerStyle()
                            GraphicalDatePickerStyle()
                        )
                }
                
            }
        }
    }
}

struct DatePickers_Previews: PreviewProvider {
    static var previews: some View {
        DatePickers()
    }
}

//
//  CustomDatePickers.swift
//  SwiftUIAccessory
//
//  Created by MANAS VIJAYWARGIYA on 20/04/22.
//

import SwiftUI

struct CustomDatePickers: View {
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            CustomDatePicker()
                .offset(x: 0, y: 50)
        }
    }
}

struct CustomDatePickers_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePickers()
    }
}

//Dummy Data
var date = ["DD"
            ,"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]

var month = ["MM"
             ,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]

var year = ["YYYY" ,"2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024"]


struct CustomDatePicker: View {
    @State private var selectedIndexdate = 0// First Position
    @State private var selectedIndexmonth = 0// First Position
    @State private var selectedIndexyear = 0// First Position
    
    @State private var selectedIndex = 10// First Position
    
    
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 10, height: 100, alignment: .center)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 3))
                .offset(x: 100, y: -215)
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 10, height: 100, alignment: .center)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 3))
                .offset(x: -100, y: -215)
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 370, height: 300, alignment: .center)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 3))
                .offset(x: 0, y: -90)
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 370, height: 290, alignment: .center)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 3))
                .offset(x: 0, y: -40)
            
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.white).opacity(0.5)
                .offset(x: -100, y: -125)
            
            HStack {
                ZStack {
                    if(selectedIndexdate >= selectedIndex){
                        Text("\(selectedIndexdate) /")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    } else {
                        Text( "0\(selectedIndexdate) /")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                }.offset(x: 20, y: 0)
                
                ZStack {
                    if(selectedIndexmonth >= selectedIndex){
                        Text("\(selectedIndexmonth) /")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    } else {
                        Text( "0\(selectedIndexmonth) /")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                }.offset(x: 20, y: 0)
                
                ZStack {
                    if(selectedIndexyear >= selectedIndex){
                        Text("20\(selectedIndexyear)")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    } else {
                        Text( "200\(selectedIndexyear)")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                }.offset(x: 20, y: 0)
            }.offset(x: 0, y: -125)
            
            HStack{
                Circle().foregroundColor(.red).frame(width: 20, height: 20, alignment: .center)
                Circle().foregroundColor(.yellow).frame(width: 20, height: 20, alignment: .center)
                
                Circle().foregroundColor(.green).frame(width: 20, height: 20, alignment: .center)
            }.offset(x: -120, y: -210)
            
            Text("D A T E   P I C K E R")
                .font(.title2)
                .fontWeight(.thin)
                .foregroundColor(Color.white)
                .offset(x: 70, y: -210)
            
            HStack {
                VStack {
                    Button(action: {
                    }) {
                        Text("Date")
                            .font(.title)
                            .fontWeight(.thin)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 60.0)
                    
                    VStack {
                        Picker("Date", selection: $selectedIndexdate, content: {
                            ForEach(0..<date.count, content: { index in
                                Text(date[index]).foregroundColor(.white)
                            })
                        })
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                    }.border(Color.white)
                }
                VStack {
                    Button(action: {
                    }) {
                        Text("Month")
                            .font(.title)
                            .fontWeight(.thin)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 100)
                    VStack {
                        Picker("Month", selection: $selectedIndexmonth, content: {
                            ForEach(0..<month.count, content: { index in
                                Text(month[index]).foregroundColor(.white)
                            })
                        })
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                    }.border(Color.white)
                }
                VStack {
                    Button(action: {
                    }) {
                        Text("Year")
                            .font(.title)
                            .fontWeight(.thin)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 60.0)
                    VStack {
                        Picker("Year", selection: $selectedIndexyear, content: {
                            ForEach(0..<year.count, content: { index in // <2>
                                Text(year[index]).foregroundColor(.white) // <3>
                            })
                        })
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                    }.border(Color.white)
                }
            }
        }
    }
}

//
//  Leaderbored.swift
//  test
//
//  Created by hazem salmani on 5/11/2023.
//
import SwiftUI

struct SimpleLeaderboardView: View {
    var body: some View {
        VStack {
            // Title and Header Section
            HStack {
                Image(systemName: "arrow.left")
                Text("Leaderboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.white)
            
            // Leaderboard Entries
            VStack {
                LeaderboardEntryView(name: "user 1", points: "1470", rank: "1", color: .red)
                LeaderboardEntryView(name: "user 2", points: "1340", rank: "2", color: .orange)
                LeaderboardEntryView(name: "user 3", points: "1202", rank: "3", color: .green)
            }
            .padding()
            .background(Color.white)
            
            // Scrollable Section
            ScrollView {
                LazyVStack {
                    ForEach(0 ..< 3) { index in
                        Text("Another Entry")
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct LeaderboardEntryView: View {
    var name: String
    var points: String
    var rank: String
    var color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("\(points) Pts")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Spacer()
            Text(rank)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding()
        .background(color)
        .cornerRadius(10)
        .padding(.vertical, 5)
    }
}

struct SimpleLeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleLeaderboardView()
    }
}


//
//  FeedCell.swift
//  Instagram
//
//  Created by Sahil Prasad on 19/10/26.
//

import SwiftUI

// MARK: - Feed Post Cell
/// Home feed mein dikhne wali ek single post ka card (User Info + Photo + Like/Comment/Share/Save buttons + Caption).
struct FeedCell: View {
    
    // MARK: - Properties
    let post: Post
    
    /// Interactive UI states (Like, Save, aur Comments sheet)
    @State private var isLiked = false
    @State private var isSaved = false
    @State private var extraLikes = 0
    @State private var showCommentsSheet = false
    
    /// Total likes count (original post likes + user ke like karne par +1)
    private var totalLikes: Int {
        post.likes + extraLikes
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // 1. Top Bar: User ki Profile Photo aur Username (Tap karne par Profile khulegi)
            userHeaderSection
            
            // 2. Main Post Image (Double-tap karne par Like ho jayegi)
            postImageSection
            
            // 3. Action Buttons (Like, Comment, Share, aur Bookmark)
            actionButtonsSection
            
            // 4. Likes Count, Caption aur Timestamp
            postDetailsSection
        }
        // Comment icon dabane par neeche se Comments Sheet khulti hai
        .sheet(isPresented: $showCommentsSheet) {
            PostCommentsSheetView(post: post)
                .presentationDetents([.medium, .large])
        }
    }
}

// MARK: - Subviews (Code ko samajhne mein aasaan banane ke liye alag sections)
private extension FeedCell {
    
    /// Post ke upar user ki chhoti photo aur username dikhata hai
    var userHeaderSection: some View {
        HStack {
            if let user = post.user {
                NavigationLink {
                    ProfileView(user: user)
                } label: {
                    HStack(spacing: 8) {
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text(user.username)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black)
                    }
                }
            }
            Spacer()
        }
        .padding(.leading, 10)
    }
    
    /// Post ki main badi photo (Double tap karne par post Like hoti hai)
    var postImageSection: some View {
        Group {
            if post.imageUrl.hasPrefix("http") {
                AsyncImage(url: URL(string: post.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .overlay(ProgressView())
                }
            } else {
                Image(post.imageUrl)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(height: 400)
        .clipShape(Rectangle())
        .onTapGesture(count: 2) {
            if !isLiked {
                toggleLike()
            }
        }
    }
    
    /// Like (Heart), Comment (Bubble), Share (Paperplane), aur Save (Bookmark) ke buttons
    var actionButtonsSection: some View {
        HStack(spacing: 14) {
            // Like Button
            Button {
                toggleLike()
            } label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .foregroundStyle(isLiked ? Color.red : Color.black)
            }
            
            // Comment Button
            Button {
                showCommentsSheet.toggle()
            } label: {
                Image(systemName: "bubble.right")
                    .imageScale(.large)
            }
            
            // Share Button
            Button {
                print("DEBUG: Share Post")
            } label: {
                Image(systemName: "paperplane")
                    .imageScale(.large)
            }
            
            Spacer()
            
            // Bookmark / Save Button
            Button {
                isSaved.toggle()
            } label: {
                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    .imageScale(.large)
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 4)
        .tint(Color.black)
    }
    
    /// Likes count, username + caption, aur relative timestamp dikhata hai
    var postDetailsSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Likes count
            Text("\(totalLikes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
            
            // Username (bold) + Caption (normal)
            HStack {
                Text("\(post.user?.username ?? "") ")
                    .fontWeight(.semibold) +
                Text(post.caption)
            }
            .font(.footnote)
            
            // Relative timestamp (e.g., "2h ago")
            Text(post.timestamp.formatted(.relative(presentation: .named)))
                .font(.caption)
                .foregroundStyle(Color.gray)
        }
        .padding(.horizontal, 10)
    }
    
    /// Like state toggle karta hai aur likes count badhata/ghatata hai
    func toggleLike() {
        isLiked.toggle()
        extraLikes += isLiked ? 1 : -1
    }
}

// MARK: - Post Comments Sheet View
/// Post ke comment button par tap karne par khulne wali interactive Comments screen.
struct PostCommentsSheetView: View {
    let post: Post
    @State private var newCommentText = ""
    @State private var comments: [(username: String, text: String)] = [
        ("ironman", "Awesome shot! 🔥"),
        ("spiderman", "Looks amazing!!")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(comments.enumerated()), id: \.offset) { _, comment in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color(.systemGray4))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(comment.username)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    Text(comment.text)
                                        .font(.footnote)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 12)
                }
                
                Divider()
                
                // Naya comment likhne ka bottom bar
                HStack(spacing: 10) {
                    TextField("Add a comment...", text: $newCommentText)
                        .font(.subheadline)
                    
                    Button("Post") {
                        guard !newCommentText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        let currentUsername = AuthService.shared.currentUser?.username ?? "you"
                        comments.append((username: currentUsername, text: newCommentText))
                        newCommentText = ""
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .disabled(newCommentText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_Posts[2])
}

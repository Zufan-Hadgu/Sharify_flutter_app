# 📦 Sharify - Community Item Sharing App

**Sharify** is a community-based item lending and borrowing application that connects users who want to borrow items with admins who offer them. It promotes a culture of sharing, reduces unnecessary purchases, and encourages sustainability.

## 🚀 Overview

Sharify provides two types of user roles:

- **Users**: Can browse available items, borrow items, track borrowed items, and manage their profiles.
- **Admins**: Can add/manage items, update item availability, view dashboard statistics, and manage their profile.

## 🧩 Features

### 🧑 User Features

- Sign up, Login, Logout
- Browse available items 
- Borrow an item
- View borrowed items and their notes
- Update note for a borrowed item
- Delete account

### 👨‍💼 Admin Features

- Login 
- Add new items (name, description, image, terms, etc.)
- Update item info and availability
- View total users and available items in dashboard
- Manage profile and logout

## ⚙️ Tech Stack

| Layer              | Tech Used                    |
|-------------------|------------------------------|
| Frontend (Mobile) | Flutter                      |
| State Management  | Riverpod                     |
| HTTP Client       | Dio                          |
| Backend           | Node.js + Express            |
| Database          | MongoDB                      |
| Local Storage     | SQLite (via `sqflite` plugin)|
| Auth              | JWT Tokens                   |


## 🔐 Environment Variables

For the backend server, create a `.env` file:

MONGODB_URL='mongodb://127.0.0.1:27017'

JWT_SECRET= 'secret#text'

NODE_ENV='development'


## 💻 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Zufan-Hadgu/Sharify_flutter_app.git
cd backend
npm install
npm run server
cd frontend
flutter pub get
flutter run
```
Team Members

| No | Name              | ID Number     | Section |
|----|-------------------|---------------|---------|
| 1  | Sifen Getachew    | UGR/2452/15   | S-1     |
| 2  | Ribka Mengiste    | UGR/9680/15   | S-2     |
| 3  | Zufan Gebrehiwot  | UGR/7674/15   | S-2     |
| 4  | Tsega Ephrem      | UGR/7925/14   | S-1     |
| 5  | Meti Kejelcha     | UGR/6462/15   | S-2     |




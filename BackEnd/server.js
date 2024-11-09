import express from 'express';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import passport from 'passport';
import session from 'express-session';
import http from 'http';                   // Import HTTP for Socket.IO
import connectDB from './config/db.js';
import authRoutes from './routes/authRoutes.js';
import userRoutes from './routes/userRoutes.js';
import notificationRoutes from './routes/notificationRoutes.js'; // Import notification routes
import cors from 'cors';
import { initializeSocket } from './config/socket.js'; // Import Socket.IO config
import './passport-setup.js';

dotenv.config();
connectDB();

const app = express();
const server = http.createServer(app);     // Create HTTP server
initializeSocket(server);                   // Initialize Socket.IO

// Set EJS as the template engine
app.set('view engine', 'ejs');
// Set the directory for views (e.g., "views" folder)
app.set('views', './views');

app.use(cors());
app.use(express.json());

// Session middleware configuration
app.use(session({
    secret: process.env.SESSION_SECRET || 'your_secret',
    resave: false,
    saveUninitialized: true
}));

// Initialize Passport.js for authentication
app.use(passport.initialize());
app.use(passport.session());

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.message);
    res.status(500).send('Server Error');
});

// Route definitions
app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api/notifications', notificationRoutes); // Add notification routes

// Test route
app.get('/', (req, res) => {
    res.send('API is running...');
});

// Route to render notification EJS page
app.get('/notifications', (req, res) => {
    res.render('notification'); // Render the notification EJS file
});

// Server setup
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

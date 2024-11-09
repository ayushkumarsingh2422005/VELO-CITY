import User from '../models/User.js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { validationResult } from 'express-validator';
import nodemailer from 'nodemailer';
import passport from 'passport';

// Helper function to configure nodemailer transport
const transporter = nodemailer.createTransport({
    service: 'Gmail', // Example service
    auth: {
        user: process.env.EMAIL, // Sender email
        pass: process.env.EMAIL_PASSWORD, // Sender password
    },
});

// Registration function
export const register = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

    const { name, email, password } = req.body;

    try {
        let user = await User.findOne({ email });
        if (user) return res.status(400).json({ msg: 'User already exists' });

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        user = new User({ name, email, password: hashedPassword });
        await user.save();

        const payload = { userId: user._id };
        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });

        res.status(201).json({ token });
    } catch (error) {
        res.status(500).send('Server error');
    }
};

// Login function
export const login = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) return res.status(400).json({ msg: 'Invalid credentials' });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ msg: 'Invalid credentials' });

        const payload = { userId: user._id };
        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });

        res.json({ token });
    } catch (error) {
        res.status(500).send('Server error');
    }
};

// Google Authentication function (placeholder for now)
export const googleAuthCallback = async (req, res) => {
    try {
        // Successful authentication, get user info from req.user
        const { _id, name, email, profilePicture } = req.user;

        // Check if user already exists
        let user = await User.findOne({ email });
        if (!user) {
            // Create a new user if they don't exist
            user = await new User({
                googleId: req.user.id,
                name,
                email,
                profilePicture,
            }).save();
        }

        // Generate JWT token
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        res.json({ token, user });
    } catch (error) {
        console.error("Error during Google authentication callback:", error);
        res.status(500).json({ message: 'Internal server error' });
    }
};

// Forgot Password function
export const forgotPassword = async (req, res) => {
    const { email } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) return res.status(400).json({ msg: 'User does not exist' });

        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '15m' });

        const mailOptions = {
            from: process.env.EMAIL,
            to: user.email,
            subject: 'Password Reset',
            text: `Click on the link to reset your password: ${process.env.CLIENT_URL}/reset-password/${token}`
        };

        await transporter.sendMail(mailOptions);
        res.json({ msg: 'Password reset link sent' });
    } catch (error) {
        res.status(500).send('Server error');
    }
};

// Reset Password function
export const resetPassword = async (req, res) => {
    const { token, newPassword } = req.body;

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const user = await User.findById(decoded.userId);
        if (!user) return res.status(400).json({ msg: 'Invalid or expired token' });

        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(newPassword, salt);
        await user.save();

        res.json({ msg: 'Password reset successful' });
    } catch (error) {
        res.status(500).send('Server error');
    }
};

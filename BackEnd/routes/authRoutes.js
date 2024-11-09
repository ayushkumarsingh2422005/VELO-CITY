import express from 'express';
import { register, login, forgotPassword, resetPassword, googleAuthCallback } from '../controllers/authController.js';
import passport from 'passport';

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.post('/forgot-password', forgotPassword);
router.post('/reset-password', resetPassword);

// Auth with Google
router.get('/google', passport.authenticate('google', {
    scope: ['profile', 'email']
}));

// Callback route for Google to redirect to
router.get('/google/callback', passport.authenticate('google', { session: false }), googleAuthCallback);


export default router;

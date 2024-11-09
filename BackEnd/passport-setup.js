import passport from 'passport';
import GoogleStrategy from 'passport-google-oauth20';
import User from './models/User.js';
import dotenv from 'dotenv';
dotenv.config();

// console.log('GOOGLE_CLIENT_ID:', process.env.GOOGLE_CLIENT_ID);
// console.log('GOOGLE_CLIENT_SECRET:', process.env.GOOGLE_CLIENT_SECRET);

// Configure Google OAuth strategy
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/api/auth/google/callback'
}, async (accessToken, refreshToken, profile, done) => {
    try {
        // Check if user already exists in our database
        const existingUser = await User.findOne({ googleId: profile.id });

        if (existingUser) {
            // User already exists, return user
            return done(null, existingUser);
        } else {
            // If not, create a new user in our database
            const newUser = await new User({
                googleId: profile.id,
                name: profile.displayName,
                email: profile.emails[0].value,
                profilePicture: profile.photos[0].value
            }).save();
            return done(null, newUser);
        }
    } catch (error) {
        console.error("Error during Google authentication:", error);
        return done(error, null); // Pass the error to the done callback
    }
}));

// Serialize user to session
passport.serializeUser((user, done) => {
    done(null, user.id);
});

// Deserialize user from session
passport.deserializeUser((id, done) => {
    User.findById(id)
        .then((user) => {
            done(null, user);
        })
        .catch((error) => {
            console.error("Error deserializing user:", error);
            done(error, null); // Handle error
        });
});

# Set project folder name
$projectName = "auth-backend"

# Create main project folder
New-Item -ItemType Directory -Name $projectName -Force
Set-Location -Path $projectName

# Create subdirectories
$directories = @("controllers", "models", "routes", "middleware", "config", "utils", "uploads")
foreach ($dir in $directories) {
    New-Item -ItemType Directory -Name $dir -Force
}

# Create main entry files with initial content
@"
require('dotenv').config();
const express = require('express');
const connectDB = require('./config/db');
const app = express();

// Middleware
app.use(express.json());

// Routes
app.use('/api/auth', require('./routes/authRoutes'));
app.use('/api/user', require('./routes/userRoutes'));

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(\`Server running on port \${PORT}\`));
"@ | Set-Content -Path "server.js"

@"
# Environment variables
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
"@ | Set-Content -Path ".env"

@"
node_modules
.env
uploads
"@ | Set-Content -Path ".gitignore"

# Create README file
New-Item -ItemType File -Path "README.md" -Force

# Create controllers with initial code
@"
const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { validationResult } = require('express-validator');
const nodemailer = require('nodemailer');

exports.register = async (req, res) => { /* Registration logic */ };
exports.login = async (req, res) => { /* Login logic */ };
exports.googleAuth = async (req, res) => { /* Google auth logic */ };
exports.forgotPassword = async (req, res) => { /* Forgot password logic */ };
exports.resetPassword = async (req, res) => { /* Reset password logic */ };
"@ | Set-Content -Path "controllers/authController.js"

@"
const User = require('../models/User');

exports.updateProfile = async (req, res) => { /* Profile update logic */ };
"@ | Set-Content -Path "controllers/userController.js"

# Create models with initial code
@"
const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    googleId: { type: String },
    profilePicture: { type: String }
});

module.exports = mongoose.model('User', UserSchema);
"@ | Set-Content -Path "models/User.js"

# Create routes with initial code
@"
const express = require('express');
const router = express.Router();
const { register, login, googleAuth, forgotPassword, resetPassword } = require('../controllers/authController');

router.post('/register', register);
router.post('/login', login);
router.post('/google', googleAuth);
router.post('/forgot-password', forgotPassword);
router.post('/reset-password', resetPassword);

module.exports = router;
"@ | Set-Content -Path "routes/authRoutes.js"

@"
const express = require('express');
const router = express.Router();
const { updateProfile } = require('../controllers/userController');

router.put('/profile', updateProfile);

module.exports = router;
"@ | Set-Content -Path "routes/userRoutes.js"

# Create middleware with initial code
@"
const jwt = require('jsonwebtoken');

module.exports = function (req, res, next) {
    const token = req.header('x-auth-token');
    if (!token) return res.status(401).send('Access denied.');

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();
    } catch (ex) {
        res.status(400).send('Invalid token.');
    }
};
"@ | Set-Content -Path "middleware/authMiddleware.js"

@"
module.exports = function (err, req, res, next) {
    console.error(err.message);
    res.status(500).send('Server error');
};
"@ | Set-Content -Path "middleware/errorHandler.js"

# Create config files with initial code
@"
const mongoose = require('mongoose');
const connectDB = async () => {
    try {
        await mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true });
        console.log('MongoDB Connected...');
    } catch (err) {
        console.error(err.message);
        process.exit(1);
    }
};
module.exports = connectDB;
"@ | Set-Content -Path "config/db.js"

@"
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/auth/google/callback'
}, (accessToken, refreshToken, profile, done) => { /* Google auth strategy */ }));

module.exports = passport;
"@ | Set-Content -Path "config/googleAuth.js"

# Create utility files with initial code
@"
const nodemailer = require('nodemailer');

module.exports = async function sendEmail(to, subject, text) {
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS
        }
    });

    const mailOptions = { from: process.env.EMAIL_USER, to, subject, text };

    await transporter.sendMail(mailOptions);
};
"@ | Set-Content -Path "utils/emailService.js"

Write-Output "Project structure and files with initial code created successfully."

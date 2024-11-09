import mongoose from 'mongoose';

const UserSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: function () {
        return !this.googleId; // Password is required only if googleId is not set
    }},
    googleId: { type: String },
    profilePicture: { type: String }
}, {
    timestamps: true // This adds createdAt and updatedAt timestamps
});

export default mongoose.model('User', UserSchema);

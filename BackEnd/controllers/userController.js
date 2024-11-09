import User from '../models/User.js';
import bcrypt from 'bcryptjs';
import { validationResult } from 'express-validator';

// Update Profile Function
export const updateProfile = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

  const { name, email, password } = req.body;
  const userId = req.user.id;

  try {
    let user = await User.findById(userId);
    if (!user) return res.status(404).json({ msg: 'User not found' });

    if (name) user.name = name;
    if (email) user.email = email;

    if (password) {
      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(password, salt);
    }

    await user.save();
    res.json({ msg: 'Profile updated successfully', user });
  } catch (error) {
    console.error(error.message);
    res.status(500).send('Server error');
  }
};

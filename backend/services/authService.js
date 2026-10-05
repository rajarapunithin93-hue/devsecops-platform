const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const UserModel = require('../models/userModel');

const AuthService = {
  async register({ name, email, password }) {
    const existing = await UserModel.findByEmail(email);
    if (existing) {
      const err = new Error('Email already registered');
      err.status = 409;
      throw err;
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const user = await UserModel.create({ name, email, passwordHash });
    return user;
  },

  async login({ email, password }) {
    const user = await UserModel.findByEmail(email);
    if (!user) {
      const err = new Error('Invalid email or password');
      err.status = 401;
      throw err;
    }

    const valid = await bcrypt.compare(password, user.password_hash);
    if (!valid) {
      const err = new Error('Invalid email or password');
      err.status = 401;
      throw err;
    }

    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '1d' }
    );

    return {
      token,
      user: { id: user.id, name: user.name, email: user.email, role: user.role },
    };
  },
};

module.exports = AuthService;

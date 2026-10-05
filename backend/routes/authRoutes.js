const express = require('express');
const router = express.Router();
const authenticate = require('../middleware/auth');
const AuthController = require('../controllers/authController');

router.post('/register', AuthController.register);
router.post('/login', AuthController.login);
router.get('/me', authenticate, AuthController.me);

module.exports = router;

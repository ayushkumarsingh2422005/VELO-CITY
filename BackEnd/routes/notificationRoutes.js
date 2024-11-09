import express from 'express';
import { sendNotification } from '../controllers/notificationController.js';

const router = express.Router();

// Define route for sending notifications
router.post('/send', sendNotification);

export default router;

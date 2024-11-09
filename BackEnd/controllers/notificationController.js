import { getSocketIO } from '../config/socket.js';

// Send notification to all connected clients
export const sendNotification = (req, res) => {
    const { title, message } = req.body;

    const io = getSocketIO(); // Get the Socket.IO instance

    // Emit a notification event to all connected clients
    io.emit('notification', { title, message });

    res.status(200).send('Notification sent');
};

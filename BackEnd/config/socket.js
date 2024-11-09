import { Server } from 'socket.io';

let io; // Variable to hold the Socket.IO server

export const 
initializeSocket = (httpServer) => {
    io = new Server(httpServer, {
        cors: {
            origin: '*', // Adjust this as needed for your frontend
            methods: ['GET', 'POST'],
        },
    });

    io.on('connection', (socket) => {
        console.log('User connected:', socket.id);

        socket.on('disconnect', () => {
            console.log('User disconnected:', socket.id);
        });
    });
};

// Export the Socket.IO instance for use in controllers
export const getSocketIO = () => {
    if (!io) {
        throw new Error('Socket.IO not initialized!');
    }
    return io;
};

// admin.js

import AdminJS from 'adminjs';
import AdminJSExpress from '@adminjs/express';
import mongoose from 'mongoose';
import User from './models/User.js'; // Adjust the path as necessary
import dotenv from 'dotenv';

dotenv.config();

const adminJs = new AdminJS({
    resources: [
        {
            resource: User,
            options: {
                // Optional: Customize how the User model appears in the admin panel
                properties: {
                    password: {
                        isVisible: { list: false, edit: true, show: true, filter: false },
                    },
                },
            },
        },
    ],
    rootPath: '/admin',
});

// Create AdminJS router
const adminJsRouter = AdminJSExpress.buildRouter(adminJs);

// Middleware for admin authentication
adminJsRouter.use((req, res, next) => {
    const auth = req.headers.authorization;
    if (auth && auth.startsWith('Basic ')) {
        const base64Credentials = auth.split(' ')[1];
        const credentials = Buffer.from(base64Credentials, 'base64').toString('ascii');
        const [adminId, password] = credentials.split(':');

        if (adminId === process.env.ADMIN_ID && password === process.env.ADMIN_PASSWORD) {
            return next();
        }
    }

    res.set('WWW-Authenticate', 'Basic');
    return res.status(401).send('Authentication required.');
});

// Export the router
export { adminJsRouter };

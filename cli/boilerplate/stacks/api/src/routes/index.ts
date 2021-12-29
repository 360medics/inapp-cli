import { Router } from 'express';
import { userRouter } from './user';

export const apiRouter = Router();

apiRouter.use('/user', userRouter);

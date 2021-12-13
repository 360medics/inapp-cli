import { Router } from 'express';
import { getUser } from './user';

export const userRouter = Router();

userRouter.get('/:userId', getUser);

import { Router } from 'express';
import {getUser, createUser, updateUser, deleteUser } from './user';

export const userRouter = Router();

userRouter.get('/:userId', getUser);
userRouter.post('/', createUser);
userRouter.patch('/:userId', updateUser);
userRouter.delete('/:userId', deleteUser);

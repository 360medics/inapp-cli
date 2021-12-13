import { RequestHandler } from 'express';
import { orm } from 'internal/orm.service';
import bcrypt from 'bcrypt';

export const getUser: RequestHandler = async (req, res) => {
  const { userId } = req.params;

  const user = await orm.user.findUnique({ where: { id: userId } });
  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }
  return res.status(200).json({ user });
};

export const createUser: RequestHandler = async (req, res) => {
  if (!req.body) {
    return res.status(404).json({ message: 'Body can not be empty' });
  }

  const user = req.body;
  user.password = bcrypt.hashSync(req.body.password, 10);

  const userCreated = await orm.user.create({ data: req.body });

  return res.status(200).json(userCreated);
};

export const updateUser: RequestHandler = async (req, res) => {
  const { userId } = req.params;
  const user = await orm.user.findUnique({ where: { id: userId } });

  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }

  const updatedUser = await orm.user.update({
    where: {
      id: userId,
    },
    data: req.body,
  });

  return res.status(200).json(updatedUser);
};

export const deleteUser: RequestHandler = async (req, res) => {
  const { userId } = req.params;
  const user = await orm.user.findUnique({ where: { id: userId } });

  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }

  const deletedUser = await orm.user.delete({
    where: {
      id: userId,
    },
  });
  console.log(deletedUser);

  return res.status(200).json({ message: 'User successfully deleted' });
};

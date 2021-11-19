import { RequestHandler } from 'express';
import { orm } from 'internal/orm.service';

export const getUser: RequestHandler = async (req, res) => {
  const { userId } = req.params;

  const user = await orm.user.findUnique({ where: { id: userId } });
  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }

  return res.status(200).json({ user });
};

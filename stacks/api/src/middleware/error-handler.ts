import { ErrorRequestHandler } from 'express';
import { logger } from 'internal/logger';

export const errorHandler: ErrorRequestHandler = function (err, req, res, next) {
  if (res.headersSent) {
    return next(err);
  }

  logger.error(err);

  const status = err.status || 500;
  const message = err.message || 'Something went wrong';
  res.status(status).json({
    status,
    message,
  });
};

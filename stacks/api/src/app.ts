import bodyParser from 'body-parser';
import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import { errorHandler } from 'middleware/error-handler';
import morgan from 'morgan';
import { apiRouter } from 'routes';

export const app = express();

app.get('/', (req: any, res: any, next: any) => {
  res.send(200, { message: 'Your api is running !' });
  return next();
});

// global middlewares registration
app.use(cors());
app.use(helmet());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(morgan('combined'));

// Register domain routes
app.use(apiRouter);

// global error handler
app.use(errorHandler);

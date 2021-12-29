import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import { errorHandler } from 'middleware/error-handler';
import morgan from 'morgan';
import { apiRouter } from 'routes';

export const app = express();

// Healthcheck route for load balancer
app.get('/', (req, res) => {
  res.send({ message: 'API is healthy!' });
});

// global middlewares registration
app.use(cors());
app.use(helmet());
app.use(express.json());
app.use(express.urlencoded({
  extended: true,
}));

app.use(morgan('combined'));

// Register domain routes
app.use(apiRouter);

// global error handler
app.use(errorHandler);

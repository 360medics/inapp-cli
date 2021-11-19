import bodyParser from 'body-parser';
import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import { errorHandler } from 'middleware/error-handler';
import morgan from 'morgan';
import { apiRouter } from 'routes';

// @TODO: custom error handler (log + response)
export const app = express();

// global middlewares registration
// app.use(cors());
// app.use(helmet());
// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: false }));

// app.use(morgan('combined'));

// @TODO
// register domain routes
app.use(apiRouter);

app.use(errorHandler);

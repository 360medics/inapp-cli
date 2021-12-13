require('express-async-errors');
import 'source-map-support/register';

import { app } from 'app';
import { logger } from 'internal/logger';

const port = process.env.PORT || 4000;

app.listen(port, () => {
  logger.info({ message: `Server ${process.env.PROJECT_NAME} running on port ${port}` });
});

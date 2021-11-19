require('express-async-errors');
import { app } from 'app';

const port = process.env.PORT || 4000;

app.listen(port, () => {
  console.log(`Server ${process.env.PROJECT_NAME} running on port ${port}`);
});

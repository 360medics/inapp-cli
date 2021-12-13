'use strict';

const dotenv = require('dotenv');
const dotenvExpand = require('dotenv-expand');

process.chdir(__dirname + '/..');

const args = process.argv.slice(2);
const filePath = args.shift();

console.log(`Loading .env from ${filePath}`);

const envVariables = dotenv.config({
  path: filePath,
});

dotenvExpand(envVariables);

console.log(`Using DATABASE_URL variable: ${process.env.DATABASE_URL}`);

const { spawn } = require('child_process');
const opts = { stdio: 'inherit' };

if (process.platform === 'win32') {
  spawn('cmd', ['/c', 'node_modules\\.bin\\prisma.cmd', ...args], opts);
} else {
  spawn('node_modules/.bin/prisma', args, opts);
}

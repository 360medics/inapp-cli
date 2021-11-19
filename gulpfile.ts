import { exec } from "child_process";
import dotenv from "dotenv";
import gulp from "gulp";

dotenv.config();

gulp.task("install-api-deps", (done) => {
  console.log("Installing API dependencies");

  exec("npm i --prefix stacks/api", function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    done(err);
  });
});

gulp.task("install-client-deps", (done) => {
  console.log("Installing Client dependencies");

  exec("npm i --prefix stacks/client", function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    done(err);
  });
});

gulp.task("prisma-generate", (done) => {
  exec(
    "npm run prisma:generate --prefix stacks/api",
    function (err, stdout, stderr) {
      console.log(stdout);
      console.error(stderr);
      done(err);
    }
  );
});

// this runs on postinstall (after installed project root dependencies)
gulp.task(
  "install",
  gulp.parallel(
    gulp.series("install-api-deps", "prisma-generate"),
    "install-client-deps"
  )
);

gulp.task("up", (done) => {
  console.log("Starting the stack");

  exec("docker compose up -d", function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    done(err);
  });
});

gulp.task("down", (done) => {
  console.log("Stopping the stack");

  exec("docker compose down", function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    done(err);
  });
});

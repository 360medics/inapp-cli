import { exec } from "child_process";
import dotenv from "dotenv";
import gulp from "gulp";

dotenv.config();

{{if .Backend}}gulp.task("install-api-deps", (done) => {
  console.log("Installing API dependencies");

  exec("npm i --prefix stacks/api", function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    done(err);
  });
});
{{end}}
{{if .Frontend}}gulp.task("install-client-deps", (done) => {
  console.log("Installing Client dependencies");

  exec("npm i --prefix stacks/client", function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    done(err);
  });
});
{{end}}
{{if .Backend}}gulp.task("prisma-generate", (done) => {
  exec(
    "npm run prisma:generate --prefix stacks/api",
    function (err, stdout, stderr) {
      console.log(stdout);
      console.error(stderr);
      done(err);
    }
  );
});{{end}}
// this runs on postinstall (after installed project root dependencies)
gulp.task(
  "install",
  gulp.parallel(
    {{if .Backend}}gulp.series("install-api-deps", "prisma-generate"),{{end}}
    {{if .Frontend}}"install-client-deps"{{end}}
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

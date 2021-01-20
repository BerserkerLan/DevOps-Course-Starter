# DevOps Apprenticeship: Project Exercise

## Getting started

The project uses a virtual environment to isolate package dependencies. To run, you must ensure you have environment variables for 'KEY' and 'TOKEN' which are the key and token respectively for querying the flask API. To create the virtual environment and install required packages, run the following from a bash shell terminal:

### Running the Application

To run this application, you must have poetry installed.

After that, simply call
```bash
poetry install
```
to install all dependencies. Then you can call
```bash
flash run
```
 to run the application.

You should see output similar to the following:
```bash
 * Serving Flask app "app" (lazy loading)
 * Environment: development
 * Debug mode: on
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
 * Restarting with fsevents reloader
 * Debugger is active!
 * Debugger PIN: 226-556-590
```
Now visit [`http://localhost:5000/`](http://localhost:5000/) in your web browser to view the app.

### Notes

The `.env` file is used by flask to set environment variables when running `flask run`. This enables things like developement mode (which also enables features like hot reloading when you make a file change).
* There's also a [SECRET_KEY](https://flask.palletsprojects.com/en/1.1.x/config/#SECRET_KEY) variable which is used to encrypt the flask session cookie.

When running `setup.sh`, the `.env.template` file will be copied to `.env` if the latter does not exist.
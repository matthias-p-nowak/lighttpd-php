# Lighttpd + PHP + XDebug

This is a docker container solution for running lighttpd with a php backend. Debugging is possible, because Xdebug is also installed and configured.

## Usage

The docker container takes 2 directories as mapped volumes.

directory | volume | purpose
--- | --- | ---
live | `/live` | This is the area accessible by *PHP* and can be modified without restarting the docker container.
output | `/output` | For log-files and similar.

After starting the container, one can edit the files under `live` and debug the php scripts using Xdebug. It is possible to give PHP access to a larger fileshare than just the folder visible to the web-server. In this case, PHP has access to everything inside the container, while the *lighttpd* only serves content from `/live/www`.

> Putting PHP scripts into a different folder than the visible www simplifies the hiding of the PHP scripts. The `www` folder only needs to contain the entry point.

### Php modules

Extend the ```install.sh``` script, so all necessary php packages are installed.

## How does Xdebug work?

It is a triangle consisting of a server with php (this piece), a browser that initiates the connection and an editor with xdebug support. The editor functions as a front end for the xdebug-module in the PHP. The browser also needs to have some additional support - an Xdebug helper. The web-browser connects to the web-server, which runs the PHP script and the PHP process in turn connects to the editor.

### Sequence of actions

1. Activate the container with `docker compose up` or similar. The setup for Xdebug contains the `50_xdebug.ini` that has the setting
~~~ini
xdebug.mode = develop,debug
xdebug.log = /tmp/xdebug.log
xdebug.client_host = host.docker.internal
xdebug.start_with_request = trigger
xdebug.idekey = vsc
~~~
2. Open the editor like Visual studio code and start the listener for Xdebug (aka Xdebug Frontend). The IP-address should be the one from the settings above and the port number should be 9003. The special dns name `host.docker.internal` resolves to the IP-address of the host.
3. Open the browser with an installed "Xdebug helper" (for firefox) or similar. In the settings, set the `ide key` to "vsc". Then open the web page.
4. The browser sends the get request to the container with a cookie
~~~
XDEBUG_SESSION=vsc
~~~
5. The request gets routed to the PHP-FPM fastcgi program. The cookie triggers the Xdebug module, it starts and connects to the *client*, which in this case is the Xdebug-front-end. When connected, the PHP-script gets executed.
6. The Xdebug backend communicates with the frond end in the editor and applies breakpoints and similar.
7. At breakpoints, the editor gets active and displays local variables and more.

## Browser configuration
When XDebug is configured to start only when triggered, the browser has to send extra headers or cookies when sending a request. For *Firefox* there is the extension name **Xdebug helper**. For triggering, the IDE-key needs to be the same as in the configuration.


#!/usr/bin/env python
# -*- coding: UTF-8 -*-

from os import curdir, sep
from BaseHTTPServer import \
BaseHTTPRequestHandler, HTTPServer

class Capturar(BaseHTTPRequestHandler):
    def do_GET(self):
        try:
            f = open('/dev/ttyS0','r')
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            dato=f.read(15)
            dato=dato.split()[1]
            self.wfile.write(dato)
            f.close()
        except IOError:
            self.send_error(404, 'File Not Found: %s' % self.path)
try:
    server = HTTPServer(('',9600), Capturar)
    print 'Se inicia servicio web para lectura de romana del puerto serial.'
    print 'Precione ^C una vez o dos veces para salir.'    
    server.serve_forever()
except KeyboardInterrupt:
    print ' Se ha recibido ^C, cerrando el servidor.'
    server.socket.close()   


#!/usr/bin/env python
# -*- coding: UTF-8 -*-

from os import curdir, sep
from BaseHTTPServer import \
BaseHTTPRequestHandler, HTTPServer

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        try:
            f = open('/dev/ttyS0','r')
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            dato=f.read(15)
            self.wfile.write('<input id="peso2" name="peso2" value="'+dato+'" />')
#            dato=dato[5:-8]
            dato=dato.split()[1]
            self.wfile.write('<input id="peso1" name="peso1" value="'+dato+'" />')
            f.close()
        except IOError:
            self.send_error(404, 'File Not Found: %s' % self.path)
try:
    server = HTTPServer(('', 8888), MyHandler)
    print 'Welcome to the machine...',
    print 'Press ^C once or twice to quit.'
    server.serve_forever()
except KeyboardInterrupt:
    print '^C received, shutting down server'
    server.socket.close()   
#if __name__ == '__main__':
#    main()


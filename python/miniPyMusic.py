#!/usr/bin/python
# -*- coding: iso-8859-1 -*-

# miniPyMusic - a minimalist music server
# Run me in the directory of your MP3/OGG files
# and point your browser at me.
# Great for a simple LAN music server.

import os,os.path,BaseHTTPServer,SimpleHTTPServer,SocketServer,socket,mimetypes,urllib

PORT = 8099
HOSTNAME = socket.gethostbyaddr(socket.gethostname())[0]

MIME_TYPES = mimetypes.types_map
MIME_TYPES[".ogg"] = u"audio/ogg"

def buildm3u(directory):
    # Get all .mp3/.ogg files from subdirectories, and built a playlist (.m3u)
    files = [u"#EXTM3U"]
    for dirpath, dirnames, filenames in os.walk(directory):
        for filename in filenames:
            if os.path.splitext(filename)[1].lower() in (u'.mp3',u'.ogg'):
                filepath = os.path.normpath(os.path.join(dirpath,filename))
                files.append(u"#EXTINF:-1,%s" % filename) 
                # urllib.quote does not seem to handle all Unicode strings properly
                data = urllib.quote(filepath.replace(os.path.sep,"/").encode("utf-8","replace"))
                files.append(u"http://%s:%s/%s" % (HOSTNAME,PORT,data))
    return files

class miniMusicServer(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == u"/":  # We will return the .m3u file.
            self.send_response(200)
            self.send_header(u'Content-Type',u'audio/x-mpegurl; charset=utf-8')
            self.send_header(u'Content-Disposition',u'attachment; filename="playlist.m3u"')
            self.end_headers()
            self.wfile.write(u"\n".join(buildm3u(u".")).encode("utf-8","replace"))
        else: # Return the music file with proper MIME type.
            localpath = urllib.unquote(self.path).decode("utf-8").replace(u"/",os.path.sep)[1:].replace(u"..",u".")
            if os.path.isfile(localpath):
                ext = os.path.splitext(localpath)[1].lower()
                mimetype = u"application/octet-stream"
                if ext in MIME_TYPES: mimetype=MIME_TYPES[ext]  # Get the correct MIME type for this extension.
                self.send_response(200)
                self.send_header(u'Content-Type',mimetype)
                self.send_header(u'Content-Length',unicode(os.path.getsize(localpath)))
                self.end_headers()
                self.wfile.write(open(localpath,"rb").read())
            else: # File not found ? Will simply return a 404.
                SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)
            
httpd = SocketServer.ThreadingTCPServer(('', PORT), miniMusicServer)
print u"Music server ready at http://%s:%s" % (HOSTNAME,PORT)
httpd.serve_forever()

#!/usr/bin/python2
# -*- coding: utf-8
"""
Helper functions for offlineimap
"""


import keyring
import binascii
import codecs


#############
# Nametrans #
#############
gmail_folders = ['Entwürfe', 'Gesendet', 'Markiert', 'Papierkorb',
        'Spam', 'Wichtig', 'Alle Nachrichten']

def gmail_local_nametrans(foldername, prefix='[Gmail]', separator='/'):
    if foldername in gmail_folders:
        return "{}{}{}".format(prefix, separator, foldername)
    else:
        return foldername


##################
# # De-/encoding #
##################
# Imap folder names are encoded using a special version of utf-7 as defined
# in RFC 2060 section 5.1.3.
def encoder(s):
    def doB64(_in, r):
        def modified_base64(s):
            s = s.encode('utf-16be')
            return binascii.b2a_base64(s).rstrip('\n=').replace('/', ',')

        if _in:
            r.append('&%s-' % modified_base64(''.join(_in)))
            del _in[:]

    r = []
    _in = []
    for c in s:
        ordC = ord(c)
        if 0x20 <= ordC <= 0x25 or 0x27 <= ordC <= 0x7e:
            doB64(_in, r)
            r.append(c)
        elif c == '&':
            doB64(_in, r)
            r.append('&-')
        else:
            _in.append(c)
    doB64(_in, r)
    return (str(''.join(r)), len(s))


def decoder(s):
    def modified_unbase64(s):
        b = binascii.a2b_base64(s.replace(',', '/') + '===')
        return unicode(b, 'utf-16be')

    r = []
    decode = []
    for c in s:
        if c == '&' and not decode:
            decode.append('&')
        elif c == '-' and decode:
            if len(decode) == 1:
                r.append('&')
            else:
                r.append(modified_unbase64(''.join(decode[1:])))
            decode = []
        elif decode:
            decode.append(c)
        else:
            r.append(c)
    if decode:
        r.append(modified_unbase64(''.join(decode[1:])))
    bin_str = ''.join(r)
    return (bin_str, len(s))


class StreamReader(codecs.StreamReader):
    def decode(self, s, errors='strict'):
        return decoder(s)


class StreamWriter(codecs.StreamWriter):
    def decode(self, s, errors='strict'):
        return encoder(s)


def imap4_utf_7(name):
    if name == 'imap4-utf-7':
        return (encoder, decoder, StreamReader, StreamWriter)


codecs.register(imap4_utf_7)

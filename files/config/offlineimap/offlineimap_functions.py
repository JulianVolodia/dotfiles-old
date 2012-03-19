#!/usr/bin/python2
# -*- coding: latin-1 -*-

"""
Imap folder names are encoded using a special version of utf-7 as defined in RFC 
2060 section 5.1.3.

For example, here is a mailbox name which mixes English, Japanese,
and Chinese text: ~peter/mail/&ZeVnLIqe-/&U,BTFw-
"""
import netrc
import binascii
import codecs

def getcredentials(hostname, auth):
    try:
        netrcfile = netrc.netrc()
    except netrc.NetrcParseError:
        print 'The file is malformed.'
    if auth == 'host':
        return hostname
    if auth == 'user':
        return netrcfile.authenticators(hostname)[0]
    if auth == 'pass':
        return netrcfile.authenticators(hostname)[2]

# encoding
def modified_base64(s):
    s = s.encode('utf-16be')
    return binascii.b2a_base64(s).rstrip('\n=').replace('/', ',')

def doB64(_in, r):
    if _in:
        r.append('&%s-' % modified_base64(''.join(_in)))
        del _in[:]

def encoder(s):
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


# decoding

def modified_unbase64(s):
    b = binascii.a2b_base64(s.replace(',', '/') + '===')
    return unicode(b, 'utf-16be')


def decoder(s):
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

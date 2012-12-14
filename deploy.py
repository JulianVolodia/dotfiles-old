#!/usr/bin/env python2

"""
Copies files from dir1 to dir2, and then places symlinks from dir2 into
dir3, turning the top-level symlinks into dotfiles in the process.

To re-phrase that as something that can be understood by human beings:

This script is used to deploy my dotfiles into my home directory. In
order to decouple the files themselves from the repository, however,
they are first copied somewhere else (dir2). Only then does the script
place symlinks from the new dotfiles directory (dir2) into the home
directory (dir3) adding dots to the names in appropriate places, so they
can actually do their work as configuration files.

The reason for the copying step is that I simply don't like working
directly from inside a repository; something *might* introduce changes
to a file and I don't immediately pick up on it, and I look at hg diff
output and wonder what I was smoking.

Right now, the symlinks are absolute; I am planning to change that.
"""

import os
import os.path as op
import shutil
import sys


if sys.version_info.major != 2 or sys.version_info.minor < 6:
    print "Only Python 2.6+ is supported."
    sys.exit(1)


def expand_path(path):
    """
    Expands ``~`` and environment variables in a pathname.
    """
    return op.expanduser(op.expandvars(path))


def find_files(path):
    """
    Recursively yields all files in a directory.
    """
    for root, dirs, files in os.walk(path):
        for filename in files:
            yield op.join(root, filename)


def gen_dotfile_name(src_file, src_dir):
    """
    Generates a filename for a dotfile.

    ``src_file``'s path relative to ``src_dir`` is prepended by a dot.

    Example::

        >>> create_dotfile_path('foo/bar/fnord', 'foo')
        '.bar/fnord'
    """
    return '.' + op.relpath(src_file, src_dir)


def symlink(src_file, dst_file, dry_run=False, overwrite='symlink'):
    """
    Symlinks ``dst_file`` to ``src_file``.

    ``overwrite`` determines what to do in case of an already existing
    ``dst_file``.
    * ``'nothing'`` leaves an already in-place ``dst_file``
      completely untouched.
    * ``'symlink'`` updates ``dst_file`` to point to
      ``src_file``.
    * ``'file'`` overwrites ``dst_file`` with a symlink to
    ``src_file`` even if it is a regular file.

    If ``dry_run`` is ``True``, no actual operation is carried out.
    """
    def relink(src_file, dst_file):
        if not dry_run:
            os.remove(dst_file)
            os.symlink(src_file, dst_file)

    try:
        if not dry_run:
            os.symlink(src_file, dst_file)
    except OSError as e:
        import errno
        if e.errno == errno.EEXIST:
            if overwrite == 'nothing':
                print dst_file, "already exists, moving on"
            elif op.islink(dst_file) and overwrite == 'symlink':
                print "Updating symlink", dst_file, "to point to", src_file
                relink(src_file, dst_file)
            elif overwrite == 'file':
                print "Overwriting file", dst_file, "with link to", src_file
                relink(src_file, dst_file)
        else:
            raise
    else:
        print "Creating symlink from", src_file, "to", dst_file


def create_symlinks(src_dir, dst_dir, overwrite='symlink',
        dry_run=False):
    """
    Creates symlinks from ``src_dir`` to ``dst_dir``.

    Creates all necessary directories under ``dst_dir``.
    """
    for src_abs_file in find_files(src_dir):
        dst_rel_file = gen_dotfile_name(src_rel_file, src_dir)
        dst_abs_file = op.join(dst_dir, dst_rel_file)
        if not dry_run:
            try:
                os.makedirs(op.dirname(dst_abs_file))
            except OSError as e:
                import errno
                if e.errno == errno.EEXIST:
                    print op.dirname(dst_abs_file), "already exists"
        symlink(src_abs_file, dst_abs_file, overwrite=overwrite,
                dry_run=dry_run)


def parse_args():
    import argparse

    p = argparse.ArgumentParser(description="Deploy dotfiles")
    p.add_argument('-s', '--source-dir', default='files',
            help=("Directory where configuration files are in "
                    "(default: ./files)"))
    p.add_argument('-d', '--sink-dir', default='~/.config/dotfiles',
            help=("Directory where configuration files should be copied to "
                    "(default: ~/.config/dotfiles)"))
    p.add_argument('-l', '--symlink-dir', default='~',
            help=("Directory where symlinks should be created "
                    "(default: ~)"))
    p.add_argument('-o', '--overwrite', choices=['nothing', 'symlink', 'file'],
            default='symlink',
            help="How to deal with existing destination files")
    p.add_argument('-n', '--dry-run', action='store_true', default=False,
            help='Only list actions that would have been performed')
    return p.parse_args()


def main():

    args = parse_args()
    source_dir = expand_path(args.source_dir)
    sink_dir = expand_path(args.sink_dir)
    symlink_dir = expand_path(args.symlink_dir)
    dry_run = args.dry_run

    print "Copying files from", source_dir, "to", sink_dir
    if not dry_run:
        shutil.rmtree(sink_dir, ignore_errors=True)
        shutil.copytree(source_dir, sink_dir)
    print "Symlinking files from", sink_dir, "to", symlink_dir
    create_symlinks(sink_dir, symlink_dir, overwrite=args.overwrite,
            dry_run=dry_run)


if __name__ == '__main__':
    main()

#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
"""Generate a Makefile to create universal library
"""

from __future__ import print_function
import argparse, os, re, sys, cStringIO

NON_WORD_CHAR_PATTERN = re.compile(r'\W')

def main():
    """main
    """
    args = get_args()
    prefix = args.prefix
    archs = sorted(args.archs)
    libs = sorted(args.libs)
    nlibs = {}
    for lib in sorted(args.nlibs):
        names = lib.split(',')
        nlibs[names[0]] = names[1:]

    if args.output != None:
        print('output =', args.output)
    else:
        print('output = STDOUT')
    print('archs =', archs)
    print('libs =', (libs, nlibs))
    print('--')

    if args.output:
        run(prefix, archs, libs, nlibs,
            output=open(args.output, 'w+'),
            verbose=args.verbose)
    else:
        run(prefix, archs, libs, nlibs,
            verbose=args.verbose)

def get_args():
    """Get console arguments
    """
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--prefix', default='.',
                        help='installation prefix')
    parser.add_argument('--arch', nargs='+', default=[],
                        dest='archs', metavar=('ARCH1', 'ARCH2'),
                        help='target architecture type')
    parser.add_argument('-l', action='append', default=[],
                        dest='libs', metavar='LIB',
                        help='library name to make universal')
    parser.add_argument('--ln', action='append', default=[],
                        dest='nlibs', metavar='TARGET,LIB1,LIB2,...',
                        help='library name to make universal'
                            ' (with different names)')
    parser.add_argument('-o', '--output', metavar='FILENAME',
                        help='filename to write Makefile')
    parser.add_argument('-v', '--verbose', action='store_true',
                        help='always print generated Makefile')
    return parser.parse_args()

def run(prefix, archs, libs, nlibs, output=sys.stdout, verbose=False):
    """Write a Makefile
    """
    generate(prefix, archs, libs, nlibs, output=output)

    if verbose and output is not sys.stdout:
        output.seek(0)
        print(output.read(), end='')

def generate(prefix, archs, libs, nlibs, output=sys.stdout):
    """Generate a Makefile
    """
    put_macros(output, prefix, libs, nlibs, archs)
    output.write('\n')
    put_rules(output, libs + nlibs.keys())
    if len(libs) > 0:
        output.write('\n')
        put_clean(output)

def put_macros(output, prefix, libs, nlibs, archs):
    """Put macros
    """
    output.write('PREFIX := ' + prefix + '\n')
    output.write('LIPO ?= /usr/bin/lipo\n')
    output.write('\n')

    libnames = libs + nlibs.keys()

    if len(libnames) == 0:
        output.write('UNIVERSAL_LIBRARIES :=\n')
    else:
        output.write('UNIVERSAL_LIBRARIES := ' + target(libnames[0]) + '\n')
        for lib in libnames[1:]:
            output.write('UNIVERSAL_LIBRARIES += ' + target(lib) + '\n')

    output.write('\n')

    for lib in libs:
        output.write(needs(lib) + ' :=')
        output.writelines([' ' + arch + '/' + target(lib) for arch in archs])
        output.write('\n')

    for lib, alibs in nlibs.items():
        output.write(needs(lib) + ' :=')
        for arch, alib in zip(archs, alibs):
            output.write(' ' + arch + '/' + target(alib))
        output.write('\n')

def put_rules(output, libs):
    """Put rules
    """
    output.write('all: $(UNIVERSAL_LIBRARIES)\n')

    for lib in libs:
        output.write('\n')
        output.write(target(lib) + ': $(' + needs(lib) + ')\n')
        output.write('\t$(LIPO) -create $^ -output $@\n')

def put_clean(output):
    """Put 'clean' and '.PHONY'
    """
    output.write('clean:\n')
    output.write('\trm -f $(UNIVERSAL_LIBRARIES)\n')
    output.write('\n')
    output.write('.PHONY: clean')
    output.write('\n')

def target(lib):
    """Convert 'name' to 'lib/libname.a'
    """
    return 'lib/lib' + lib + '.a'

def needs(lib):
    """Convert 'name' to 'LIBNAME_A'
    """
    name = os.path.basename(target(lib))
    return NON_WORD_CHAR_PATTERN.sub('_', name.upper())

if __name__ == '__main__':
    main()

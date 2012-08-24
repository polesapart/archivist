#!/bin/sh

# Copyright (C) 2004, 2005, 2007, 2009 Simon Josefsson
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FILES="$@"
FILES=${FILES:-$THREADSAFETY_FILES}

if test -z "$FILES"; then
    echo "Usage: $0 [FILE...]"
    exit 1
fi

# http://www.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_01
UNSAFE=""
UNSAFE="$UNSAFE asctime"
UNSAFE="$UNSAFE basename"
UNSAFE="$UNSAFE catgets"
UNSAFE="$UNSAFE crypt"
UNSAFE="$UNSAFE ctime"
UNSAFE="$UNSAFE dbm_clearerr"
UNSAFE="$UNSAFE dbm_close"
UNSAFE="$UNSAFE dbm_delete"
UNSAFE="$UNSAFE dbm_error"
UNSAFE="$UNSAFE dbm_fetch"
UNSAFE="$UNSAFE dbm_firstkey"
UNSAFE="$UNSAFE dbm_nextkey"
UNSAFE="$UNSAFE dbm_open"
UNSAFE="$UNSAFE dbm_store"
UNSAFE="$UNSAFE dirname"
UNSAFE="$UNSAFE dlerror"
UNSAFE="$UNSAFE drand48"
UNSAFE="$UNSAFE encrypt"
UNSAFE="$UNSAFE endgrent"
UNSAFE="$UNSAFE endpwent"
UNSAFE="$UNSAFE endutxent"
UNSAFE="$UNSAFE ftw"
UNSAFE="$UNSAFE getc_unlocked"
UNSAFE="$UNSAFE getchar_unlocked"
UNSAFE="$UNSAFE getdate"
UNSAFE="$UNSAFE getenv"
UNSAFE="$UNSAFE getgrent"
UNSAFE="$UNSAFE getgrgid"
UNSAFE="$UNSAFE getgrnam"
UNSAFE="$UNSAFE gethostent"
UNSAFE="$UNSAFE getlogin"
UNSAFE="$UNSAFE getnetbyaddr"
UNSAFE="$UNSAFE getnetbyname"
UNSAFE="$UNSAFE getnetent"
UNSAFE="$UNSAFE getopt"
UNSAFE="$UNSAFE getprotobyname"
UNSAFE="$UNSAFE getprotobynumber"
UNSAFE="$UNSAFE getprotoent"
UNSAFE="$UNSAFE getpwent"
UNSAFE="$UNSAFE getpwnam"
UNSAFE="$UNSAFE getpwuid"
UNSAFE="$UNSAFE getservbyname"
UNSAFE="$UNSAFE getservbyport"
UNSAFE="$UNSAFE getservent"
UNSAFE="$UNSAFE getutxent"
UNSAFE="$UNSAFE getutxid"
UNSAFE="$UNSAFE getutxline"
UNSAFE="$UNSAFE gmtime"
UNSAFE="$UNSAFE hcreate"
UNSAFE="$UNSAFE hdestroy"
UNSAFE="$UNSAFE hsearch"
UNSAFE="$UNSAFE inet_ntoa"
UNSAFE="$UNSAFE l64a"
UNSAFE="$UNSAFE lgamma"
UNSAFE="$UNSAFE lgammaf"
UNSAFE="$UNSAFE lgammal"
UNSAFE="$UNSAFE localeconv"
UNSAFE="$UNSAFE localtime"
UNSAFE="$UNSAFE lrand48"
UNSAFE="$UNSAFE mrand48"
UNSAFE="$UNSAFE nftw"
UNSAFE="$UNSAFE nl_langinfo"
UNSAFE="$UNSAFE ptsname"
UNSAFE="$UNSAFE putc_unlocked"
UNSAFE="$UNSAFE putchar_unlocked"
UNSAFE="$UNSAFE putenv"
UNSAFE="$UNSAFE pututxline"
UNSAFE="$UNSAFE rand"
UNSAFE="$UNSAFE readdir"
UNSAFE="$UNSAFE setenv"
UNSAFE="$UNSAFE setgrent"
UNSAFE="$UNSAFE setkey"
UNSAFE="$UNSAFE setpwent"
UNSAFE="$UNSAFE setutxent"
UNSAFE="$UNSAFE strerror"
UNSAFE="$UNSAFE strsignal"
UNSAFE="$UNSAFE strtok"
UNSAFE="$UNSAFE system"
UNSAFE="$UNSAFE ttyname"
UNSAFE="$UNSAFE unsetenv"
UNSAFE="$UNSAFE wcstombs"
UNSAFE="$UNSAFE wctomb"

# Functions mentioned on
# http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html
# but not in list above, i.e., legacy functions removed between issue 6 and 7.
UNSAFE="$UNSAFE ecvt"
UNSAFE="$UNSAFE fcvt"
UNSAFE="$UNSAFE gcvt"
UNSAFE="$UNSAFE gethostbyaddr"
UNSAFE="$UNSAFE gethostbyname"

set -- $UNSAFE
cmd="-e [^_0-9a-z]($1"
shift
while test "$1"; do
    cmd="${cmd}|$1"
    shift
done
cmd="${cmd})[^_0-9a-z]*\("

if egrep $cmd $FILES; then
    exit 1
fi

exit 0


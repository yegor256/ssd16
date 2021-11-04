# (The MIT License)
#
# Copyright (c) 2021 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

SHELL := /bin/bash

.SHELLFLAGS = -e -o pipefail -c
.ONESHELL:

DIRS := $(wildcard [0-9][0-9]-*/.) syllabus

all: latexmk package

latexmk:
	for d in $(DIRS); do
		cd $${d} && latexmk -pdf && cd ..
	done

lacheck:
	for d in $(DIRS); do
		cd $${d} && lacheck *.tex && cd ..
	done

package: latexmk
	mkdir -p package
	for d in $(DIRS); do
		cp $${d}/*.pdf package
	done
	cd package
	rm -rf index.html
	for f in $$(ls *.pdf); do
		echo "<p><a href='$${f}'>$${f}</a></p>" >> index.html
	done

copy:
	for d in $(DIRS); do
		cp .latexmkrc $${d}
		cp .texsc $${d}
		cp .texqc $${d}
	done

clean:
	for d in $(DIRS); do
		cd $${d}
		latexmk -C
		rm -rf _minted*
		cd ..
	done

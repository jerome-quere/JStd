#
# Copyright 2012 Jerome Quere < contact@jeromequere.com >.
#
# This file is part of JStl.
#
# JStl is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# JStl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with JStl.If not, see <http://www.gnu.org/licenses/>.
#

NAME		=	dist/jstl.js
SRC_FOLDER	=	src/jstl
SRC_FILES	=	$(SRC_FOLDER)/_jstl.coffee		\
			$(SRC_FOLDER)/Exceptions.coffee		\
			$(SRC_FOLDER)/Iterator.coffee		\
			$(SRC_FOLDER)/Numeric.coffee		\
			$(SRC_FOLDER)/Algorithm.coffee		\
			$(SRC_FOLDER)/Vector.coffee

TESTS_FOLDER	=	src/tests
TESTS_FILES	=	$(TESTS_FOLDER)/vector_tests.coffee	\
			$(TESTS_FOLDER)/iterator_tests.coffee

all:
	coffee -c -j $(NAME) $(SRC_FILES)

compile:
	coffee -c $(SRC_FILES)

watch:
	coffee -w -c -j $(NAME) $(SRC_FILES)

test:
	mocha --compilers 'coffee:coffee-script' $(TESTS_FILES)

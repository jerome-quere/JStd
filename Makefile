#
# Copyright 2012 Jerome Quere < contact@jeromequere.com >.
#
# This file is part of Jstd.
#
# Jstd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Jstd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with Jstd.If not, see <http://www.gnu.org/licenses/>.
#

NAME		=	dist/jstd.js
SRC_FOLDER	=	src/jstd
SRC_FILES	=	$(SRC_FOLDER)/_jstd.coffee		\
			$(SRC_FOLDER)/Exceptions.coffee		\
			$(SRC_FOLDER)/Iterator.coffee		\
			$(SRC_FOLDER)/Numeric.coffee		\
			$(SRC_FOLDER)/Algorithm.coffee		\
			$(SRC_FOLDER)/Utility.coffee		\
			$(SRC_FOLDER)/Vector.coffee		\
			$(SRC_FOLDER)/List.coffee		\
			$(SRC_FOLDER)/Stack.coffee		\
			$(SRC_FOLDER)/Queue.coffee		\
			$(SRC_FOLDER)/Map.coffee

TESTS_FOLDER	=	src/tests
TESTS_FILES	=	$(TESTS_FOLDER)/algorithm_tests.coffee	\
			$(TESTS_FOLDER)/numeric_tests.coffee	\
			$(TESTS_FOLDER)/iterator_tests.coffee	\
			$(TESTS_FOLDER)/utility_tests.coffee	\
			$(TESTS_FOLDER)/vector_tests.coffee	\
			$(TESTS_FOLDER)/list_tests.coffee	\
			$(TESTS_FOLDER)/stack_tests.coffee	\
			$(TESTS_FOLDER)/queue_tests.coffee	\
			$(TESTS_FOLDER)/map_tests.coffee

all:
	@coffee -c -j $(NAME) $(SRC_FILES)

compile:
	@coffee -c $(SRC_FILES)

watch:
	@coffee -w -c -j $(NAME) $(SRC_FILES)

test:
	@mocha --compilers 'coffee:coffee-script/register' $(TESTS_FILES)

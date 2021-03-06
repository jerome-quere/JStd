##
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
#
# You should have received a copy of the GNU General Public License
# along with Jstd.If not, see <http://www.gnu.org/licenses/>.
##

class jstd.exception
	constructor: () ->
		@message = @what()
	what: () -> "exception"

class jstd.not_implemented extends jstd.exception
	constructor: (@functionName) ->
	what: () -> "Method: #{@functionName} not implemented";

class jstd.logic_error extends jstd.exception
	what: () -> "logic_error"

class jstd.out_of_range extends jstd.logic_error
	what: ()-> "out_of_range"
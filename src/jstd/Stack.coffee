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

class jstd.stack

	constructor: (container) ->
		if (!container?)
			container = jstd.list
		@container = new [container][0]()

	clone: () ->
		s = new jstd.stack()
		s.container = @container.clone()
		return (s)

	copy: (obj) ->
		s = obj.clone()
		@swap(s)

	swap: (obj) ->
		[@container, obj.container] = [obj.container, @container]

	empty: () ->
		@container.size() == 0

	size:  () ->
		@container.size()

	top:   () ->
		@container.back()

	push:  (value) ->
		@container.push_back(value)

	pop:   () ->
		@container.pop_back()

	@container

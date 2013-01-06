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

class jstd.map
	constructor: () ->
		@list = new jstd.list()

	clone: () ->
		m = new jstd.map()
		m.list = @list.clone()
		return m

	swap: (obj) ->
		[@list, obj.list] = [obj.list, @list]

	find: (key) ->
		return jstd.find_if @begin(), @end(), (pair)->
			return (jstd.eq(pair.first,key))

	size: () ->
		return @list.size()

	empty: () ->
		return @list.empty()

	clear: () ->
		@list.clear()

	set: (key, value) ->
		it = @find(key);
		if (it.neq @end())
			it.get().second = value;
		else
			@insert(jstd.make_pair(key, value))

	get: (key) ->
		return(@find(key).get().second);

	begin: () ->
		new @iterator(@list.begin());

	end: () ->
		new @iterator(@list.end());

	rbegin: () ->
		new jstd.reverse_iterator(@end());

	rend:	() ->
		new jstd.reverse_iterator(@begin());

	insert: (pair) ->
		it = @find(pair);
		if (it.eq @end())
			lit = @list.begin()
			lend = @list.end()
			while (lit.neq lend)
				if (jstd.lt(pair.first, lit.get().first))
					return @list.insert(lit, pair);
				lit.next()
			return @list.push_back(pair)
		it.set(pair);
		return it;

	insertRange: (first, last) ->
		jstd.for_each(first, last, (pair) => @insert(pair))

	erase: (key) ->
		it = @find(key);
		if (it.neq @end())
			@list.erase(it.listIt);

	class map::iterator extends jstd.iterator

		constructor: (@listIt) ->
			super jstd.iterator.TYPE_BIDIRECTIONAL

		clone: () ->
			return new iterator(@listIt.clone())

		copy: (obj) ->
			i = obj.clone()
			@swap(i)

		swap: (obj) ->
			[@listIt, obj.listIt] = [obj.listIt, @listIt]

		eq: (obj) ->
			@listIt.eq obj.listIt;

		neq: (obj) ->
			!@eq(obj)

		next: () ->
			@listIt.next()

		prev: () ->
			@listIt.prev()

		get: () ->
			return @listIt.get()

		set: (pair) ->
			@listIt.set(pair)
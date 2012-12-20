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

jstd.for_each = (first, last, f) ->
	while first.neq last
		f first.get()
		first.next()
	return f;

jstd.min = (obj1, obj2) ->
	if (typeof obj1 == "number" || typeof obj1 == "bool" || typeof obj1 == "string" || obj1 instanceof Array)
		return if !(obj2<obj1) then obj1 else obj2;
	if !(obj2.lt(obj1)) then obj1 else obj2;

jstd.max = (obj1, obj2) ->
	if (typeof obj1 == "number" || typeof obj1 == "bool" || typeof obj1 == "string" || obj1 instanceof Array)
		return if (obj1<obj2) then obj2 else obj1;
	if (obj1.lt(obj2)) then obj2 else obj1;

jstd.equal = (obj1, obj2) ->
	if (typeof obj1 == "number" || typeof obj1 == "bool" || typeof obj1 == "string" || obj1 instanceof Array)
		return obj1 == obj2
	return obj1.eq obj2

jstd.copy = (first, last, it) ->
	first = first.clone()
	it = it.clone()
	while first.neq last
		it.set(first.get());
		first.next()
		it.next()
	return it;

jstd.fill_n = (first, n, v) ->
	first = first.clone()
	i = 0
	while i < n
		first.set(v)
		first.next()
		i++;

jstd.find = (first, last, value) ->
	first = first.clone()
	while (first.neq last)
		if (jstd.equal(first.get(), value))
			return (first)
		first.next()
	return last

jstd.remove_if = (first, last, pred) ->
	first = first.clone()
	result = first.clone()
	while (first.neq last)
		if (!pred(first.get()))
			result.set(first.get());
			result.next()
		first.next()
	return result;

jstd.toArray = (first, last) ->
	array = new Array()
	jstd.for_each first, last, (e)->
		array.push(e)
	return (array)
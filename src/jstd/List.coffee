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

class jstd.list
	constructor: () ->
		@size_	= 0
		node = new @node()
		@front_ = node
		@back_	= node
		@nextNodeIdx = 0;

	clone: () ->
		o = new list()
		o.insertRange(o.begin(), @begin(), @end());
		return (o)
	copy: (obj) -> @swap(obj.clone())
	empty: () -> @size_ == 0
	size: () -> @size_
	resize: (size) ->
		if (size < 0)
			size = 0;
		if size < @size()
			@eraseRange(jstd.advance(@begin(), size), @end())
		while @size() < size
			@push_back(null)

	front: ()-> @front_.value
	back: () -> @back_.prev.value
	begin: () -> new @iterator(this, @front_);
	end: () -> new @iterator(this, @back_);
	rbegin: () -> new jstd.reverse_iterator(@end());
	rend:	() -> new jstd.reverse_iterator(@begin());
	clear: () ->
		node = new @node()
		@front_ = node
		@back_ = node
		@size_ = 0

	swap: (obj) ->
		[@front_, obj.front] = [obj.front, @front_]
		[@back_, obj.back] = [obj.back, @back_]
		[@size_, obj.size_] = [obj.size_, @size_]

	push_front: (value) ->
		node = new @node()
		[node.value, node.prev, node.next, node.idx] = [value, null, @front_, ++@nextNodeIdx]
		@size_++
		@front_ = node;

	push_back: (value) ->
		node = new @node()
		[node.value, node.prev, node.next, node.idx] = [value, @back_.prev, @back_,  ++@nextNodeIdx]
		@size_++
		@back_.prev = node
		if (node.prev)
			node.prev.next = node
		if (@front_.idx == -1) then @front_ = node

	pop_front: () ->
		@front_ = @front_.next;
		@size_--

	pop_back: () ->
		@back_.prev = @back_.prev.prev;
		if (@back_.prev)
			@back_.prev.next = @back
		@size_--

	insert: (it, value) ->
		if (it.eq @end())
			@push_back(value)
			return (it)
		else if (it.eq @begin())
			@push_front(value)
		else
			node = new @node()
			[node.value, node.prev, node.next] = [value, it.node.prev, it.node]
			[it.node.prev.next, it.node.prev] = [node, node]
			@size_++
		return (it.next())

	insertRange: (it, first, last) ->
		jstd.copy(first, last, jstd.inserter(this, it))

	erase: (it) ->
		if (it.eq @end()) then @pop_back(value)
		else if (it.eq @begin()) then @pop_front(value)
		else
			[it.node.prev.next, it.node.next.prev] = [it.node.next, it.node.prev]
			@size_--
		return (it.next())

	eraseRange: (first, last) ->
		if (first.eq last)
			return;
		nbElem = jstd.distance(first, last)
		if (first.eq @begin()) then @front_ = last.node
		if (last.eq @end()) then @back_.prev = first.node.prev
		if (last.neq @end())
			last.node.prev = first.prev
		if (last.neq @begin())
			first.prev.next = last.node
		@size_ = @size_ - nbElem;

	toString: () ->
		str = ""
		jstd.for_each @begin(), @end(), (i)->
			if str != "" then str = "#{str}, "
			str = "#{str}#{i}"
		return "{#{str}}"

	toArray: () -> jstd.toArray(@begin(), @last())


	class list::node
		constructor: () ->
			@prev = null
			@next = null
			@value = null
			@idx = -1

	class list::iterator extends jstd.iterator

		constructor: (@list, @node) ->
			super jstd.iterator.TYPE_BIDIRECTIONAL

		clone: () -> new iterator(@list, @node)
		copy: (obj) -> @swap(obj.clone())
		swap: (obj) ->
			[@list, obj.list] = [obj.list, @list]
			[@node, obj.node] = [obj.node, @node]
		get: () -> @node.value
		set: (value) -> @node.value = value
		next: () ->
			@node = @node.next
			return (this)
		prev: () ->
			@node = @node.prev
			return (this)
		eq: (it) -> @node.idx == it.node.idx;
		neq: (it) -> !@eq(it)

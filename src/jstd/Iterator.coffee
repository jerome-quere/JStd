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

class jstd.iterator

        @TYPE_INPUT = 1
        @TYPE_OUTPUT = 2
        @TYPE_FORWARD = 3
        @TYPE_BIDIRECTIONAL = 4
        @TYPE_RANDOM = 5

        constructor: (@type) ->
        getType: () -> @type


jstd.advance = (i, n) ->
        if (i.getType() == jstd.iterator.TYPE_RANDOM)
                i.copy(i.add(n))
                return i
        p = 0
        while p < n
                i.next()
                p++
        return i

jstd.distance = (first, second) ->
        if (first.getType() == jstd.iterator.TYPE_RANDOM)
                return (Math.abs(second.value() - first.value()))
        first = first.clone()
        i = 0
        while (first.neq second)
                first.next()
                ++i
        return i

class jstd.reverse_iterator extends jstd.iterator
        constructor: (baseIt) ->
                super baseIt.getType()
                @baseIt = baseIt.clone()

        clone: () -> new reverse_iterator(@baseIt)

        copy: (obj) -> @swap(obj.clone())

        swap: (obj) ->
                [@baseIt, obj.baseIt] = [obj.baseIt, @baseIt]

        base: () -> @baseIt
        get:  () -> @baseIt.clone().prev().get();

        set:  (value) ->
                @baseIt.sub(1).set(value)
        next: () ->
                @baseIt.prev();
                return this
        prev: () ->
                @baseIt.next();
                return this
        eq:   (it) -> @baseIt.eq it.baseIt
        neq:  (it) -> !@eq(it)


jstd.inserter =  (container, it) ->
        new jstd.insert_iterator(container, it)

jstd.back_inserter =  (container) ->
        new jstd.back_insert_iterator(container)

jstd.front_inserter =  (container) ->
        new jstd.front_insert_iterator(container)


class jstd.insert_iterator  extends jstd.iterator
        constructor: (@container, @it) ->
                super jstd.iterator.TYPE_OUTPUT

        clone: () -> new insert_iterator(@container, @it);
        copy: (obj) -> @swap(obj.clone())
        get: () ->
        set: (value) ->
                @it = @container.insert(@it, value)
        next: () ->

class jstd.back_insert_iterator extends jstd.iterator
        constructor: (@container) ->
                super jstd.iterator.TYPE_OUTPUT

        clone: () -> new back_insert_iterator(@container);
        copy: (obj) -> @swap(obj.clone())
        get: () ->
        set: (value) -> @container.push_back(value)
        next: () ->

class jstd.front_insert_iterator extends jstd.iterator
        constructor: (@container) ->
                super jstd.iterator.TYPE_OUTPUT

        clone: () -> new front_insert_iterator(@container);
        copy: (obj) -> @swap(obj.clone())
        get: () ->
        set: (value) -> @container.push_front(value)
        next: () ->

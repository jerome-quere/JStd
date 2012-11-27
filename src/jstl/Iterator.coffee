##
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
#
# You should have received a copy of the GNU General Public License
# along with JStl.If not, see <http://www.gnu.org/licenses/>.
##

class jstl.iterator

        @TYPE_INPUT = 1
        @TYPE_OUTPUT = 2
        @TYPE_FORWARD = 3
        @TYPE_BIDIRECTIONAL = 4
        @TYPE_RANDOM = 5

        constructor: (@type) ->
        getType: () -> @type


jstl.advance = (i, n) ->
        if (i.getType() == jstl.iterator.TYPE_RANDOM)
                i.copy(i.add(n))
                return
        for i in [0..n]
                i.next()

jstl.distance = (first, second) ->
        if (first.getType() == jstl.iterator.TYPE_RANDOM)
                return (Math.abs(second.value() - first.value()))
        first = first.clone()
        i = 0
        while (first.neq second)
                first.next()
                ++i
        return i

class jstl.reverse_iterator extends jstl.iterator
        constructor: (baseIt) ->
                super baseIt.getType()
                @baseIt = baseIt.clone()

        clone: () -> new reverse_iterator(@baseIt)

        copy: (obj) ->
                i = obj.clone();
                @swap(i)

        swap: (obj) ->
                [@baseIt, obj.baseIt] = [obj.baseIt, @baseIt]

        base: () -> @baseIt
        get:  () ->
                @baseIt.sub(1).get()
        set:  (value) ->
                @baseIt.sub(1).set(value)
        value: () -> @baseIt.sub(1).value();
        next: () -> @baseIt.prev();
        prev: () -> @baseIt.next();
        eq:   (it) -> @baseIt.eq it.baseIt
        lt:   (it) -> @baseIt.lt it.baseIt
        neq:  (it) -> !@eq(it)
        lte:  (it) -> @lt(it) || @eq(it)
        gt:   (it) -> !@lte(it)
        gte:  (it) -> @gt(it) || @eq(it)
        add:  (n)  -> new reverse_iterator(@baseIt.sub(n));
        sub:  (n)  -> new reverse_iterator(@baseIt.add(n));

jstl.inserter =  (container, it) ->
        new jstl.insert_iterator(container, it)

jstl.back_inserter =  (container) ->
        new jstl.back_insert_iterator(container)

jstl.front_inserter =  (container) ->
        new jstl.front_insert_iterator(container)


class jstl.insert_iterator  extends jstl.iterator
        constructor: (@container, @it) ->
                super jstl.iterator.TYPE_OUTPUT

        clone: () -> new insert_iterator(@container);
        copy: (obj) -> @swap(obj.clone())
        get: () ->
        set: (value) ->
                @it = @container.insert(@it, value)
        next: () ->

class jstl.back_insert_iterator extends jstl.iterator
        constructor: (@container) ->
                super jstl.iterator.TYPE_OUTPUT

        clone: () -> new back_insert_iterator(@container);
        copy: (obj) -> @swap(obj.clone())
        get: () ->
        set: (value) -> @container.push_back(value)
        next: () ->

class jstl.front_insert_iterator extends jstl.iterator
        constructor: (@container) ->
                super jstl.iterator.TYPE_OUTPUT

        clone: () -> new front_insert_iterator(@container);
        copy: (obj) -> @swap(obj.clone())
        get: () ->
        set: (value) -> @container.push_front(value)
        next: () ->

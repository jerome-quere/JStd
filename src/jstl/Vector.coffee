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

class jstl.vector

        constructor: () -> @array = []

        clone: () ->
                v = new jstl.vector()
                v.insertRange @begin(), @end()
                return (v)

        at: (idx) ->
                if (idx < 0 || idx >= @size())
                        throw new jstl.out_of_range()
                @get(idx)

        get:   (idx) -> @array[idx]
        back:  () -> @array[@size() - 1]
        front: () -> @array[0]
        data:  () -> @array
        push_back:  (value) -> @array.push(value)
        pop_back:  (value) -> @array.pop()
        size:  () -> @array.length
        empty: () -> @size() == 0
        resize: (size) ->
                if (size < 0)
                        size = 0;
                @array.splice(size, @size());
        clear: () ->
                @resize(0);

        swap: (obj) ->
                [@array, obj.array] = [obj.array, @array]
                [@idx, obj.idx] = [obj.idx, @idx]

        begin: () -> new @iterator(this, 0);
        end:   () -> new @iterator(this, @size());
        rbegin: () -> new @riterator(this, @size() - 1);
        rend:   () -> new @riterator(this, -1);

        insert: (it, value) ->
                @array.splice(it.idx, 0, value)

        insertRange: (first, last) ->
                jstl.foreach first, last, (e) =>
                        @push_back(e)

        erase: (it) ->
                @array.splice(it.idx, 1);

        eraseRange: (first, last) ->
                if last.idx < first.idx
                        last.prev()
                        first.prev()
                @array.splice(jstl.min(first.idx, last.idx), Math.abs(first.idx - last.idx))

        class vector::iterator
                constructor: (@vector, @idx) ->

                get:  () ->
                        @vector.get(@idx)
                next: () -> @idx++;
                prev: () -> @idx--;
                eq:   (it) -> @idx == it.idx
                lt:   (it) -> @idx < it.idx
                neq:  (it) -> !@eq(it)
                lte:  (it) -> @lt(it) || @eq(it)
                gt:   (it) -> !@lte(it)
                gte:  (it) -> @gt(it) || @eq(it)
                add:  (v)  -> new iterator(@vector, @idx + v);
                sub:  (v)  -> new iterator(@vector, @idx - v);;

        class vector::riterator extends vector::iterator

                next: () -> @idx--;
                prev: () -> @idx++;
                lt:   (it) ->
                        console.log("#{@idx} > #{it.idx}")
                        @idx > it.idx
                add:  (v)  -> new riterator(@vector, @idx - v);
                sub:  (v)  -> new riterator(@vector, @idx + v);


module.exports = jstl;

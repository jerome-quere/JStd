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

class jstd.vector

        constructor: () -> @array = []

        clone: () ->
                v = new jstd.vector()
                v.insertRange @begin(), @end()
                return (v)

        copy: (obj) ->
                v = obj.clone();
                @swap(obj)

        at: (idx) ->
                if (idx < 0 || idx >= @size())
                        throw new jstd.out_of_range()
                @get(idx)

        get:   (idx) -> @array[idx]
        set:   (idx, value) -> @array[idx] = value
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
        rbegin: () -> new jstd.reverse_iterator(@end());
        rend:   () -> new jstd.reverse_iterator(@begin());

        insert: (it, value) ->
                @array.splice(it.value(), 0, value)
                return (it.add(1));

        insertRange: (it, first, last) -> jstd.copy(first, last, jstd.inserter(this, it))

        erase: (it) ->
                @array.splice(it.value(), 1);

        eraseRange: (first, last) ->
                if last.value() < first.value()
                        [first, last] = [last.base(), first.base()];
                @array.splice(first.value(), Math.abs(first.idx - last.idx))

        class vector::iterator extends jstd.iterator
                constructor: (@vector, @idx) ->
                        super jstd.iterator.TYPE_RANDOM;

                clone: () -> new iterator(@vector, @idx)

                copy: (obj) ->
                        i = obj.clone();
                        @swap(i)

                swap: (obj) ->
                        [@vector, obj.vector] = [obj.vector, @vector]
                        [@idx, obj.idx] = [obj.idx, @idx]

                get:  () ->
                        @vector.get(@idx)
                set:  (value) ->
                        @vector.set(@idx, value);
                value: () -> @idx;
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


module.exports = jstd;

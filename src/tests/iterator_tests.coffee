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

assert = require("assert")
jstl = require('../../dist/jstl.js')

describe 'iterator', () ->
        describe '#advance()', () ->
                it 'Advance iterator', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        it = v.begin();
                        jstl.advance(it, 5);
                        assert.equal(it.get(), 5)
                        #TODO Add test with non random access iterator

        describe '#distance', () ->
                it 'Return distance between iterators', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        assert.equal(jstl.distance(v.begin(), v.end()), 11)
                        assert.equal(jstl.distance(v.rbegin(), v.rend()), 11)
                        #TODO Add test with non random access iterator

        describe '#reverse_iterator', () ->
                describe '#random_iterator', () ->
                        it 'revese iterate from a random iterator', () ->
                                v = new jstl.vector()
                                for i in [0..10]
                                        v.push_back(i)
                                i = 10;
                                jstl.foreach v.rbegin(), v.rend(), (e)->
                                        assert.equal(e, i)
                                        i--;
                        #TODO Add test with bidirectional iterator
        describe '#insert_iterator', () ->
                it 'should insert in container', ()->
                        v = new jstl.vector()
                        v.push_back(0)
                        v.push_back(3)
                        it = jstl.inserter v, v.begin().add(1);
                        for i in [1..2]
                                it.set(i)
                                it.next()
                        it = v.begin();
                        for i in [0, 1, 2, 3]
                                assert.equal(it.get(), i);
                                it.next()


        describe '#back_insert_iterator', () ->
                it 'should push_back container', ()->
                        v = new jstl.vector()
                        it = jstl.back_inserter v;
                        for i in [0..5]
                                it.set(i)
                                it.next()
                        assert.equal(jstl.accumulate(v.begin(), v.end()), 1+2+3+4+5);

        describe '#front_insert_iterator', () ->
                it 'should push_front container', ()->
                        #TODO Add test with A containner that allow push front
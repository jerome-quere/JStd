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

assert = require("assert")
jstd = require('../../dist/jstd.js')

describe 'iterator', () ->
        describe '#advance()', () ->
                it 'Advance iterator', () ->
                        v = new jstd.vector()
                        for i in [0..10]
                                v.push_back(i)
                        it = v.begin();
                        jstd.advance(it, 5);
                        assert.equal(it.get(), 5)
                        #TODO Add test with non random access iterator

        describe '#distance', () ->
                it 'Return distance between iterators', () ->
                        v = new jstd.vector()
                        for i in [0..10]
                                v.push_back(i)
                        assert.equal(jstd.distance(v.begin(), v.end()), 11)
                        assert.equal(jstd.distance(v.rbegin(), v.rend()), 11)
                        #TODO Add test with non random access iterator

        describe '#reverse_iterator', () ->
                describe '#random_iterator', () ->
                        it 'revese iterate from a random iterator', () ->
                                v = new jstd.vector()
                                for i in [0..10]
                                        v.push_back(i)
                                i = 10;
                                jstd.for_each v.rbegin(), v.rend(), (e)->
                                        assert.equal(e, i)
                                        i--;
                        #TODO Add test with bidirectional iterator
        describe '#insert_iterator', () ->
                it 'should insert in container', ()->
                        v = new jstd.vector()
                        v.push_back(0)
                        v.push_back(3)
                        it = jstd.inserter v, v.begin().add(1);
                        for i in [1..2]
                                it.set(i)
                                it.next()
                        it = v.begin();
                        for i in [0, 1, 2, 3]
                                assert.equal(it.get(), i);
                                it.next()


        describe '#back_insert_iterator', () ->
                it 'should push_back container', ()->
                        v = new jstd.vector()
                        it = jstd.back_inserter v;
                        for i in [0..5]
                                it.set(i)
                                it.next()
                        assert.equal(jstd.accumulate(v.begin(), v.end()), 1+2+3+4+5);

        describe '#front_insert_iterator', () ->
                it 'should push_front container', ()->
                        #TODO Add test with A containner that allow push front
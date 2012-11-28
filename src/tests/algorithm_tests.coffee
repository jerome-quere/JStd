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

describe 'algorithm', () ->

        describe '#for_each', () ->
                it 'should applies function f to each of the elements in the range [first,last).', () ->
                        v = new jstd.vector()
                        for i in [1..5]
                                v.push_back(i);
                        i = 0;
                        jstd.for_each v.begin(), v.end(), (e) ->
                                i += e
                        assert.equal(i, 1+2+3+4+5);
        describe '#min', () ->
                it 'Returns the lesser of a and b. If both are equivalent, a is returned.', () ->
                        assert.equal(jstd.min(4, 42), 4);
                        assert.equal(jstd.min(42, 4), 4);
                        assert.equal(jstd.min(21, 21), 21);

        describe '#max', () ->
                it 'Returns the greater of a and b. If both are equivalent, a is returned.', () ->
                        assert.equal(jstd.max(4, 42), 42);
                        assert.equal(jstd.max(42, 4), 42);
                        assert.equal(jstd.max(21, 21), 21);

        describe '#copy', () ->
                it 'Copies the elements in the range [first,last) into a range beginning at result.', () ->
                        v = new jstd.vector();
                        v2 = new jstd.vector();
                        v.resize(10)
                        v2.resize(10)
                        jstd.fill_n(v.begin(), 10, 10)
                        jstd.copy(v.begin(), v.end(), v2.begin())
                        assert.equal(jstd.accumulate(v2.begin(), v2.end(), 0), 10*10)

        describe '#fill_n', () ->
                it 'Sets value to the first n elements in the sequence pointed by first.', () ->
                        v = new jstd.vector();
                        v.resize(10)
                        jstd.fill_n(v.begin(), 10, 10)
                        assert.equal(jstd.accumulate(v.begin(), v.end(), 0), 10*10)
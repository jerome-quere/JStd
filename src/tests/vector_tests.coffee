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

describe 'vector', () ->
	describe '#at()', () ->
		it 'access specified element with bounds checking ', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			for i in [0..10]
				assert.equal(v.at(i), i)
			assert.throws((()-> v.at(-1)), "out_of_range")
			assert.doesNotThrow(()-> v.at(9))
			assert.throws((()-> v.at(11)), "out_of_range")

	describe '#get()', () ->
		it 'should return the value located at the correct index', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			for i in [0..10]
				assert.equal(v.at(i), i)

	describe '#back()', () ->
		it 'should access the last element', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
				assert.equal(v.back(), i)

	describe '#front()', () ->
		it 'should access the first element ', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
				assert.equal(v.front(), 0)

	describe '#size()', () ->
		it 'should returns the number of elements ', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
				assert.equal(v.size(), i + 1)

	describe '#empty()', () ->
		it 'should checks whether the container is empty', () ->
			v = new jstd.vector()
			assert.equal(v.empty(), true)
			v.push_back(1)
			assert.equal(v.empty(), false)
			v.pop_back()
			assert.equal(v.empty(), true)

	describe '#resize', () ->
		it 'should changes the number of elements stored', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			v.resize(5)
			assert.equal(v.size(), 5)
			v.resize(-1)
			assert.equal(v.size(), 0)
			v.resize(10)
			assert.equal(v.size(), 10)


	describe '#clear', () ->
		it 'should clears the contents', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			v.clear()
			assert.equal(v.empty(), true)

	describe '#iterator', () ->
		it 'should allow to iterate throught the vector', ()->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			i = 0;
			jstd.for_each v.begin(), v.end(), (e) ->
				assert.equal(e, i)
				i++

	describe '#riterator', () ->
		it 'should allow to iterate throught the vector in reverse order', ()->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			i = 10;
			jstd.for_each v.rbegin(), v.rend(), (e) ->
				assert.equal(e, i)
				i--

	describe '#clone', () ->
		it 'should clone a vector', ()->
			v = new jstd.vector()
			for i in [1..10]
				v.push_back(i)
			v2 = v.clone()
			assert.equal(v2.size(), 10);
			v.push_back(11)
			assert.equal(v2.size(), 10);

	describe '#swap', () ->
		it 'should swap the vector content', () ->
			v = new jstd.vector()
			for i in [1..10]
				v.push_back(i)
			v2 = new jstd.vector()
			for i in [1..20]
				v2.push_back(i)
			v.swap v2
			assert.equal(v.size(), 20)
			assert.equal(v2.size(), 10)

	describe '#erase', () ->
		it 'should erases elements ', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			v.erase(v.begin().add(1))
			assert.equal(v.get(1), 2)
			v.eraseRange(v.begin(), v.end().sub(1));
			assert.equal(jstd.accumulate(v.begin(), v.end()), 10)
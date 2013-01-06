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

describe 'map', () ->

	describe '#get', () ->
		it 'should return the value associated with the key', () ->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i + 100)
			for i in [0..10]
				assert.equal(m.get(i), i+100)

	describe '#size', () ->
		it 'should returns the number of elements ', () ->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i + 100)
				assert.equal(m.size(), i + 1)

	describe '#empty', () ->
		it 'should checks whether the container is empty', () ->
			m = new jstd.map()
			assert.equal(m.empty(), true)
			m.set(1, 101)
			assert.equal(m.empty(), false)
			m.erase(1)
			assert.equal(m.empty(), true)

	describe '#find', () ->
		it 'should find an element in the map and return an iterator pointing to it', () ->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i + 100)

			for i in [0..10]
				it = m.find(i);
				assert.equal(it.get().first, i)
				assert.equal(it.get().second, i+ 100)
			assert(m.end().eq m.find(11))

	describe '#set', () ->
		it 'should set the value associated with a selected key', () ->
			m = new jstd.map()
			m.set(0, 100);
			m.set(1, 101);
			assert.equal(m.get(0), 100)
			assert.equal(m.get(1), 101)
			assert(m.end().eq m.find(2))
			m.set(0, 300)
			assert.equal(m.get(0), 300)



	describe '#clear', () ->
		it 'should clears the contents', () ->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i + 100)
			m.clear()
			assert.equal(m.empty(), true)

	describe '#iterator', () ->
		it 'should allow to iterate throught the map', ()->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i+ 100)
			i = 0;
			jstd.for_each m.begin(), m.end(), (pair) ->
				assert.equal(pair.first + 100, pair.second)
				assert.equal(pair.first, i);
				i++

	describe '#riterator', () ->
		it 'should allow to iterate throught the map in reverse order', ()->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i + 100)
			i = 10;
			jstd.for_each m.rbegin(), m.rend(), (pair) ->
				assert.equal(pair.first + 100, pair.second)
				assert.equal(pair.first, i)
				i--

	describe '#clone', () ->
		it 'should clone a map', ()->
			m = new jstd.map()
			for i in [1..10]
				m.set(i, 100 + i)
			m2 = m.clone()
			assert.equal(m2.size(), 10);
			m.set(11, 111)
			assert.equal(m2.size(), 10);

	describe '#swap', () ->
		it 'should swap the vector content', () ->
			m = new jstd.map()
			for i in [1..10]
				m.set(i, 100 + i)
			m2 = new jstd.map()
			for i in [1..20]
				m2.set(i, 100 + i)
			m.swap m2
			assert.equal(m.size(), 20)
			assert.equal(m2.size(), 10)

	describe '#erase', () ->
		it 'should erases elements ', () ->
			v = new jstd.vector()
			for i in [0..10]
				v.push_back(i)
			v.erase(v.begin().add(1))
			assert.equal(v.get(1), 2)
			v.eraseRange(v.begin(), v.end().sub(1));
			assert.equal(jstd.accumulate(v.begin(), v.end()), 10)

	describe '#toString', () ->
		it 'should return a string representation of the map', () ->
			m = new jstd.map()
			for i in [0..10]
				m.set(i, i + 100)

			str = m.toString();
			assert.equal("{'0':'100', '1':'101', '2':'102', '3':'103', '4':'104', '5':'105', '6':'106', '7':'107', '8':'108', '9':'109', '10':'110'}", str)

	describe '#toArray', () ->
		it 'should return an aray with all the map elements', () ->
			m = new jstd.map()
			ref = []
			for i in [0..10]
				pair = jstd.make_pair(i, i+100)
				m.insert(pair)
				ref.push(pair)

			tab = m.toArray();
			assert.equal(tab.toString(), ref.toString())
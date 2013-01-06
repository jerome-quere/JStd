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

describe 'list', () ->
	describe '#back()', () ->
		it 'should access the last element', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
				assert.equal(l.back(), i)

	describe '#front()', () ->
		it 'should access the first element ', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
				assert.equal(l.front(), 0)

	describe '#size()', () ->
		it 'should returns the number of elements ', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
				assert.equal(l.size(), i + 1)

	describe '#empty()', () ->
		it 'should checks whether the container is empty', () ->
			l = new jstd.list()
			assert.equal(l.empty(), true)
			l.push_back(1)
			assert.equal(l.empty(), false)
			l.pop_back()
			assert.equal(l.empty(), true)

	describe '#resize', () ->
		it 'should changes the number of elements stored', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
			l.resize(5)
			assert.equal(l.size(), 5)
			l.resize(-1)
			assert.equal(l.size(), 0)
			l.resize(10)
			assert.equal(l.size(), 10)

	describe '#clear', () ->
		it 'should clears the contents', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
			l.clear()
			assert.equal(l.empty(), true)

	describe '#iterator', () ->
		it 'should allow to iterate throught the list', ()->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
			i = 0;
			jstd.for_each l.begin(), l.end(), (e) ->
				assert.equal(e, i)
				i++

	describe '#riterator', () ->
		it 'should allow to iterate throught the list in relerse order', ()->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
			i = 10;
			jstd.for_each l.rbegin(), l.rend(), (e) ->
				assert.equal(e, i)
				i--

	describe '#clone', () ->
		it 'should clone a list', ()->
			l = new jstd.list()
			for i in [1..10]
				l.push_back(i)
			l2 = l.clone()
			assert.equal(l2.size(), 10);
			l.push_back(11)
			assert.equal(l2.size(), 10);

	describe '#swap', () ->
		it 'should swap the list content', () ->
			l = new jstd.list()
			for i in [1..10]
				l.push_back(i)
			l2 = new jstd.list()
			for i in [1..20]
				l2.push_back(i)
			l.swap l2
			assert.equal(l.size(), 20)
			assert.equal(l2.size(), 10)

	describe '#erase', () ->
		it 'should erases elements ', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)
			l.erase(l.begin().next())
			assert.equal(l.begin().next().get(), 2)
			l.eraseRange(l.begin(), l.end().prev());
			assert.equal(jstd.accumulate(l.begin(), l.end()), 10)

	describe '#toString', () ->
		it 'should return a string representation of the list', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)

			str = l.toString();
			assert.equal("{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}", str)

	describe '#toArray', () ->
		it 'should return an aray with all the list elements', () ->
			l = new jstd.list()
			for i in [0..10]
				l.push_back(i)

			tab = l.toArray();
			assert.equal(tab.toString(), [0..10].toString());

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

describe 'queue', () ->

	describe '#clone', () ->
		it 'should clone a queue', ()->
			q = new jstd.queue()
			for i in [1..10]
				q.push(i)
			q2 = q.clone()
			assert.equal(q2.size(), 10);
			for i in [1..10]
				assert.equal(q.front(), q2.front())
				assert.equal(q.front(), i)
				q.pop()
				q2.pop()

	describe '#copy', () ->
		it 'should copy a queue into another queue', ()->
			q = new jstd.queue()
			q2 = new jstd.queue()
			for i in [1..10]
				q.push(i)
				q2.push(i + 10)
			q2.copy(q)
			assert.equal(q2.size(), 10);
			for i in [1..10]
				assert.equal(q.front(), q2.front())
				assert.equal(q.front(), i)
				q.pop()
				q2.pop()

	describe '#push', () ->
		it 'should add element on the top of the queue', () ->
			q = new jstd.queue()
			for i in [0..10]
				q.push(i)
				assert.equal(q.front(), 0)

	describe '#pop', () ->
		it 'should remove the queue top element', () ->
			q = new jstd.queue()
			for i in [0..10]
				q.push(i)
			for i in [0..10]
				assert.equal(q.front(), i);
				q.pop();

	describe '#empty', () ->
		it 'should return true if the queue is empty', () ->
			q = new jstd.queue()
			assert.equal(q.empty(), true)
			q.push(1)
			assert.equal(q.empty(), false)
			q.pop()
			assert.equal(q.empty(), true)

	describe '#swap', () ->
		it 'should swap the queue content', () ->
			q = new jstd.queue()
			for i in [1..10]
				q.push(i)
			q2 = new jstd.queue()
			for i in [1..20]
				q2.push(i)
			q.swap q2
			assert.equal(q.size(), 20)
			assert.equal(q2.size(), 10)


	describe '#size', () ->
		it 'should returns the number of elements in the queue', () ->
			q = new jstd.queue()
			for i in [0..10]
				q.push(i)
				assert.equal(q.size(), i + 1)
			for i in [10..0]
				q.pop()
				assert.equal(q.size(), i)

	describe '#front', () ->
		it 'should return the element on the front of the queue', () ->
			q = new jstd.queue()
			for i in [0..10]
				q.push(i)
				assert.equal(q.front(), 0)

	describe '#back', () ->
		it 'should return the element on the back of the queue', () ->
			q = new jstd.queue()
			for i in [0..10]
				q.push(i)
				assert.equal(q.back(), i)

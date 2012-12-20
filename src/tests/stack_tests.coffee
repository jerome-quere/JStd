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

describe 'stack', () ->

	describe '#clone', () ->
		it 'should clone a stack', ()->
			s = new jstd.stack()
			for i in [1..10]
				s.push(i)
			s2 = s.clone()
			assert.equal(s2.size(), 10);
			for i in [10..1]
				assert.equal(s.top(), s2.top())
				assert.equal(s.top(), i)
				s.pop()
				s2.pop()

	describe '#copy', () ->
		it 'should copy a stack into another stack', ()->
			s = new jstd.stack()
			s2 = new jstd.stack()
			for i in [1..10]
				s.push(i)
				s2.push(i + 10)
			s2.copy(s)
			assert.equal(s2.size(), 10);
			for i in [10..1]
				assert.equal(s.top(), s2.top())
				assert.equal(s.top(), i)
				s.pop()
				s2.pop()

	describe '#push', () ->
		it 'should add element on the top of the stack', () ->
			s = new jstd.stack()
			for i in [0..10]
				s.push(i)
				assert.equal(s.top(), i)

	describe '#pop', () ->
		it 'should remove the stack top element', () ->
			s = new jstd.stack()
			for i in [0..10]
				s.push(i)
			for i in [10..0]
				assert.equal(s.top(), i);
				s.pop();

	describe '#empty', () ->
		it 'should return true if the stack is empty', () ->
			s = new jstd.stack()
			assert.equal(s.empty(), true)
			s.push(1)
			assert.equal(s.empty(), false)
			s.pop()
			assert.equal(s.empty(), true)

	describe '#swap', () ->
		it 'should swap the stack content', () ->
			s = new jstd.stack()
			for i in [1..10]
				s.push(i)
			s2 = new jstd.stack()
			for i in [1..20]
				s2.push(i)
			s.swap s2
			assert.equal(s.size(), 20)
			assert.equal(s2.size(), 10)


	describe '#size', () ->
		it 'should returns the number of elements in the stack', () ->
			s = new jstd.stack()
			for i in [0..10]
				s.push(i)
				assert.equal(s.size(), i + 1)
			for i in [10..0]
				s.pop()
				assert.equal(s.size(), i)

	describe '#top', () ->
		it 'should return the element on the top of the stack', () ->
			s = new jstd.stack()
			for i in [0..10]
				s.push(i)
				assert.equal(s.top(), i)

assert = require("assert")
should = require('should')
jstl = require('../../dist/jstl.js')


describe 'vector', () ->
        describe '#at()', () ->
                it 'access specified element with bounds checking ', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        for i in [0..10]
                                assert.equal(v.at(i), i)
                        (()-> v.at(-1)).should.throw('out_of_range')
                        (()-> v.at(9)).should.not.throw()
                        (()-> v.at(10)).should.not.throw('out_of_range')

        describe '#get()', () ->
                it 'should return the value located at the correct index', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        for i in [0..10]
                                assert.equal(v.at(i), i)

        describe '#back()', () ->
                it 'should access the last element', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                                v.back().should.equal(i)

        describe '#front()', () ->
                it 'should access the first element ', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                                v.front().should.equal(0)

        describe '#size()', () ->
                it 'should returns the number of elements ', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                                v.size().should.equal(i + 1)

        describe '#empty()', () ->
                it 'should checks whether the container is empty', () ->
                        v = new jstl.vector()
                        v.empty().should.be.true
                        v.push_back(1)
                        v.empty().should.be.false
                        v.pop_back()
                        v.empty().should.be.true

        describe '#resize', () ->
                it 'should changes the number of elements stored', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        v.resize(5)
                        v.size().should.equal(5)
                        v.resize(-1)
                        v.size().should.equal(0)


        describe '#clear', () ->
                it 'should clears the contents', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        v.clear()
                        v.empty().should.be.true

        describe '#iterator', () ->
                it 'should allow to iterate throught the vector', ()->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        i = 0;
                        jstl.foreach v.begin(), v.end(), (e) ->
                                e.should.equal(i)
                                i++

        describe '#riterator', () ->
                it 'should allow to iterate throught the vector in reverse order', ()->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        i = 10;
                        jstl.foreach v.rbegin(), v.rend(), (e) ->
                                e.should.equal(i)
                                i--

        describe '#clone', () ->
                it 'should clone a vector', ()->
                        v = new jstl.vector()
                        for i in [1..10]
                                v.push_back(i)
                        v2 = v.clone()
                        v2.size().should.equal(10);
                        v.push_back(11)
                        v2.size().should.equal(10);

        describe '#swap', () ->
                it 'should swap the vector content', () ->
                        v = new jstl.vector()
                        for i in [1..10]
                                v.push_back(i)
                        v2 = new jstl.vector()
                        for i in [1..20]
                                v2.push_back(i)
                        v.swap v2
                        v.size().should.equal(20);
                        v2.size().should.equal(10)

        describe '#erase', () ->
                it 'should erases elements ', () ->
                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        v.erase(v.begin().add(1))
                        v.get(1).should.equal(2)
                        v.eraseRange(v.begin(), v.end().sub(1));
                        v.get(0).should.equal(10)

                        v = new jstl.vector()
                        for i in [0..10]
                                v.push_back(i)
                        v.erase(v.rbegin().add(1))
                        v.get(9).should.equal(10)
                        v.eraseRange(v.rbegin(), v.rend().sub(1));
                        v.get(0).should.equal(0)
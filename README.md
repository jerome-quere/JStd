JStd
====

Bringing the power of the C++ standard library to the JavaScript

Introduction
------------

The JavaScript standard library only contain Number, String, Boolean, Date, Regex, Array and Object. JavaScript application becoming bigger and bigger
the JStd intent to bring useful tool for creating more complete and powerful application.

Remark
------

Event if JStd mostly try to copy the C++ standard library, some missing feature from C++ such as operator overloading force JStd to change
some of the API specification.

Installation
-----------

Just download the release JavaScript file jstd.js and copy it in your application folder.

     jstd = require('jstd.js');

Operator Overloading
--------------------

	* obj1.operator==(obj2) ---> obj1.eq(obj2)
	* obj1.operator!=(obj2) ---> obj1.neq(obj2)
	* obj1.operator<(obj2)  ---> obj1.lt(obj2)
	* obj1.operator>(obj2)  ---> obj1.gt(obj2)
	* obj1.operator<=(obj2) ---> obj1.lte(obj2)
	* obj1.operator>=(obj2) ---> obj1.gte(obj2)
	* obj1 = obj2           ---> obj1.copy(obj2)
	* obj1(obj2)            ---> obj1 = obj2.clone()
	* obj1(param)           ---> obj1.call(param)
	* obj3 = obj1 + obj2	---> obj3 = obj1.add(abj2)
	* obj3 = obj1 - obj2	---> obj3 = obj1.sub(abj2)

Exception
---------

JStd declare some base exception type.

* exception
  * logic_error
     * out_of_range

Iterator
--------

One of the most powerful tools of the C++ library are the iterators.

Here an example of iterator working

	var container = new jstd.vector()
	/*
	 * Filling the container
	*/
	var it = container.begin()
	while (it.neq(container.end()))
	{
	  console.log(it.get())
	  it.next()
	}

Difference between C++ and JStd

	*it		---> it.get()
	*it = 42	---> it.set(42)
	it++		---> it.next()
	it--		---> it.sub()
	it2 = it + 2	---> it2 = it.add(2)
	it2 = it - 2	---> it2 = it.sub(2)

### inserter_iterator ###

This class allows some algorithm such as copy to insert in a container instead of overwriting existing content.

Here an example

	var list      = jstd.list()
	//Filling the list
	var vector = jstd.vector()
	var it = jstl.inserter(vector, vector.begin())
	jstl.copy(list.begin(), list.end(), it) //Insert the contents of the list in the vector without overwriting the content.

### back_inserter_iterator ###

This iterator allows some algorithm such as copy to push_back data in a container instead of overwriting existing content.

*see example for* `inserter_iterator`

### front_inserter_iterator ###

This iterator allows some algorithm such as copy to push_front data in a container instead of overwriting existing content.

*see example for* `inserter_iterator`

### advance ###

Advances the iterator i by n elements

	jstl.advance(iterator i, number n)

### distance ###

Calculates the number of elements between first and last.

	jstl.advance(iterator first, iterator last)


Numeric
-------

### accumulate ###

Returns the result of accumulating all the values in the range [first,last) to init.

	jstd.accumulate(iterator first, iterator last, number init)

Here an example

	var vector  //[10, 20, 10]
	jstd.accumulate(vector.begin(), vector.end(), 2) // Return 42

Algorithm
---------

### for_each ###

Applies function f to each elements in the range [first,last).

Here an example

	var vector //["He", "ll", "o!"]
	jstd.for_each(vector.begin(), vector.end(), function(elem) {console.log(elem);}) // Print Hello!

### min ###

Returns the lesser of a and b. If both are equal, a is returned.

	jstd.min(50, 42) //Return 42

### max ###

Returns the lesser of a and b. If both are equal, a is returned.

	jstd.min(50, 42) //Return 50

### copy ###

Copies the elements in the range [first,last) into a range beginning at result.

	jstd.copy(iterator first, iterator last, output_iterator it)

### fill_n ###

Sets value to the first n elements in the sequence pointed by first.

	jstd.fill_n(output_iterator first, n, v)

### toArray ###

Returns an array fill with all the element present between [first, last)

	jstd.toArray(iterator first, iterator last)

Vector
------

### constructor ###

Default constructor

	v = new jstd.vector()

### clone ###

Return a copy of the vector

       vector vector::clone()

### copy ###

See Operator Overloading

	void vector::copy(vector v)

### at ###

Returns the value of the element at position n in the vector.
The function automatically checks whether n is within the bounds of valid elements in the vector, throwing an out_of_range exception if it is not.

	value vector::at(int n)

### get ###

Same as at() without bounds checking

	value vector::get(int n)

### set ###

Set the value of the element at position n in the vector to val.

	void vector::set(int n, val)

### back ##

Returns the value of the last element in the vector.

	value vector::back()

### front ###

Returns the value of the first element in the vector

	value vector::front()

### push_back ###

Adds a new element at the end of the vector, after its current last element.

	void vector::push_back(value)

### pop_back ###

Removes the last element in the vector

	void vector::pop_back()

### size ###

Returns the number of elements in the vector.

	void vector::size()

### empty ###

Returns whether the vector is empty.

	bool vector::empty()

### resize ###

Resizes the container so that it has n elements.

	void vector::resize(int n)

### clear ###

Removes all elements from the vector.

	void vector::clear()

### swap ###

Exchanges the contents of the container by the contents of v.

	void vector::swap(vector v)

### begin ###

Returns an iterator pointing to the first element in the vector.

	iterator vector::begin()

### end ###

Returns an iterator referring to the past-the-end element in the vector container.

	iterator  vector::end()

### rbegin ###

Returns a reverse iterator pointing to the last element in the vector.

	reverse_iterator vector::rbegin()

### rend ###

Returns a reverse iterator pointing to the element right before the first element in the vector.

	reverse_iterator vector::rend()

### insert ###

The vector is extended by inserting new element value before the element pointed by the iterator it.

	iterator vector::insert(iterator it, value)

### insertRange ###

The vector is extended by inserting new elements present between the first and last iterator before the element pointed by the iterator it.

	iterator vector::insertRange(iterator it, iterator first, iterator last)

### erase ###

Removes from the vector a single element pointed by it.

	void vector::erase(iterator it)

### eraseRange(iterator first, iterator last) ###

Removes from the vector all the elements present in the interval [first, last)

	void vector::eraseRange(iterator first, iterator last)

### toString ###

Returns a string representation of the vector

	String vector::toString()

### toArray ###

Return a JavaScript array with all the vector content

       Array vector::toArray()

List
----

### constructor ###

Default constructor

	l = new jstd.list()

### clone ###

Return a clone of the list

       list list::clone()

### copy ###

See Operator Overloading

	void list::copy(list l)

### back ##

Returns the value of the last element in the list.

	list list::back()

### front ###

Returns the value of the first element in the list

	list list::front()

### push_back ###

Adds a new element at the end of the list, after its current last element.

	void list::push_back(value)

### push_front ###

Adds a new element at the beginning of the list, before its current first element.

	void list::push_front(value)

### pop_back ###

Removes the last element in the list

	void list::pop_back()

### pop_front ###

Removes the first element in the list

	void list::pop_front()

### size ###

Returns the number of elements in the list.

	void list::size()

### empty ###

Returns whether the list is empty.

	bool list::empty()

### resize ###

Resizes the container so that it has n elements.

	void list::resize(int n)

### clear ###

Removes all elements from the list.

	void list::clear()

### swap ###

Exchanges the contents of the container by the contents of l.

	void list::swap(list l)

### begin ###

Returns an iterator pointing to the first element in the list.

	iterator list::begin()

### end ###

Returns an iterator referring to the past-the-end element in the list.

	iterator  list::end()

### rbegin ###

Returns a reverse iterator pointing to the last element in the list.

	reverse_iterator list::rbegin()

### rend ###

Returns a reverse iterator pointing to the element right before the first element in the list.

	reverse_iterator list::rend()

### insert ###

The list is extended by inserting new element value before the element pointed by the iterator it.

	iterator list::insert(iterator it, value)

### insertRange ###

The list is extended by inserting new elements present between the first and last iterator before the element pointed by the iterator it.

	iterator list::insertRange(iterator it, iterator first, iterator last)

### erase ###

Removes from the lista single element pointed by it.

	void list::erase(iterator it)

### eraseRange(iterator first, iterator last) ###

Removes from the list all the elements present in the interval [first, last)

	void list::eraseRange(iterator first, iterator last)

### toString ###

Returns a string representation of the list

	String list::toString()

### toArray ###

Return a JavaScript array with all the list content

       Array list::toArray()

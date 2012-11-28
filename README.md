JStd
====

Bringing the power of the C++ standard library to the JavaScript

Introduction
------------

The javascript standard library only contain Number, String, Boolean, Date, Regex, Array and Object. Javascript application becoming bigger and biger
the JStd intent to bring usefull tool for creating more complte and powerfull application.

Remark
------

Event if JStd mostly try to copy the C++ standard library, some missing feature from C++ such as opperator overlowding force JStd to change
some of the API specification.

Instalation
-----------

Just download the release javascript file jstd.js and copy it in your application folder.

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

One of the most powerfull tools of the C++ library are the iterators.

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

This class allow some algorithm such as copy to insert in a container instead of overwriting existing content.

Here an example

	var list      = jstd.list()
	//Filling the list
	var vector = jstd.vector()
	var it = jstl.inserter(vector, vector.begin())
	jstl.copy(list.begin(), list.end(), it) //Insert the content of the list in the vector without ovewriting the content.

### back_inserter_iterator ###

This iterator allow some algorithm such as copy to push_back data in a container instead of overwriting existing content.

*see example for* `inserter_iterator`

### front_inserter_iterator ###

This iterator allow some algorithm such as copy to push_front data in a container instead of overwriting existing content.

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

Applies function f to each of the elements in the range [first,last).

Here an example

	var vector //["He", "ll", "o!"]
	jstd.for_each(vector.begin(), vector.end(), function(elem) {console.log(elem);}) // Print Hello!

### min ###

Returns the lesser of a and b. If both are equivalent, a is returned.

	jstd.min(50, 42) //Return 42

### max ###

Returns the lesser of a and b. If both are equivalent, a is returned.

	jstd.min(50, 42) //Return 50

### copy ###

Copies the elements in the range [first,last) into a range beginning at result.

	jstd.copy(iterator first, iterator last, output_iterator it)

### fill_n ###

Sets value to the first n elements in the sequence pointed by first.

	jstd.fill_n(output_iterator first, n, v)

Vector
------

**Doc not ready**
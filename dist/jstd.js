// Generated by CoffeeScript 1.7.1
(function() {
  var jstd,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  jstd = (function() {
    function jstd() {}

    return jstd;

  })();

  jstd.exception = (function() {
    function exception() {
      this.message = this.what();
    }

    exception.prototype.what = function() {
      return "exception";
    };

    return exception;

  })();

  jstd.not_implemented = (function(_super) {
    __extends(not_implemented, _super);

    function not_implemented(functionName) {
      this.functionName = functionName;
    }

    not_implemented.prototype.what = function() {
      return "Method: " + this.functionName + " not implemented";
    };

    return not_implemented;

  })(jstd.exception);

  jstd.logic_error = (function(_super) {
    __extends(logic_error, _super);

    function logic_error() {
      return logic_error.__super__.constructor.apply(this, arguments);
    }

    logic_error.prototype.what = function() {
      return "logic_error";
    };

    return logic_error;

  })(jstd.exception);

  jstd.out_of_range = (function(_super) {
    __extends(out_of_range, _super);

    function out_of_range() {
      return out_of_range.__super__.constructor.apply(this, arguments);
    }

    out_of_range.prototype.what = function() {
      return "out_of_range";
    };

    return out_of_range;

  })(jstd.logic_error);

  jstd.iterator = (function() {
    iterator.TYPE_INPUT = 1;

    iterator.TYPE_OUTPUT = 2;

    iterator.TYPE_FORWARD = 3;

    iterator.TYPE_BIDIRECTIONAL = 4;

    iterator.TYPE_RANDOM = 5;

    function iterator(type) {
      this.type = type;
    }

    iterator.prototype.getType = function() {
      return this.type;
    };

    return iterator;

  })();

  jstd.advance = function(i, n) {
    var p;
    if (i.getType() === jstd.iterator.TYPE_RANDOM) {
      i.copy(i.add(n));
      return i;
    }
    p = 0;
    while (p < n) {
      i.next();
      p++;
    }
    return i;
  };

  jstd.distance = function(first, second) {
    var i;
    if (first.getType() === jstd.iterator.TYPE_RANDOM) {
      return Math.abs(second.value() - first.value());
    }
    first = first.clone();
    i = 0;
    while (first.neq(second)) {
      first.next();
      ++i;
    }
    return i;
  };

  jstd.reverse_iterator = (function(_super) {
    __extends(reverse_iterator, _super);

    function reverse_iterator(baseIt) {
      reverse_iterator.__super__.constructor.call(this, baseIt.getType());
      this.baseIt = baseIt.clone();
    }

    reverse_iterator.prototype.clone = function() {
      return new reverse_iterator(this.baseIt);
    };

    reverse_iterator.prototype.copy = function(obj) {
      return this.swap(obj.clone());
    };

    reverse_iterator.prototype.swap = function(obj) {
      var _ref;
      return _ref = [obj.baseIt, this.baseIt], this.baseIt = _ref[0], obj.baseIt = _ref[1], _ref;
    };

    reverse_iterator.prototype.base = function() {
      return this.baseIt;
    };

    reverse_iterator.prototype.get = function() {
      return this.baseIt.clone().prev().get();
    };

    reverse_iterator.prototype.set = function(value) {
      return this.baseIt.sub(1).set(value);
    };

    reverse_iterator.prototype.next = function() {
      this.baseIt.prev();
      return this;
    };

    reverse_iterator.prototype.prev = function() {
      this.baseIt.next();
      return this;
    };

    reverse_iterator.prototype.eq = function(it) {
      return this.baseIt.eq(it.baseIt);
    };

    reverse_iterator.prototype.neq = function(it) {
      return !this.eq(it);
    };

    return reverse_iterator;

  })(jstd.iterator);

  jstd.inserter = function(container, it) {
    return new jstd.insert_iterator(container, it);
  };

  jstd.back_inserter = function(container) {
    return new jstd.back_insert_iterator(container);
  };

  jstd.front_inserter = function(container) {
    return new jstd.front_insert_iterator(container);
  };

  jstd.insert_iterator = (function(_super) {
    __extends(insert_iterator, _super);

    function insert_iterator(container, it) {
      this.container = container;
      this.it = it;
      insert_iterator.__super__.constructor.call(this, jstd.iterator.TYPE_OUTPUT);
    }

    insert_iterator.prototype.clone = function() {
      return new insert_iterator(this.container, this.it);
    };

    insert_iterator.prototype.copy = function(obj) {
      return this.swap(obj.clone());
    };

    insert_iterator.prototype.get = function() {};

    insert_iterator.prototype.set = function(value) {
      return this.it = this.container.insert(this.it, value);
    };

    insert_iterator.prototype.next = function() {};

    return insert_iterator;

  })(jstd.iterator);

  jstd.back_insert_iterator = (function(_super) {
    __extends(back_insert_iterator, _super);

    function back_insert_iterator(container) {
      this.container = container;
      back_insert_iterator.__super__.constructor.call(this, jstd.iterator.TYPE_OUTPUT);
    }

    back_insert_iterator.prototype.clone = function() {
      return new back_insert_iterator(this.container);
    };

    back_insert_iterator.prototype.copy = function(obj) {
      return this.swap(obj.clone());
    };

    back_insert_iterator.prototype.get = function() {};

    back_insert_iterator.prototype.set = function(value) {
      return this.container.push_back(value);
    };

    back_insert_iterator.prototype.next = function() {};

    return back_insert_iterator;

  })(jstd.iterator);

  jstd.front_insert_iterator = (function(_super) {
    __extends(front_insert_iterator, _super);

    function front_insert_iterator(container) {
      this.container = container;
      front_insert_iterator.__super__.constructor.call(this, jstd.iterator.TYPE_OUTPUT);
    }

    front_insert_iterator.prototype.clone = function() {
      return new front_insert_iterator(this.container);
    };

    front_insert_iterator.prototype.copy = function(obj) {
      return this.swap(obj.clone());
    };

    front_insert_iterator.prototype.get = function() {};

    front_insert_iterator.prototype.set = function(value) {
      return this.container.push_front(value);
    };

    front_insert_iterator.prototype.next = function() {};

    return front_insert_iterator;

  })(jstd.iterator);

  jstd.accumulate = function(first, last, init) {
    if (init == null) {
      init = 0;
    }
    first = first.clone();
    while (first.neq(last)) {
      init = init + first.get();
      first.next();
    }
    return init;
  };

  jstd.for_each = function(first, last, f) {
    while (first.neq(last)) {
      f(first.get());
      first.next();
    }
    return f;
  };

  jstd.min = function(obj1, obj2) {
    if (typeof obj1 === "number" || typeof obj1 === "bool" || typeof obj1 === "string" || obj1 instanceof Array) {
      if (!(obj2 < obj1)) {
        return obj1;
      } else {
        return obj2;
      }
    }
    if (!(obj2.lt(obj1))) {
      return obj1;
    } else {
      return obj2;
    }
  };

  jstd.max = function(obj1, obj2) {
    if (typeof obj1 === "number" || typeof obj1 === "bool" || typeof obj1 === "string" || obj1 instanceof Array) {
      if (obj1 < obj2) {
        return obj2;
      } else {
        return obj1;
      }
    }
    if (obj1.lt(obj2)) {
      return obj2;
    } else {
      return obj1;
    }
  };

  jstd.eq = function(obj1, obj2) {
    if (typeof obj1 === "number" || typeof obj1 === "bool" || typeof obj1 === "string" || obj1 instanceof Array) {
      return obj1 === obj2;
    }
    return obj1.eq(obj2);
  };

  jstd.lt = function(obj1, obj2) {
    if (typeof obj1 === "number" || typeof obj1 === "bool" || typeof obj1 === "string" || obj1 instanceof Array) {
      return obj1 < obj2;
    }
    return obj1.lt(obj2);
  };

  jstd.copy = function(first, last, it) {
    first = first.clone();
    it = it.clone();
    while (first.neq(last)) {
      it.set(first.get());
      first.next();
      it.next();
    }
    return it;
  };

  jstd.fill_n = function(first, n, v) {
    var i, _results;
    first = first.clone();
    i = 0;
    _results = [];
    while (i < n) {
      first.set(v);
      first.next();
      _results.push(i++);
    }
    return _results;
  };

  jstd.find = function(first, last, value) {
    first = first.clone();
    while (first.neq(last)) {
      if (jstd.eq(first.get(), value)) {
        return first;
      }
      first.next();
    }
    return last;
  };

  jstd.find_if = function(first, last, pred) {
    first = first.clone();
    while (first.neq(last)) {
      if (pred(first.get())) {
        return first;
      }
      first.next();
    }
    return first;
  };

  jstd.remove_if = function(first, last, pred) {
    var result;
    first = first.clone();
    result = first.clone();
    while (first.neq(last)) {
      if (!pred(first.get())) {
        result.set(first.get());
        result.next();
      }
      first.next();
    }
    return result;
  };

  jstd.toArray = function(first, last) {
    var array;
    array = new Array();
    jstd.for_each(first, last, function(e) {
      return array.push(e);
    });
    return array;
  };

  jstd.make_pair = function(first, second) {
    return new jstd.pair(first, second);
  };

  jstd.pair = (function() {
    function pair(first, second) {
      this.first = first;
      this.second = second;
    }

    pair.prototype.toString = function() {
      return "'" + this.first + "':'" + this.second + "'";
    };

    return pair;

  })();

  jstd.vector = (function() {
    function vector() {
      this.array = [];
    }

    vector.prototype.clone = function() {
      var v;
      v = new jstd.vector();
      v.insertRange(v.begin(), this.begin(), this.end());
      return v;
    };

    vector.prototype.copy = function(obj) {
      return this.swap(obj.clone());
    };

    vector.prototype.at = function(idx) {
      if (idx < 0 || idx >= this.size()) {
        throw new jstd.out_of_range();
      }
      return this.get(idx);
    };

    vector.prototype.get = function(idx) {
      return this.array[idx];
    };

    vector.prototype.set = function(idx, value) {
      return this.array[idx] = value;
    };

    vector.prototype.back = function() {
      return this.array[this.size() - 1];
    };

    vector.prototype.front = function() {
      return this.array[0];
    };

    vector.prototype.push_back = function(value) {
      return this.array.push(value);
    };

    vector.prototype.pop_back = function(value) {
      return this.array.pop();
    };

    vector.prototype.size = function() {
      return this.array.length;
    };

    vector.prototype.empty = function() {
      return this.size() === 0;
    };

    vector.prototype.resize = function(size) {
      var _results;
      if (size < 0) {
        size = 0;
      }
      if (size < this.size()) {
        this.eraseRange(jstd.advance(this.begin(), size), this.end());
      }
      _results = [];
      while (this.size() < size) {
        _results.push(this.array.push(null));
      }
      return _results;
    };

    vector.prototype.clear = function() {
      return this.resize(0);
    };

    vector.prototype.swap = function(obj) {
      var _ref, _ref1;
      _ref = [obj.array, this.array], this.array = _ref[0], obj.array = _ref[1];
      return _ref1 = [obj.idx, this.idx], this.idx = _ref1[0], obj.idx = _ref1[1], _ref1;
    };

    vector.prototype.begin = function() {
      return new this.iterator(this, 0);
    };

    vector.prototype.end = function() {
      return new this.iterator(this, this.size());
    };

    vector.prototype.rbegin = function() {
      return new jstd.reverse_iterator(this.end());
    };

    vector.prototype.rend = function() {
      return new jstd.reverse_iterator(this.begin());
    };

    vector.prototype.insert = function(it, value) {
      this.array.splice(it.value(), 0, value);
      return it.add(1);
    };

    vector.prototype.insertRange = function(it, first, last) {
      return jstd.copy(first, last, jstd.inserter(this, it));
    };

    vector.prototype.erase = function(it) {
      this.array.splice(it.value(), 1);
      return it.next();
    };

    vector.prototype.eraseRange = function(first, last) {
      var _ref;
      if (last.value() < first.value()) {
        _ref = [last.base(), first.base()], first = _ref[0], last = _ref[1];
      }
      return this.array.splice(first.value(), Math.abs(first.idx - last.idx));
    };

    vector.prototype.toString = function() {
      return "[" + (this.array.join(',')) + "]";
    };

    vector.prototype.toArray = function() {
      return this.array;
    };

    vector.prototype.iterator = (function(_super) {
      __extends(iterator, _super);

      function iterator(vector, idx) {
        this.vector = vector;
        this.idx = idx;
        iterator.__super__.constructor.call(this, jstd.iterator.TYPE_RANDOM);
      }

      iterator.prototype.clone = function() {
        return new iterator(this.vector, this.idx);
      };

      iterator.prototype.copy = function(obj) {
        var i;
        i = obj.clone();
        return this.swap(i);
      };

      iterator.prototype.swap = function(obj) {
        var _ref, _ref1;
        _ref = [obj.vector, this.vector], this.vector = _ref[0], obj.vector = _ref[1];
        return _ref1 = [obj.idx, this.idx], this.idx = _ref1[0], obj.idx = _ref1[1], _ref1;
      };

      iterator.prototype.get = function() {
        return this.vector.get(this.idx);
      };

      iterator.prototype.set = function(value) {
        return this.vector.set(this.idx, value);
      };

      iterator.prototype.value = function() {
        return this.idx;
      };

      iterator.prototype.next = function() {
        this.idx++;
        return this;
      };

      iterator.prototype.prev = function() {
        this.idx--;
        return this;
      };

      iterator.prototype.eq = function(it) {
        return this.idx === it.idx;
      };

      iterator.prototype.lt = function(it) {
        return this.idx < it.idx;
      };

      iterator.prototype.neq = function(it) {
        return !this.eq(it);
      };

      iterator.prototype.lte = function(it) {
        return this.lt(it) || this.eq(it);
      };

      iterator.prototype.gt = function(it) {
        return !this.lte(it);
      };

      iterator.prototype.gte = function(it) {
        return this.gt(it) || this.eq(it);
      };

      iterator.prototype.add = function(v) {
        return new iterator(this.vector, this.idx + v);
      };

      iterator.prototype.sub = function(v) {
        return new iterator(this.vector, this.idx - v);
      };

      return iterator;

    })(jstd.iterator);

    return vector;

  })();

  module.exports = jstd;

  jstd.list = (function() {
    function list() {
      var node;
      this.size_ = 0;
      node = new this.node();
      this.front_ = node;
      this.back_ = node;
      this.nextNodeIdx = 0;
    }

    list.prototype.clone = function() {
      var o;
      o = new list();
      o.insertRange(o.begin(), this.begin(), this.end());
      return o;
    };

    list.prototype.copy = function(obj) {
      return this.swap(obj.clone());
    };

    list.prototype.empty = function() {
      return this.size_ === 0;
    };

    list.prototype.size = function() {
      return this.size_;
    };

    list.prototype.resize = function(size) {
      var _results;
      if (size < 0) {
        size = 0;
      }
      if (size < this.size()) {
        this.eraseRange(jstd.advance(this.begin(), size), this.end());
      }
      _results = [];
      while (this.size() < size) {
        _results.push(this.push_back(null));
      }
      return _results;
    };

    list.prototype.front = function() {
      return this.front_.value;
    };

    list.prototype.back = function() {
      return this.back_.prev.value;
    };

    list.prototype.begin = function() {
      return new this.iterator(this, this.front_);
    };

    list.prototype.end = function() {
      return new this.iterator(this, this.back_);
    };

    list.prototype.rbegin = function() {
      return new jstd.reverse_iterator(this.end());
    };

    list.prototype.rend = function() {
      return new jstd.reverse_iterator(this.begin());
    };

    list.prototype.clear = function() {
      var node;
      node = new this.node();
      this.front_ = node;
      this.back_ = node;
      return this.size_ = 0;
    };

    list.prototype.swap = function(obj) {
      var _ref, _ref1, _ref2;
      _ref = [obj.front, this.front_], this.front_ = _ref[0], obj.front = _ref[1];
      _ref1 = [obj.back, this.back_], this.back_ = _ref1[0], obj.back = _ref1[1];
      return _ref2 = [obj.size_, this.size_], this.size_ = _ref2[0], obj.size_ = _ref2[1], _ref2;
    };

    list.prototype.push_front = function(value) {
      var node, _ref;
      node = new this.node();
      _ref = [value, null, this.front_, ++this.nextNodeIdx], node.value = _ref[0], node.prev = _ref[1], node.next = _ref[2], node.idx = _ref[3];
      this.size_++;
      return this.front_ = node;
    };

    list.prototype.push_back = function(value) {
      var node, _ref;
      node = new this.node();
      _ref = [value, this.back_.prev, this.back_, ++this.nextNodeIdx], node.value = _ref[0], node.prev = _ref[1], node.next = _ref[2], node.idx = _ref[3];
      this.size_++;
      this.back_.prev = node;
      if (node.prev) {
        node.prev.next = node;
      }
      if (this.front_.idx === -1) {
        return this.front_ = node;
      }
    };

    list.prototype.pop_front = function() {
      this.front_ = this.front_.next;
      return this.size_--;
    };

    list.prototype.pop_back = function() {
      this.back_.prev = this.back_.prev.prev;
      if (this.back_.prev) {
        this.back_.prev.next = this.back;
      }
      return this.size_--;
    };

    list.prototype.insert = function(it, value) {
      var node, _ref, _ref1;
      if (it.eq(this.end())) {
        this.push_back(value);
        return it;
      } else if (it.eq(this.begin())) {
        this.push_front(value);
      } else {
        node = new this.node();
        _ref = [value, it.node.prev, it.node], node.value = _ref[0], node.prev = _ref[1], node.next = _ref[2];
        _ref1 = [node, node], it.node.prev.next = _ref1[0], it.node.prev = _ref1[1];
        this.size_++;
      }
      return it.next();
    };

    list.prototype.insertRange = function(it, first, last) {
      return jstd.copy(first, last, jstd.inserter(this, it));
    };

    list.prototype.erase = function(it) {
      var _ref;
      if (it.eq(this.end())) {
        this.pop_back();
      } else if (it.eq(this.begin())) {
        this.pop_front();
      } else {
        _ref = [it.node.next, it.node.prev], it.node.prev.next = _ref[0], it.node.next.prev = _ref[1];
        this.size_--;
      }
      return it.next();
    };

    list.prototype.eraseRange = function(first, last) {
      var nbElem;
      if (first.eq(last)) {
        return;
      }
      nbElem = jstd.distance(first, last);
      if (first.eq(this.begin())) {
        this.front_ = last.node;
      }
      if (last.eq(this.end())) {
        this.back_.prev = first.node.prev;
      }
      if (last.neq(this.end())) {
        last.node.prev = first.prev;
      }
      if (last.neq(this.begin())) {
        first.prev.next = last.node;
      }
      return this.size_ = this.size_ - nbElem;
    };

    list.prototype.toString = function() {
      var str;
      str = "";
      jstd.for_each(this.begin(), this.end(), function(i) {
        if (str !== "") {
          str = "" + str + ", ";
        }
        return str = "" + str + i;
      });
      return "{" + str + "}";
    };

    list.prototype.toArray = function() {
      return jstd.toArray(this.begin(), this.end());
    };

    list.prototype.node = (function() {
      function node() {
        this.prev = null;
        this.next = null;
        this.value = null;
        this.idx = -1;
      }

      return node;

    })();

    list.prototype.iterator = (function(_super) {
      __extends(iterator, _super);

      function iterator(list, node) {
        this.list = list;
        this.node = node;
        iterator.__super__.constructor.call(this, jstd.iterator.TYPE_BIDIRECTIONAL);
      }

      iterator.prototype.clone = function() {
        return new iterator(this.list, this.node);
      };

      iterator.prototype.copy = function(obj) {
        return this.swap(obj.clone());
      };

      iterator.prototype.swap = function(obj) {
        var _ref, _ref1;
        _ref = [obj.list, this.list], this.list = _ref[0], obj.list = _ref[1];
        return _ref1 = [obj.node, this.node], this.node = _ref1[0], obj.node = _ref1[1], _ref1;
      };

      iterator.prototype.get = function() {
        return this.node.value;
      };

      iterator.prototype.set = function(value) {
        return this.node.value = value;
      };

      iterator.prototype.next = function() {
        this.node = this.node.next;
        return this;
      };

      iterator.prototype.prev = function() {
        this.node = this.node.prev;
        return this;
      };

      iterator.prototype.eq = function(it) {
        return this.node.idx === it.node.idx;
      };

      iterator.prototype.neq = function(it) {
        return !this.eq(it);
      };

      return iterator;

    })(jstd.iterator);

    return list;

  })();

  jstd.stack = (function() {
    function stack(container) {
      if (container == null) {
        container = jstd.list;
      }
      this.container = new [container][0]();
    }

    stack.prototype.clone = function() {
      var s;
      s = new jstd.stack();
      s.container = this.container.clone();
      return s;
    };

    stack.prototype.copy = function(obj) {
      var s;
      s = obj.clone();
      return this.swap(s);
    };

    stack.prototype.swap = function(obj) {
      var _ref;
      return _ref = [obj.container, this.container], this.container = _ref[0], obj.container = _ref[1], _ref;
    };

    stack.prototype.empty = function() {
      return this.container.size() === 0;
    };

    stack.prototype.size = function() {
      return this.container.size();
    };

    stack.prototype.top = function() {
      return this.container.back();
    };

    stack.prototype.push = function(value) {
      return this.container.push_back(value);
    };

    stack.prototype.pop = function() {
      return this.container.pop_back();
    };

    stack.container;

    return stack;

  })();

  jstd.queue = (function() {
    function queue(container) {
      if (container == null) {
        container = jstd.list;
      }
      this.container = new [container][0]();
    }

    queue.prototype.clone = function() {
      var q;
      q = new jstd.queue();
      q.container = this.container.clone();
      return q;
    };

    queue.prototype.copy = function(obj) {
      var q;
      q = obj.clone();
      return this.swap(q);
    };

    queue.prototype.swap = function(obj) {
      var _ref;
      return _ref = [obj.container, this.container], this.container = _ref[0], obj.container = _ref[1], _ref;
    };

    queue.prototype.empty = function() {
      return this.container.size() === 0;
    };

    queue.prototype.size = function() {
      return this.container.size();
    };

    queue.prototype.front = function() {
      return this.container.front();
    };

    queue.prototype.back = function() {
      return this.container.back();
    };

    queue.prototype.push = function(value) {
      return this.container.push_back(value);
    };

    queue.prototype.pop = function() {
      return this.container.pop_front();
    };

    queue.container;

    return queue;

  })();

  jstd.map = (function() {
    function map() {
      this.list = new jstd.list();
    }

    map.prototype.clone = function() {
      var m;
      m = new jstd.map();
      m.list = this.list.clone();
      return m;
    };

    map.prototype.swap = function(obj) {
      var _ref;
      return _ref = [obj.list, this.list], this.list = _ref[0], obj.list = _ref[1], _ref;
    };

    map.prototype.find = function(key) {
      return jstd.find_if(this.begin(), this.end(), function(pair) {
        return jstd.eq(pair.first, key);
      });
    };

    map.prototype.size = function() {
      return this.list.size();
    };

    map.prototype.empty = function() {
      return this.list.empty();
    };

    map.prototype.clear = function() {
      return this.list.clear();
    };

    map.prototype.set = function(key, value) {
      var it;
      it = this.find(key);
      if (it.neq(this.end())) {
        return it.get().second = value;
      } else {
        return this.insert(jstd.make_pair(key, value));
      }
    };

    map.prototype.get = function(key) {
      var it;
      it = this.find(key);
      if (it.eq(this.end())) {
        it = this.insert(jstd.make_pair(key, null));
      }
      return it.get().second;
    };

    map.prototype.begin = function() {
      return new this.iterator(this.list.begin());
    };

    map.prototype.end = function() {
      return new this.iterator(this.list.end());
    };

    map.prototype.rbegin = function() {
      return new jstd.reverse_iterator(this.end());
    };

    map.prototype.rend = function() {
      return new jstd.reverse_iterator(this.begin());
    };

    map.prototype.insert = function(pair) {
      var it, lend, lit;
      it = this.find(pair);
      if (it.eq(this.end())) {
        lit = this.list.begin();
        lend = this.list.end();
        while (lit.neq(lend)) {
          if (jstd.lt(pair.first, lit.get().first)) {
            return this.list.insert(lit, pair.clone());
          }
          lit.next();
        }
        return this.list.push_back(pair);
      }
      it.set(pair.clone());
      return it;
    };

    map.prototype.insertRange = function(first, last) {
      return jstd.for_each(first, last, (function(_this) {
        return function(pair) {
          return _this.insert(pair.clone());
        };
      })(this));
    };

    map.prototype.erase = function(key) {
      var it;
      it = this.find(key);
      if (it.neq(this.end())) {
        return this.list.erase(it.listIt);
      }
    };

    map.prototype.toString = function() {
      return this.list.toString();
    };

    map.prototype.toArray = function() {
      return this.list.toArray();
    };

    map.prototype.iterator = (function(_super) {
      __extends(iterator, _super);

      function iterator(listIt) {
        this.listIt = listIt;
        iterator.__super__.constructor.call(this, jstd.iterator.TYPE_BIDIRECTIONAL);
      }

      iterator.prototype.clone = function() {
        return new iterator(this.listIt.clone());
      };

      iterator.prototype.copy = function(obj) {
        var i;
        i = obj.clone();
        return this.swap(i);
      };

      iterator.prototype.swap = function(obj) {
        var _ref;
        return _ref = [obj.listIt, this.listIt], this.listIt = _ref[0], obj.listIt = _ref[1], _ref;
      };

      iterator.prototype.eq = function(obj) {
        return this.listIt.eq(obj.listIt);
      };

      iterator.prototype.neq = function(obj) {
        return !this.eq(obj);
      };

      iterator.prototype.next = function() {
        return this.listIt.next();
      };

      iterator.prototype.prev = function() {
        return this.listIt.prev();
      };

      iterator.prototype.get = function() {
        return this.listIt.get();
      };

      iterator.prototype.set = function(pair) {
        return this.listIt.set(pair);
      };

      return iterator;

    })(jstd.iterator);

    return map;

  })();

}).call(this);

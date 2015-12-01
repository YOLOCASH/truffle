/// @dev Models a modifiable and iterable set of uint values.
library IntegerSet
{
  struct data
  {
    /// Mapping item => index (or zero if not present)
    mapping(uint => uint) index;
    /// Items by index (index 0 is invalid), items with index[item] == 0 are invalid.
    uint[] items;
    /// Number of stored items.
    uint size;
  }
  function insert(data storage self, uint value) returns (bool alreadyPresent)
  {
    uint index = self.index[value];
    if (index > 0)
      return true;
    else
    {
      if (self.items.length == 0) self.items.length = 1;
      index = self.items.length++;
      self.items[index] = value;
      self.index[value] = index;
      self.size++;
      return false;
    }
  }
  function remove(data storage self, uint value) returns (bool success)
  {
    uint index = self.index[value];
    if (index == 0)
      return false;
    delete self.index[value];
    delete self.items[index];
    self.size --;
  }
  function contains(data storage self, uint value) returns (bool)
  {
    return self.index[value] > 0;
  }
  function iterate_start(data storage self) returns (uint index)
  {
    return iterate_advance(self, 0);
  }
  function iterate_valid(data storage self, uint index) returns (bool)
  {
    return index < self.items.length;
  }
  function iterate_advance(data storage self, uint index) returns (uint r_index)
  {
    index++;
    while (iterate_valid(self, index) && self.index[self.items[index]] == index)
      index++;
    return index;
  }
  function iterate_get(data storage self, uint index) returns (uint value)
  {
      return self.items[index];
  }
}

/// How to use it:
contract User
{
  /// Just a struct holding our data.
  IntegerSet.data data;
  /// Insert something
  function insert(uint v) returns (uint size)
  {
    /// Sends `data` via reference, so IntegerSet can modify it.
    IntegerSet.insert(data, v);
    /// We can access members of the struct - but we should take care not to mess with them.
    return data.size;
  }
  /// Computes the sum of all stored data.
  function sum() returns (uint s)
  {
    for (var i = IntegerSet.iterate_start(data); IntegerSet.iterate_valid(data, i); i = IntegerSet.iterate_advance(data, i))
      s += IntegerSet.iterate_get(data, i);
  }
}

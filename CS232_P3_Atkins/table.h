
#ifndef  TABLE_H
#define  TABLE_H



#include <stdexcept>

#include "pair.h"		// Pair class
#include "Mapping.h"

// implements a tabke containing key/value pairs.
// a table does not contain multiple copies of the same item.
// types T and Key must have a default constructor

template < class Key, typename T >
class Table
  {

  public:
    typedef Key key_type;
    // for  convenience


  private:
    // table implemented using a one dimensional array of key-value pairs
    int tableSize;
    Pair< key_type, T > *the_table;



    int (*Mapping)( Key k);
    // Mapping is a function which maps keys to
    // an array index; ie a key to address mapping
    // the idea is that Mapping will act on a given key
    // in such a way as to return the relative postion
    // in the sequence at which we expect to find the key
    // Mapping will be used in the remove, add, lookup. =
    // member functions and copy constructor

  public:

    // for debugging
    void   print();

    Table( int n, int (*map)( Key k)  );
	Table(const Table&);
    // map is a function to map key to address
    // in the implementation
    // set the function ie have the code line
    // Mapping = map;
    // populates table with default values
    // for the class Key and T

    bool insert(  Pair<  Key, T >  kvpair );
    // return true if item could be added to the
    // table false if item was not added.

    bool remove(  const Key  aKey );
    // erase the key/value pair with the specified key
    // from the table and return if successful
    // removed item is replaced with default
    // values for Key and T

    T  lookUp (const Key aKey) ;
    // what if key not in tavle??

    //need copy constructor
    //need destructor

     void operator= ( const Table & initTable );

    // is the table empty?
	bool empty() const;
    bool full() const;
    // is the table full?
     int size() const;
    // return the number of elements in the table
    bool isIn(const Key& key) const;
    // returns true/false in response to obvious question

	//gets the table data from a file
	void loadTable(Table &table);
	
	//runs the lock simulation
	void lock(Table<mappingpair, string> a, Table<mappingpair, string> b);
  };
#include "table.t"

#endif

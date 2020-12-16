/**************************************************************************************************
*
*   File name :			table.t
*
*	Programmer:  		Jeremy Atkins
*
*   Templated implementations of the functions for a table adt as defined in table.h. Contains the
*	Table class which uses the mapping function defined in Mapping.h to insert a key value pair
*	into a table for lookup.
*
*   Date Written:		in the past
*
*   Date Last Revised:	5/7/2019
****************************************************************************************************/
#ifndef TABLE_T
#define TABLE_T

#include <fstream>
#include <sstream>

/*******************************************************************************************
*	Function Name:			Table				the constructor
*	Purpose:				This constructor initializes a Table object which sets up
*							the mapping function, sets the table size, and initializes
*							the table to be empty.
*	Input Parameters:		int n		the table size
*							int(*map)	the mapping function
*	Return value:			none
********************************************************************************************/
template<class Key, typename T>
Table<Key, T>::Table(int n, int(*map)(Key k))
{
	Mapping = map;
	tableSize = n;

	the_table = new Pair<Key, T>[n];

	for (int i = 0; i < n; i++)
	{
		the_table[i].first.letter = NULL;
		the_table[i].first.state = "";
		the_table[i].second = "";
	}
}

/*******************************************************************************************
*	Function Name:			Table			the copy constructor
*	Purpose:				Creates a copy of the table
*	Input Parameters:		Table& initTable	the copied Table
*	Return value:			none
********************************************************************************************/
template<class Key, typename T>
Table<Key, T>::Table(const Table &initTable)
{
	(*this) = initTable;
}


/*******************************************************************************************
*	Function Name:			empty				
*	Purpose:				Determines if a Table currently has data or not
*	Input Parameters:		none
*	Return value:			bool	true if the table is empty
*									false if the table has data
********************************************************************************************/
template<class Key, typename T>
bool Table<Key, T>::empty() const
{
	for (int i = 0; i < tableSize; i++)
	{
		if (the_table[i].first.letter != NULL)
			return false;
	}
	return true;
}

/*******************************************************************************************
*	Function Name:			operator=				
*	Purpose:				Equality operator overload to set one Table equal to another
*	Input Parameters:		Table& initTable	the table to set the current Table equal to
*	Return value:			none
********************************************************************************************/
template<class Key, typename T>
void Table<Key, T> ::operator=(const Table &initTable)
{
	//copy table structure
	(*this).Mapping = initTable.Mapping;
	(*this).tableSize = initTable.tableSize;
	(*this).the_table = new Pair<Key, T>[initTable.tableSize];

	//copy table data
	for (int i = 0; i < tableSize; i++)
	{
		(*this).the_table[i].first.letter = initTable.the_table[i].first.letter;
		(*this).the_table[i].first.state = initTable.the_table[i].first.state;
		(*this).the_table[i].second = initTable.the_table[i].second;
	}
}

/*******************************************************************************************
*	Function Name:			full			
*	Purpose:				Determines if a Table is currently full or not
*	Input Parameters:		none
*	Return value:			bool	true if the table is full
*									false if the table is not full
********************************************************************************************/
template<class Key, typename T>
bool Table<Key, T>::full() const
{
	for (int i = 0; i < tableSize; i++)
	{
		if (the_table[i].first.letter == NULL)
			return false;

	}
	return true;
}

/*******************************************************************************************
*	Function Name:			size
*	Purpose:				Gets the amount of data currently in the table
*	Input Parameters:		none
*	Return value:			int		the amount of data in the table
********************************************************************************************/
template<class Key, typename T>
int Table<Key, T>::size() const
{
	int size = 0;
	for (int i = 0; i < tableSize; i++)
	{
		if (the_table[i].first.letter != NULL)
			size++;
	}
	return size;
}

/*******************************************************************************************
*	Function Name:			isIn
*	Purpose:				Determines whether a given key is in the table
*	Input Parameters:		Key& key	the key to search for
*	Return value:			bool	true if the key is in the table
*									false if the key is not in the table
********************************************************************************************/
template<class Key, typename T>
bool Table<Key, T>::isIn(const Key &key) const
{
	for (int i = 0; i < tableSize; i++)
	{
		if ((the_table[i].first.letter == key.letter) && (the_table[i].first.state == key.state))
			return true;
	}
	return false;
}

/*******************************************************************************************
*	Function Name:			lookUp
*	Purpose:				Finds a given index for a key in the table
*	Input Parameters:		none
*	Return value:			T	the second value in the pair
********************************************************************************************/
template<class Key, typename T>
T Table<Key, T>::lookUp(Key aKey)
{
	int index = Mapping(aKey);

	if (isIn(aKey))
		return the_table[index].second;
	else
		return "-1";
}

/*******************************************************************************************
*	Function Name:			insert
*	Purpose:				Maps a key value pair to an index location in the table
*							and inserts it if possible
*	Input Parameters:		Pair kvpair		key value pair to insert
*	Return value:			bool	true if the insertion was successful
*									false if the insertion was not successful
********************************************************************************************/
template<class Key, typename T>
bool Table<Key, T>::insert(Pair<Key, T> kvpair)
{
	int index = 0;

	//location to map to is not available
	if (lookUp(kvpair.first) != "-1")
		return false;

	//table is full
	if (full())
	{
		cout << "The table is full. No Key-Value pair added" << endl;
		return false;
	}

	else
	{
		//map the key value pair to the correct index
		index = Mapping(kvpair.first);

		//if the location is empty, insert the key value pair
		if ((the_table[index].first.letter == NULL) && (the_table[index].second == ""))
		{
			the_table[index] = kvpair;
			return true;
		}

		//if the location is not empty, exit
		else
		{
			cout << "Key-Value pair already exists in this location" << endl;
			return false;
		}
	}
}

/*******************************************************************************************
*	Function Name:			remove
*	Purpose:				Removes a key value pair from the table
*	Input Parameters:		Key aKey	key value pair to remove
*	Return value:			bool	true if the removal was successful
*									false if the removal was not succesful
********************************************************************************************/
template<class Key, typename T>
bool Table<Key, T>::remove(const Key aKey)
{

	//table already empty
	if (empty())
	{
		cout << "The table is already empty" << endl;
		return false;
	}

	//table has data
	else
	{
		//find the key to remove
		for (int i = 0; i < tableSize; i++)
		{
			if (the_table[i].first.letter == aKey.letter)
			{

				//set the key value pair data back to empty
				the_table[i].first.letter = NULL;
				the_table[i].first.state = "";
				the_table[i].second = "";
				cout << "Key-Value pair removed from the table" << endl;
				return true;
			}
		}

		//key not found
		cout << "Key-Value pair not found" << endl;
		return false;
	}
}

/*******************************************************************************************
*	Function Name:			print
*	Purpose:				Prints out the table data
*	Input Parameters:		none
*	Return value:			none
********************************************************************************************/
template<class Key, typename T>
void Table<Key, T>::print()
{
	for (int i = 0; i < tableSize; i++)
		cout << the_table[i].first.letter << " " << the_table[i].first.state << " " << the_table[i].second << endl;
}

/*******************************************************************************************
*	Function Name:			loadTable
*	Purpose:				Reads data from a file and inputs it into the table
*	Input Parameters:		Table&		the table to insert the data into
*	Return value:			none
********************************************************************************************/
template<class Key, typename T>
void Table<Key, T>::loadTable(Table &table)
{
	//get filename
	ifstream inFile;
	string fileName;

	getline(cin, fileName);
	inFile.open(fileName);

	//open file
	if (inFile.is_open())
	{

		//read data
		char c;
		string key, str, value;
		mappingpair mp;

		inFile >> c;
		inFile.ignore(1000, '\n');

		while (!inFile.eof())
		{
			inFile >> key;
			c = 'A';

			//get the line
			getline(inFile, str);
			istringstream inString(str);

			//read each part of the line
			while (inString >> value)
			{
				mp.letter = c;
				mp.state = key;

				//make a pair from the data and insert it into the table
				Pair<mappingpair, string> p = makePair(mp, value);
				table.insert(p);
				c++;
			}
		}
		inFile.close();
	}
	else
	{
		cout << "Error opening " << fileName << endl;
	}
}

/*******************************************************************************************
*	Function Name:			lock
*	Purpose:				Runs the lock simulation
*	Input Parameters:		Table a		the transition table
*							Table b		the action table
*	Return value:			none
********************************************************************************************/
template<class Key, typename T>
void Table<Key, T>::lock(Table<mappingpair, string> a, Table<mappingpair, string> b)
{
	char c;
	mappingpair p;
	int i = 0;

	//gives the user three attempts at a password
	while (i < 3)
	{
		//initialize to nke
		string state = "nke";

		cout << "Enter your password:";

		//loop for entering the password
		do
		{
			cout << "Enter (A, B, C, D, E): ";
			cin >> c;

			//input validation
			while ((c < 'A') || (c > 'E'))
			{
				cin.ignore();
				cout << "Error. Please enter (A, B, C, D, E): ";
				cin >> c;
			}

			//make a pair
			p.letter = c;
			p.state = state;

			//look up pair
			state = a.lookUp(p);
		} while ((state != "ok3") && (state != "fa3"));

		//final input
		cout << "Enter (A, B, C, D, E): ";
		cin >> c;

		p.letter = c;
		p.state = state;

		//if the incorrect password is entered three times, alarm
		if (i == 3)
		{
			cout << "Alarm!" << endl;
			return;
		}

		//if the input is incorrect
		else if (b.lookUp(p) == "alarm")
			cout << "Incorrect passcode. You have " << 2 - i << " attempts left." << endl;

		//the input is correct
		else
		{
			cout << "The lock is now open." << endl;
			return;
		}
		i++;

	}
}
#endif
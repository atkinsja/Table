/**************************************************************************************************
*
*   File name :			P3_driver.cpp
*
*	Programmer:  		Jeremy Atkins
*
*	Driver for a lock simulation program using a Table ADT to look up key value pairs in a 
*	finite state machine driven algorithm.
*
*   Date Written:		in the past
*
*   Date Last Revised:	5/7/2019
****************************************************************************************************/
#include <iostream>
#include "table.h"
using namespace std;

int main()
{
	//transition table
	Table<mappingpair, string> transition (35, map);

	//action table
	Table<mappingpair, string> action (35, map);

	//get the tables from files and populate tables
	cout << "Enter the transition table filename" << endl;
	transition.loadTable(transition);
	cout << "Enter the action table filename" << endl;
	action.loadTable(action);

	//run the lock simulation
	transition.lock(transition, action);
	return 0;
}
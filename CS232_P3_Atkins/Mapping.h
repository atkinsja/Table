/**************************************************************************************************
*
*   File name :			Mapping.h
*
*	Programmer:  		Jeremy Atkins
*
*	Mapping function used in the Table ADT for the finite state machine running the lock simulation
*
*   Date Written:		in the past
*
*   Date Last Revised:	5/7/2019
****************************************************************************************************/
#ifndef MAPPING_H
#define MAPPING_H
#include <iostream>
#include <string>
#include "pair.h"

using namespace std;

//letter and state pair struct
struct mappingpair
{
	char letter;
	string state;
};

/*******************************************************************************************
*	Function Name:			map
*	Purpose:				Mapping function used in the Table ADT for the finite state
*							machine running the lock simulation
*	Input Parameters:		mappingpair		character and string pair
*	Return value:			int		the position in the table to map the pair to
********************************************************************************************/
int map(mappingpair P)
{
	
	if (P.state == "nke")
		return P.letter % 5;
	else if (P.state == "ok1")
		return (P.letter % 5) + 5;
	else if (P.state == "ok2")
		return (P.letter % 5) + 10;
	else if (P.state == "ok3")
		return (P.letter % 5) + 15;
	else if (P.state == "fa1")
		return (P.letter % 5) + 20;
	else if (P.state == "fa2")
		return (P.letter % 5) + 25;
	else
		return (P.letter % 5) + 30;

}
#endif // !MAPPING_H

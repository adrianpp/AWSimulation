#include "Minion.hpp"
#include "MasterBoard.hpp"

Minion::Minion()
{
	Location = -1;
	type = ' ';
	isMinionSelected = false;
	team = 0;						//Team 0 is the neutral team.
	hasAttacked = false;
	hasMoved = false;
	health = 100;
	isAlive = false;
	
}

Minion::Minion(int inputLocation, char inputType, int inputTeam)
{
	Location = inputLocation;
	type = inputType;
	switch (inputType)
	{
	case('i'):
	{		
		description = "Infantry";
		movementRange = 3;
		attackRange = 1;
		break;
	}
	case('T'):
	{
		description = "Tank";
		movementRange = 6;
		attackRange = 1; 
		break;
	}
	case('A'):
	{
		description = "Artillery";
		movementRange = 5;
		attackRange = 3;
		break;
	}
	case('C'):
	{
		description = "Cavalry";
		movementRange = 8;
		attackRange = 1;
		break; 
	}
	case('R'): 
	{ 
		description = "Rocket";
		movementRange = 4;
		attackRange = 5;
		break; 
	}
	}

	team = inputTeam;
	health = 100;
	isAlive = true;
}


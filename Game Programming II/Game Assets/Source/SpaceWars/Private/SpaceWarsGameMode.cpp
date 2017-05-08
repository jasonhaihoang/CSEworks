// Copyright 1998-2014 Epic Games, Inc. All Rights Reserved.

#include "SpaceWars.h"
#include "SpaceWarsGameMode.h"
#include "SpaceWarsCharacter.h"

ASpaceWarsGameMode::ASpaceWarsGameMode(const FObjectInitializer& ObjectInitializer)
	: Super(ObjectInitializer)
{
	// set default pawn class to our Blueprinted character
	static ConstructorHelpers::FClassFinder<APawn> PlayerPawnBPClass(TEXT("/Game/Blueprints/MyCharacter"));
	if (PlayerPawnBPClass.Class != NULL)
	{
		DefaultPawnClass = PlayerPawnBPClass.Class;
	}
}

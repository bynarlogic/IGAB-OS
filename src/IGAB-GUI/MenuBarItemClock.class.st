Class {
	#name : 'MenuBarItemClock',
	#superclass : 'MenubarItemMorph',
	#instVars : [
		'updateProcess'
	],
	#category : 'IGAB-GUI-View',
	#package : 'IGAB-GUI',
	#tag : 'View'
}

{ #category : 'public' }
MenuBarItemClock >> currentTime [
	|hour minute|
	
	hour := DateAndTime now hour asString.
	minute := DateAndTime now minute printPaddedWith: $0 to: 2.
	
	^ hour , ':' , minute.
]

{ #category : 'public' }
MenuBarItemClock >> initialize [
	super initialize.
	
	self contents: '00:00'.
	self startUpdating.
]

{ #category : 'public' }
MenuBarItemClock >> startUpdating [
	updateProcess := [ 
		[ 
		self contents: self currentTime.
		(Delay forSeconds: 1) wait.
		] repeat .
	] fork.
]

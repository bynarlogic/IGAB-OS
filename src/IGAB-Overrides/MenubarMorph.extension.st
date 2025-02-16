Extension { #name : 'MenubarMorph' }

{ #category : '*IGAB-Overrides' }
MenubarMorph >> addClock [
	| spacer clock |

	spacer := Morph new.
	spacer color: Color transparent.
	spacer hResizing: #spaceFill.
	spacer height: 10.

	self addMorphBack: spacer.

	clock := MenuBarItemClock new.
	clock hResizing: #shrinkWrap.
	clock height: 30. 

	self addMorphBack: clock.

	"Ensure the menu bar itself has a fixed height"
	self height: 10.
	self extent: self width @ 10.
]

{ #category : '*IGAB-Overrides' }
MenubarMorph >> open [
	self menuBarItems
		do: [ :each |
			self
				add: each label
				icon: each icon
				help: each help
				subMenu: (each subMenu ifNotNil: #asMenubarMenuMorph)
				action: each action
				keyText: each keyText.
			each separator
				ifTrue: [ self addSeparator ] ].
	self
		addClock;
		adhereToTop;
		openInWorld
]

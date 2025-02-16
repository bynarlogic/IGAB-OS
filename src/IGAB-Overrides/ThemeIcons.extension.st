Extension { #name : 'ThemeIcons' }

{ #category : '*IGAB-Overrides' }
ThemeIcons >> loadIconsFromZipArchiveUsingScale: newScale [
	| newIconsPerScale zipContent |

	newIconsPerScale := Dictionary new.
	zipContent := (FileSystem zip: zipArchive) open workingDirectory.

	"If it has the old icon pack structure we handle as they don't have multiple sizes"
	(zipContent allChildrenMatching: 'icons') 
		ifNotEmpty: [ 
			scale := 1.
			^ self loadIconsOldIconSetsFrom: zipContent ].

	((zipContent allChildrenMatching: 'png-scale*') reject: [:directory | directory fullName = '/__MACOSX/bike-pack/png-scale1.0']) do: [ :directory |
		| newIcons |
		newIconsPerScale
			at: (Float readFrom: (directory basename copyFrom: 10 to: directory basename size))
			put: (newIcons := IdentityDictionary new).
		(directory allChildrenMatching: '*.png')
			reject: [ :each | each base beginsWith: '.' ]
			thenDo: [ :each |
				[ newIcons
					at: each base asSymbol
					put: (self readPNGFrom: each) ]
				on: Error do: [ :e | self crTrace: ('{1} not a PNG, skipping.' format: { each fullName }) ] ] ].
	newIconsPerScale keysAndValuesDo: [ :iconsScale :icons |
		icons at: #notFound ifAbsentPut: [ Color red iconOrThumbnailOfSize: 16 * iconsScale ] ].
	iconsPerScale := newIconsPerScale.
	scale := newScale
]

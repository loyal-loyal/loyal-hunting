<div align='center'><h3><a href='https://github.com/loyal-loyal'>More Information & Scripts can be found here!</a></h3></div>

## Preview

https://youtu.be/aIhqSUs8hbs

With this resource, you will be able to do the following:

- Hunting
- Baited and spawn animal
- Rewards are obtained based on weapon (gun or no)
- Rewards are obtained based on damage parts (headshot or no)
- Sell
- Require a hunting knife to cut meat
- Animation when carrying animals in inventory
- The shop sells the necessary items for hunting
- Anti gun fire human
- Hunting Zone

## Supported Frameworks

- QBCore
- ESX

## Dependencies

<a href='https://github.com/overextended/ox_lib/releases/'>Ox Lib</a></br> 
<a href='https://github.com/qbcore-framework/qb-target'>QB Target</a></br> 
<a href='https://github.com/overextended/ox_target'>Ox Target</a></br> 
<a href='https://github.com/overextended/ox_inventory'>Ox Inventory</a>


## Installation

<p>Drag the images in the img folder into your inventory script.</p>
<p>Config suitable for your resource</p>
<p>Add the items for your framework from the items folder.</p>

```Lua
--qb-core
    ['huntingbait'] 						 = {['name'] = 'huntingbait', 			 	  	  	['label'] = 'Animal Bait', 	['weight'] = 200, 		['type'] = 'item', 		['image'] = 'np_huntingbait.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['huntingknife'] 						 = {['name'] = 'huntingknife', 			 	  	  	['label'] = 'Hunting Knife', 	['weight'] = 200, 		['type'] = 'item', 		['image'] = 'huntingknife.png', 				['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},

	['carcass_boar1'] 						 = {['name'] = 'carcass_boar1', 			 	  	  	['label'] = 'Carcass Boar', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_boar1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['carcass_boar2'] 						 = {['name'] = 'carcass_boar2', 			 	  	  	['label'] = 'Carcass Boar', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_boar2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['carcass_boar3'] 						 = {['name'] = 'carcass_boar3', 			 	  	  	['label'] = 'Carcass Boar', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_boar3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
    ['carcass_hawk1'] 						 = {['name'] = 'carcass_hawk1', 			 	  	  	['label'] = 'Carcass Hawk', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_hawk1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_hawk2'] 						 = {['name'] = 'carcass_hawk2', 			 	  	  	['label'] = 'Carcass Hawk', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_hawk2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_hawk3'] 						 = {['name'] = 'carcass_hawk3', 			 	  	  	['label'] = 'Carcass Hawk', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_hawk3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
    ['carcass_cormorant1'] 						 = {['name'] = 'carcass_cormorant1', 			 	  	  	['label'] = 'Carcass Cormorant', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_cormorant1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_cormorant2'] 						 = {['name'] = 'carcass_cormorant2', 			 	  	  	['label'] = 'Carcass Cormorant', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_cormorant2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_cormorant3'] 						 = {['name'] = 'carcass_cormorant3', 			 	  	  	['label'] = 'Carcass Cormorant', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_cormorant3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
    ['carcass_coyote1'] 						 = {['name'] = 'carcass_coyote1', 			 	  	  	['label'] = 'Carcass Coyote', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_coyote1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_coyote2'] 						 = {['name'] = 'carcass_coyote2', 			 	  	  	['label'] = 'Carcass Coyote', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_coyote2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_coyote3'] 						 = {['name'] = 'carcass_coyote3', 			 	  	  	['label'] = 'Carcass Coyote', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_coyote3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
    ['carcass_deer1'] 						 = {['name'] = 'carcass_deer1', 			 	  	  	['label'] = 'Carcass Deer', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_deer1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_deer2'] 						 = {['name'] = 'carcass_deer2', 			 	  	  	['label'] = 'Carcass Deer', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_deer2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_deer3'] 						 = {['name'] = 'carcass_deer3', 			 	  	  	['label'] = 'Carcass Deer', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_deer3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
    ['carcass_mtlion1'] 						 = {['name'] = 'carcass_mtlion1', 			 	  	  	['label'] = 'Carcass Mtlion', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_mtlion1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_mtlion2'] 						 = {['name'] = 'carcass_mtlion2', 			 	  	  	['label'] = 'Carcass Mtlion', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_mtlion2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_mtlion3'] 						 = {['name'] = 'carcass_mtlion3', 			 	  	  	['label'] = 'Carcass Mtlion', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_mtlion3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
    ['carcass_rabbit1'] 						 = {['name'] = 'carcass_rabbit1', 			 	  	  	['label'] = 'Carcass Rabbit', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_rabbit1.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_rabbit2'] 						 = {['name'] = 'carcass_rabbit2', 			 	  	  	['label'] = 'Carcass Rabbit', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_rabbit2.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['carcass_rabbit3'] 						 = {['name'] = 'carcass_rabbit3', 			 	  	  	['label'] = 'Carcass Rabbit', 	['weight'] = 50000, 		['type'] = 'item', 		['image'] = 'carcass_rabbit3.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
```

```Lua
--ox_inventory
    ['huntingbait'] = {
		label = 'Animal Bait',
		weight = 200,
	},
	
	['huntingknife'] = {
		label = 'Hunting Knife',
		weight = 200,
	},

	['carcass_boar1'] = {
		label = 'Carcass Boar',
		weight = 50000,
	},
	['carcass_boar2'] = {
		label = 'Carcass Boar',
		weight = 50000,
	},
	['carcass_boar3'] = {
		label = 'Carcass Boar',
		weight = 50000,
	},

	['carcass_hawk1'] = {
		label = 'Carcass Hawk',
		weight = 50000,
	},
	['carcass_hawk2'] = {
		label = 'Carcass Hawk',
		weight = 50000,
	},
	['carcass_hawk3'] = {
		label = 'Carcass Hawk',
		weight = 50000,
	},

	['carcass_cormorant1'] = {
		label = 'Carcass Cormorant',
		weight = 50000,
	},
	['carcass_cormorant2'] = {
		label = 'Carcass Cormorant',
		weight = 50000,
	},
	['carcass_cormorant3'] = {
		label = 'Carcass Cormorant',
		weight = 50000,
	},

	['carcass_coyote1'] = {
		label = 'Carcass Coyote',
		weight = 50000,
	},
	['carcass_coyote2'] = {
		label = 'Carcass Coyote',
		weight = 50000,
	},
	['carcass_coyote3'] = {
		label = 'Carcass Coyote',
		weight = 50000,
	},

	['carcass_deer1'] = {
		label = 'Carcass Deer',
		weight = 50000,
	},
	['carcass_deer2'] = {
		label = 'Carcass Deer',
		weight = 50000,
	},
	['carcass_deer3'] = {
		label = 'Carcass Deer',
		weight = 50000,
	},

	['carcass_mtlion1'] = {
		label = 'Carcass Mtlion',
		weight = 50000,
	},
	['carcass_mtlion2'] = {
		label = 'Carcass Mtlion',
		weight = 50000,
	},
	['carcass_mtlion3'] = {
		label = 'Carcass Mtlion',
		weight = 50000,
	},

	['carcass_rabbit1'] = {
		label = 'Carcass Rabbit',
		weight = 50000,
	},
	['carcass_rabbit2'] = {
		label = 'Carcass Rabbit',
		weight = 50000,
	},
	['carcass_rabbit3'] = {
		label = 'Carcass Rabbit',
		weight = 50000,
	},
```
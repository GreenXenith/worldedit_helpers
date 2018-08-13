# WorldEdit Helpers #

This Client-Side Mod provides a few special commands for WorldEdit utilizing `//luatransform`.

## Commands: ##
* `grass`
* `rs` (Smart Replace)
* `stk` (Smart Stack)

## Inputs: ##
* `modname:nodename`
* `searchterm`

Any command requiring an input ([`rs`](https://github.com/GreenXenith/worldedit_helpers#rs) and [`stk`](https://github.com/GreenXenith/worldedit_helpers#stk)) may take a node name or search term.  
If the input contains `:` it will treat it as a node name and require an exact match.  
Anything without `:` will be treated as a search term.

## Usage: ##
### `grass`: ###
**Populates area on `default:dirt_with_grass` with grass.**
> `.grass <scarcity>`

`<scarcity>` being a number. Higher number means lower chance. Default is `10`.  
**Example: `.grass 30`**  
This would populate the area with a very low amount of grass.

### `rs`: ###
**"Smart `//replace`". Replaces multiple inputs with a node.**
> `.rs <node to replace> <...> <node to replace with>`

**Example: `.rs default:stone dirt air`**  
This replaces all `default:stone` nodes and nodes containing `dirt` in the name with `air`.  
**Example 2: `.rs moretrees air`**  
This handy snippet replaces anything containing `moretrees` with air. Handy for getting rid of trees from the [moretrees mod](https://forum.minetest.net/viewtopic.php?t=4394).

### `stk`: ###
**"Smart `//stack`". Stacks multiple inputs along an axis by n amount.**
> `.stk <node to stack> <...> <axis> <amount`

**Example: `.stk default:dirt sand y 5`**  
This stacks all `default:dirt` nodes and nodes containing `sand` in the name along the `Y` axis `5` times.
///Rift_SubmitLayers( numLayers )

/* Let the rift know how many layers it needs to render.  Layers are renders
from back to front, starting at 0 and increase up.  Add layers using Rift_AddLayer */

if ( global.IsRiftInitialized )
{   
    RiftExt_SubmitLayers(argument0);
}

d3d_end();
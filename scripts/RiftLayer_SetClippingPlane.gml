///RiftLayer_SetClippingPlane( layer, zNear, zFar )

/* Sets the clipping plane for the projection matrix, defaults 0.2 and 1000 for 
zNear and zFar respectively. */

if ( global.IsRiftInitialized )
{
    RiftExtLayer_SetClippingPlane(argument0, argument1, argument2); 
}

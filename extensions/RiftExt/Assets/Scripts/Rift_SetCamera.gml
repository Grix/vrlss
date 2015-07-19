///Rift_SetCamera( x, y, z, quatW, quatX, quatY, quatZ )

/* This modifies the rift's viewing angle and position in the 3d world. */

if ( global.IsRiftInitialized )
{
    RiftExt_SetCamera(argument0, argument1, argument2, argument3, argument4, argument5, argument6);
}
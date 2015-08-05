///Rift_AddLayer( pixelsPerDisplayPixel )

/* Adds a layer to the Oculus Rift system for rendering.  At present the extension supports
a maximum of 16 layers.  Note that there is presently no way  in this extension 
to remove layers once added due to bugs in the current runtime. To remove a layer, you
will need to shut down the rift with Rift_Shutdown and then restart it.  

pixelsPerDisplayPixel sets the quality of the texture used for rendering.  This should be 
1 in most cases.  But for performance, it can be useful to lower it.
*/

if ( global.IsRiftInitialized )
{
    RiftExt_AddLayer(argument0);
}
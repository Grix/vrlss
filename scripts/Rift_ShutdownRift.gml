///Rift_ShutdownRift()

/* Shuts down all of the rift components and frees up any surfaces created. */

if ( global.IsRiftInitialized )
{
    RiftExt_ShutdownRift();
    application_surface_draw_enable(true);
    global.IsRiftInitialized = false;
}
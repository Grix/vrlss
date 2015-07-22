///Rift_ShutdownRift()

/* Shuts down all of the rift components and frees up any surfaces created. */

if ( global.IsRiftInitialized )
{
    RiftExt_Shutdown();
    application_surface_draw_enable(true);
    global.IsRiftInitialized = false;
}
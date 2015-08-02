///Rift_ShutdownRift()

/* Shuts down all of the rift components and frees up any surfaces created. */

if ( global.IsRiftInitialized )
{
    RiftExt_Shutdown();
    application_surface_draw_enable(true);
    global.IsRiftInitialized = false;
    
    buffer_delete(global.RiftMatrixBuf);
    buffer_delete(global.RiftVec2Buf);
    buffer_delete(global.RiftVec3Buf);
    buffer_delete(global.RiftVec4Buf);
}
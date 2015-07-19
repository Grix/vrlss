///Rift_StartRenderLeftEye()

/* Prepares the left eye surface for rendering. */

if ( global.IsRiftInitialized )
{
    surface_set_target(global.DummySurface);
    RiftExt_StartRenderLeftEye();
    draw_clear(c_black);
}
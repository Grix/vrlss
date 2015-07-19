///Rift_StartRenderRightEye()

/* Prepares the left eye surface for rendering. */

if ( global.IsRiftInitialized )
{
    surface_set_target(global.DummySurface);
    RiftExt_StartRenderRightEye();
    draw_clear(c_black);
}
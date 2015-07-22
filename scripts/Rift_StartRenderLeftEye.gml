///Rift_StartRenderLeftEye()

/* Prepares the left eye surface for rendering. */

if ( global.IsRiftInitialized )
{

    surface_set_target(global.DummySurface);
    RiftExt_StartRenderLeftEye();
    global.CurrentViewMatrix = string_split_ext(RiftExt_GetCurrentViewMatrix(), " ");

    draw_clear(c_black);

    matrix_set(matrix_projection, global.LeftEyeProjectionMatrix);
    matrix_set(matrix_view, global.CurrentViewMatrix);
}
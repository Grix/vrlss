///Rift_Init()

/* Attempts to initialize the rift and returns an error code if initialization should fail for some reason. */

if ( global.HasRift )
{
    global.RiftMatrixBuf = buffer_create(4*16, buffer_fixed, 4);
    global.RiftVec2Buf = buffer_create(2*3, buffer_fixed, 4);
    global.RiftVec3Buf = buffer_create(3*3, buffer_fixed, 4);
    global.RiftVec4Buf = buffer_create(4*4, buffer_fixed, 4);

    global.RiftEyeHeight = 1.61;
    global.DummySurface = -1;
    
    var result, debugMessage;
    
    //Pass D3D9 pointer and window handle to DLL 
    Window_SetWindow(window_handle());
    result = RiftExt_Init(window_device());
      
    if ( result != -1 )
    {
        application_surface_draw_enable(false);
        global.IsRiftInitialized = true;
        d3d_set_culling(true);
        d3d_set_hidden(true);
        d3d_set_perspective(false);
        
        RiftExt_SetMatrixBuffer(buffer_get_address(global.RiftMatrixBuf));
        RiftExt_SetVec2Buffer(buffer_get_address(global.RiftVec2Buf));
        RiftExt_SetVec3Buffer(buffer_get_address(global.RiftVec3Buf));
        RiftExt_SetVec4Buffer(buffer_get_address(global.RiftVec4Buf));        
    }
    else
    {
        if ( global.IsDebugMode )
            { show_message(RiftExtError_GetLast()); }
        
        game_end();
    }
    
    return result;
}

return -1;

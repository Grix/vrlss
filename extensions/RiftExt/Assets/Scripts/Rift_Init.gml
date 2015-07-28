///Rift_Init()

/* Attempts to initialize the rift and returns an error code if initialization should fail for some reason. */

if ( global.HasRift )
{
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

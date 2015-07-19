/*

This extension makes GameMaker work with the Rift 6.0.1 beta runtime.  To make use of the extension, do as follows:

1.  Call Init()

2.  Call Rift_Init()
    Rift init will initialize libOVR, the rift itself, and any necessary surfaces.  
    This will also disable drawing to the application surface in orderto speed up performance.

3.  Call Rift_SetCamera
    This will update the rift DLL with GM's position and orientation settings.  

3.  Call Rift_StartFrame()
    This will update Rift tracking information and prepare the render target for rendering.  
    It should be called during Rift's draw event.  After it is called, do not use surface_set_target 
    or surface_reset target.  Also do not perform any further draw calls unless they're between 
    Rift_StartRender/Rift_EndRender calls.

4.  Call Rift_StartRenderLeftEye
    This prepares the left eye for rendering, including setting up appropriate projection and view matrices.  
    Draw your world now.

5.  Call Rift_EndRenderLeftEye

6.  Repeat 4 and 5 for RightEye

7.  Call Rift_ShowFrame
    This finalizes everything and updates the Rift's display.

8.  Repeat 3 through 7 in your main game loop

9.  When everything is finished, call Rift_ShutdownRift
    This will free up all surfaces, free up the Rift.

***NOTES***

The Rift uses Directx 11 and requires Windows 7 or later.  Gamemaker uses Directx 9.  To make them work together, 
the extensions creates a DirectX 11 device to share resources with GM's Directx 9 device.  This is a little slow.  
On the upside, the 3D in GM is very lean, so out of the box it's easy to reach high framerates.

*/
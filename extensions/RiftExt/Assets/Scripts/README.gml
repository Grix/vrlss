/*

** Note, there seems to be a bug in the Oculus Runtime SDK such that calling Rift_Shutdown/Rift_Init in quick
succession may cause issues. 

HOW TO USE THIS EXTENSION

This extension makes GameMaker work with the Rift 6.0.1 beta runtime.  To make use of the extension, do as follows:

1.  Call Init()

2.  If global.HasRift is true, libOVR has been initialized and the person likely has a rift, so continue forward.

3.  Call Rift_Init
    This will initialize the rift HMD and the directX 11 device 
    This will also disable drawing to the application surface in order to speed up performance.

4.  Call Rift_AddLayer
    This will add a render layer for the extension.  Render layers are accessed via index, with the
    first layer created being 0, the second being 1, and so on and so forth.  
    
5.  Call Rift_SetCamera
    This will update a rift layer with Position and Orientation settings, so the extension can
    calculate the appropriate view matrix

6.  Call Rift_StartFrame()
    This will update Rift tracking information and prepare the render target for rendering.  
    It should be called during Rift's draw event.  After it is called, do not use surface_set_target 
    or surface_reset target.  Also do not perform any further draw calls unless they're between 
    Rift_StartRender/Rift_EndRender calls.

7.  Call Rift_BeginEyeRender
    This prepares an eye on a sepcific layer for rendering, including setting up appropriate projection and 
    view matrices.  Draw your world now.

8.  Call Rift_EndEyeRender
    This finishes drawing for the current eye and layer.
    
9.  Repeat 6 and 7 for all eyes/layers.  Note that it's not completely necessary to re-render every layer.  You
    could, for example, have a low quality background layer for rendering things on a wearer's periphery.

10. Call Rift_SubmitLayers
    This finalizes everything and submits the number of layers selected to the rift compositer, which will
    combine everything and apply distortion

11. Repeat steps 5 through 10 in your main game loop

12. When everything is finished, call Rift_Shutdown. This will free up all layers and release the HMD

13. Finally, call RiftSystem_Shutdown.  This disables libOVR.

***NOTES***

The Rift uses Directx 11 and requires Windows 7 or later.  Gamemaker uses Directx 9.  To make them work together, 
the extensions creates a DirectX 11 device to share resources with GM's Directx 9 device.  This is a little slow.  
On the upside, the 3D in GM is very lean, so out of the box it's easy to reach high framerates.

*/

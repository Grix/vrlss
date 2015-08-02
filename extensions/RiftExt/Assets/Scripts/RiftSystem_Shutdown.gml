///RiftSystem_Shutdown()

/* Shuts down libOVR, call at the end of the program. */

if ( global.HasRift )
{
    RiftExtSystem_Shutdown();
}
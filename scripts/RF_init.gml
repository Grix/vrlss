/* Syntax: RF_Init([DLL])

Arguments:
[DLL] (Optional) - The path to the DLL file. Defaults to ReadFile2.dll.

Returns: 1 on success, 0 if it's already initialized, or -1 on error.

Notes: Call this to initialize the ReadFile system. You shouldn't call
       it more than once per game, but it's safe if you do.
*/

if (is_real(argument0)) {
  argument0=working_directory+"\lib\ReadFile2.dll";
}


if (!file_exists(argument0)) {
  show_error("ReadFile2 System DLL '"+argument0+"' Could Not Be Found.",0);
  return -1;
}

global.__RFDLL=argument0;
global.__RFInit=1;

global.__RFAll=external_define(global.__RFDLL,"ReadAll",dll_cdecl,ty_string,1,ty_string);
global.__RFPart=external_define(global.__RFDLL,"ReadPart",dll_cdecl,ty_string,3,ty_string,ty_real,ty_real);

global.__RFCount=external_define(global.__RFDLL,"CountLines",dll_cdecl,ty_real,1,ty_string);
global.__RFLine=external_define(global.__RFDLL,"ReadLine",dll_cdecl,ty_string,2,ty_string,ty_real);

global.__RFFree=external_define(global.__RFDLL,"FreeMem",dll_cdecl,ty_real,0);


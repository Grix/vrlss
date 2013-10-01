/* Syntax: RF_ReadAll(file)

Arguments:
file - The filename of the file to read.

Returns: The entire file contents of "file".

*/
var ret;
ret=external_call(global.__RFAll,argument0);
external_call(global.__RFFree);

return ret;

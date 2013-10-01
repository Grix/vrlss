/*Correct Time Script
By: Brandon 'Shaltif' Rohrer
=============================
Argument0 = REAL - Time in milliseconds
-
Return = STRING - Time in MM:SS format*/
ms = argument0/30*1000; 

var ones, tens, huns;
ones = ms div 1000; huns = ms div 60000;
ones -= huns*60;
if (ones < 10) { tens = "0"; } else { tens = ""; };
return string(huns)+":"+tens+string(ones);

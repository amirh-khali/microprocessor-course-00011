set file_name=%1
ml /c /Zd /coff %file_name%.asm
Link \masm32\irvine\Irvine32.lib \masm32\lib\kernel32.lib \masm32\lib\user32.lib /SUBSYSTEM:CONSOLE .\%file_name%.obj
%file_name%.exe
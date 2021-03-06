;/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\
;Ini Read/Write
;\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/--\--/
;Imports settings.ini or Argument specified file
;Credit for Function: Superfraggle

Fn_InitializeIni(inifile = "settings.ini"){
  global
  local key,temp
  inisections:=0
 
  loop,read,%inifile%
  {
	if regexmatch(A_Loopreadline,"\[(.*)?]")
	  {
		inisections+= 1
		section%inisections%:=regexreplace(A_loopreadline,"(\[)(.*)?(])","$2")
		section%inisections%_keys:=0
	  }
	else if regexmatch(A_LoopReadLine,"(\w+)=(.*)")
	  {
		section%inisections%_keys+= 1
		key:=section%inisections%_keys
		section%inisections%_key%key%:=regexreplace(A_LoopReadLine,"(\w+)=(.*)","$1")
	  }
  }
}

Fn_LoadIni(inifile="settings.ini"){
  global
  local sec,var
  loop,%inisections%
	{
	  sec:=A_index
	  loop,% section%a_index%_keys
		{
		  var:=section%sec% "_" section%sec%_key%A_index%,
		  Stringreplace,var,var,%a_space%,,All
		  iniread,%var%,%inifile%,% section%sec%,% section%sec%_key%A_index%
		}
	}
}

Fn_WriteIni(inifile="settings.ini"){
  global
  local sec,var
  loop,%inisections%
	{
	  sec:=A_index
	  loop,% section%a_index%_keys
		{
		  var:=section%sec% "_" section%sec%_key%A_index%
		  Stringreplace,var,var,%a_space%,,All
		  var:=%var%
		  iniwrite,%var%,%inifile%,% section%sec%,% section%sec%_key%A_index%
		}
	}
}
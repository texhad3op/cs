-module(xmlp).
-export([f/0,f1/0,f2/0,f3/0]).

f1()-> string:concat("",atom_to_list('TRX')).

f2()->
	Xml = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><TRX>    <CRD>   <PAN>100000009</PAN>   <PAN>100000010</PAN><EXP>0518</EXP></CRD></TRX>",
	{ParsResult,Misc}=xmerl_scan:string(Xml),
	{xmlElement,_,_,_,_,_,_,_,Elements,_,_,_} = ParsResult,
	populate(Elements).

f()->
	{ParsResult,Misc}=xmerl_scan:file("r1.xml"),
	{xmlElement,_,_,_,_,_,_,_,Elements,_,_,_} = ParsResult,
	populate(Elements).
	
populate([H|T])->
	case H of
		{xmlElement,_,_,_,_,_,_,_,Elements,_,_,_} -> populate(Elements);
		{xmlText,Path,_,_,Val,_} -> io:format("~n~p  ~p", [get_path(lists:reverse(Path)), Val])
		%string:strip(A)
	end,
populate(T);
		
populate([])->done.	

get_path([H|T]) -> get_path([H|T], "").

get_path([H|T], Acc)->
	{PathElement,_} = H,
	get_path(T, string:concat(Acc, atom_to_list(PathElement)));

get_path([], Acc)-> Acc.

f3()->
 file:consult("config.properties").

		
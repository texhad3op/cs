-module(configuration).
-export([read_configuration/0, print_configuration/1]).

read_configuration()->
	RequiredParameters = [connector_name,listen_port, provider_port],
	case file:consult("config.properties") of
		{ok, [Configuration]} -> 
			validate_configuration(dict:from_list(Configuration), RequiredParameters);
		{error, _} -> 
			io:format("~nCan not read configuration from config.properties file.")
	end.

validate_configuration(RealConfig, [RequiredParameter|Tail])->
	case dict:find(RequiredParameter, RealConfig) of
		{ok, _ } -> validate_configuration(RealConfig, Tail);
		error -> 
				io:format("~nRequired parameter [~p] is not present.", [RequiredParameter])
	end;
validate_configuration(RealConfig, [])->RealConfig.
	
print_configuration(Config)->
	io:format("~nconnector_name:~p",[get_parameter(connector_name, Config)]),
	io:format("~nlisten_port:~p",[get_parameter(listen_port, Config)]),
	io:format("~nprovider_port:~p",[get_parameter(provider_port, Config)]).
	
get_parameter(Parameter, Config)->
		{ok, Value} = dict:find(Parameter, Config),
		Value.	
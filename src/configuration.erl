-module(configuration).
-include("parameter_names.hrl").
-export([read_configuration/0, print_configuration/1, get_parameter/2]).

read_configuration()->
	RequiredParameters = [?CONNECTOR_NAME, ?LISTENER_PORT, ?PROVIDER_PORT],
	case file:consult("config.properties") of
		{ok, [Configuration]} -> 
			validate_configuration(dict:from_list(Configuration), RequiredParameters);
		{error, _} -> 
			error_logger:error_msg("Can not read configuration from config.properties file."),
			exit("Can not read configuration from config.properties file.")
	end.

validate_configuration(RealConfig, [RequiredParameter|Tail])->
	case dict:find(RequiredParameter, RealConfig) of
		{ok, _ } -> validate_configuration(RealConfig, Tail);
		error -> 
				ErrorMsg = io_lib:format("Required parameter [~p] is not present.", [atom_to_list(RequiredParameter)]),
				error_logger:info_msg(ErrorMsg),
				exit(ErrorMsg)
	end;
validate_configuration(RealConfig, [])->RealConfig.
	
print_configuration(Config)->
	error_logger:info_msg("connector_name:~p~nlisten_port:~p~nprovider_port:~p", [get_parameter(?CONNECTOR_NAME, Config), get_parameter(?LISTENER_PORT, Config), get_parameter(?PROVIDER_PORT, Config)]).
	
get_parameter(Parameter, Config)->
		case dict:find(Parameter, Config) of
			{ok, Val} -> Val;
			error -> ""
		end.	
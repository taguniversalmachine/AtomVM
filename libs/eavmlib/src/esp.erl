%
% This file is part of AtomVM.
%
% Copyright 2018-2022 Fred Dushin <fred@dushin.net>
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%    http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
% SPDX-License-Identifier: Apache-2.0 OR LGPL-2.1-or-later
%

%
% This file is part of AtomVM.
%
% Copyright 2019 Fred Dushin <fred@dushin.net>
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%    http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
% SPDX-License-Identifier: Apache-2.0 OR LGPL-2.1-or-later
%

%%-----------------------------------------------------------------------------
%% @doc ESP32-specific APIs
%%
%% This module contains functions that are specific to the ESP32 platform.
%% @end
%%-----------------------------------------------------------------------------
-module(esp).

-export([
    restart/0,
    reset_reason/0,
    nvs_get_binary/1, nvs_get_binary/2, nvs_get_binary/3,
    nvs_set_binary/2, nvs_set_binary/3,
    nvs_erase_key/1, nvs_erase_key/2,
    nvs_erase_all/0, nvs_erase_all/1,
    nvs_reformat/0,
    freq_hz/0
]).

-type esp_reset_reason() ::
    esp_rst_unknown
    | esp_rst_poweron
    | esp_rst_ext
    | esp_rst_sw
    | esp_rst_panic
    | esp_rst_int_wdt
    | esp_rst_task_wdt
    | esp_rst_wdt
    | esp_rst_deepsleep
    | esp_rst_brownout
    | esp_rst_sdio.

-define(ATOMVM_NVS_NS, atomvm).

%%-----------------------------------------------------------------------------
%% @doc     Restarts the ESP device
%% @end
%%-----------------------------------------------------------------------------
-spec restart() -> ok.
restart() ->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @returns the reason for the restart
%% @doc     Returns the reason for the restart
%% @end
%%-----------------------------------------------------------------------------
-spec reset_reason() -> esp_reset_reason().
reset_reason() ->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @doc Equivalent to nvs_get_binary(?ATOMVM_NVS_NS, Key).
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_get_binary(Key :: atom()) -> binary() | undefined.
nvs_get_binary(Key) when is_atom(Key) ->
    esp:nvs_get_binary(?ATOMVM_NVS_NS, Key).

%%-----------------------------------------------------------------------------
%% @param   Namespace NVS namespace
%% @param   Key NVS key
%% @returns binary value associated with this key in NV storage, or undefined
%%          if there is no value associated with this key.
%% @doc     Get the binary value associated with a key, or undefined, if
%%          there is no value associated with this key.
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_get_binary(Namespace :: atom(), Key :: atom()) -> binary() | undefined.
nvs_get_binary(Namespace, Key) when is_atom(Namespace) andalso is_atom(Key) ->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @param   Namespace NVS namespace
%% @param   Key NVS key
%% @param   Default default binary value, if Key is not set in Namespace
%% @returns binary value associated with this key in NV storage, or Default
%%          if there is no value associated with this key.
%% @doc     Get the binary value associated with a key, or Default, if
%%          there is no value associated with this key.
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_get_binary(Namespace :: atom(), Key :: atom(), Default :: binary()) ->
    binary() | undefined.
nvs_get_binary(Namespace, Key, Default) when
    is_atom(Namespace) andalso is_atom(Key) andalso is_binary(Default)
->
    case esp:nvs_get_binary(Namespace, Key) of
        undefined ->
            Default;
        Value ->
            Value
    end.

%%-----------------------------------------------------------------------------
%% @doc Equivalent to nvs_set_binary(?ATOMVM_NVS_NS, Key, Value).
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_set_binary(Key :: atom(), Value :: binary()) -> ok.
nvs_set_binary(Key, Value) when is_atom(Key) andalso is_binary(Value) ->
    esp:nvs_set_binary(?ATOMVM_NVS_NS, Key, Value).

%%-----------------------------------------------------------------------------
%% @param   Namespace NVS namespace
%% @param   Key NVS key
%% @param   Value binary value
%% @returns ok
%% @doc     Set an binary value associated with a key.  If a value exists
%%          for the specified key, it is over-written.
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_set_binary(Namespace :: atom(), Key :: atom(), Value :: binary()) -> ok.
nvs_set_binary(Namespace, Key, Value) when
    is_atom(Namespace) andalso is_atom(Key) andalso is_binary(Value)
->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @doc Equivalent to nvs_erase_key(?ATOMVM_NVS_NS, Key).
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_erase_key(Key :: atom()) -> ok.
nvs_erase_key(Key) when is_atom(Key) ->
    esp:nvs_erase_key(?ATOMVM_NVS_NS, Key).

%%-----------------------------------------------------------------------------
%% @param   Namespace NVS namespace
%% @param   Key NVS key
%% @returns ok
%% @doc     Erase the value associated with a key.  If a value does not exist
%%          for the specified key, no action is performed.
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_erase_key(Namespace :: atom(), Key :: atom()) -> ok.
nvs_erase_key(Namespace, Key) when is_atom(Namespace) andalso is_atom(Key) ->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @doc Equivalent to nvs_erase_all(?ATOMVM_NVS_NS).
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_erase_all() -> ok.
nvs_erase_all() ->
    esp:nvs_erase_all(?ATOMVM_NVS_NS).

%%-----------------------------------------------------------------------------
%% @param   Namespace NVS namespace
%% @returns ok
%% @doc     Erase all values in the specified namespace.
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_erase_all(Namespace :: atom()) -> ok.
nvs_erase_all(Namespace) when is_atom(Namespace) ->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @returns ok
%% @doc     Reformat the entire NVS partition.
%%          WARNING.  This will result in deleting all NVS data and should
%%          be used with extreme caution!
%% @end
%%-----------------------------------------------------------------------------
-spec nvs_reformat() -> ok.
nvs_reformat() ->
    throw(nif_error).

%%-----------------------------------------------------------------------------
%% @returns Clock frequency (in hz)
%% @doc     Return the clock frequency on the chip
%% @end
%%-----------------------------------------------------------------------------
-spec freq_hz() -> non_neg_integer().
freq_hz() ->
    throw(nif_error).

%% -------------------------------------------------------------------
%%
%% Copyright (c) 2013 Basho Technologies, Inc.  All Rights Reserved.
%%
%%   This Source Code Form is subject to the terms of the Mozilla Public
%%   License, v. 2.0. If a copy of the MPL was not distributed with this
%%   file, You can obtain one at http://mozilla.org/MPL/2.0/.
%%
%% -------------------------------------------------------------------

-define(EXOMETER_SHARED, exometer_shared).
-define(EXOMETER_ENTRIES, exometer_entries).
-define(EXOMETER_SUBS, exometer_subscriptions).
-define(EXOMETER_REPORTERS, exometer_reporters).

-record(exometer_event, {
          time = exometer_util:timestamp(),
          from,
          event
         }).

-record(exometer_entry, {
          name,
          type,
          behaviour = undefined,
          module = exometer,
          status = 1,   % enabled, no event flags
          cache = 0,
          value,
          timestamp,
          options = [],
          ref
         }).

%% Used to redirect lookup from the scheduler-specific tables to the shared
-record(exometer_shared, {
          name
         }).

-ifdef(OTP_RELEASE). %% this implies 21 or higher
-define(EXCEPTION(Class, Reason, Stacktrace), Class:Reason:Stacktrace).
-define(GET_STACK(Stacktrace), Stacktrace).
-else.
-define(EXCEPTION(Class, Reason, _), Class:Reason).
-define(GET_STACK(_), erlang:get_stacktrace()).
-endif.

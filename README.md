# README

This is Ruby Access.

**v0.2.1 - 20210729**
Fixes a bug that was causing the UnsuspendPort job to fail. The failure scenario was that UnsuspendPort was assuming that an input_rate and an output_rate would have values. A match is done on the configuration line for input or output, and the numeric value for the rate-limit was gleaned from a delete_prefix() on that match. When there was no match (i.e. no input rate-limit, no output rate-limit, or neither), delete_prefix was blowing up because it was operating on a then-nil value.

This update just makes the temporary removal of the rate-limit config lines conditional upon whether those lines existed to begin with. If there was no rate-limit input, then a rate-limit input line will not be temporarily removed and then re-inserted. The same is applied to the output rate-limit. If it wasn't there, don't try to remove and re-insert it.

**v0.2 - 20210722**
Adds `:subscriber_id` to the Port class and sets up an API endpoint (`/api/ports/subscriber_id`) that takes a :port_name, a :switch_ip, and a :subscriber_id and sets the subscriber_id on the given port on the given switch.

**v0.1**
This is the first use of semver in this project.
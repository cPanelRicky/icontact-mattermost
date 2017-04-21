package Cpanel::iContact::Provider::Schema::Mattermost; # Change 'Example' to your Service name
use strict;
use warnings;
  
# Use any modules from our installed CPAN modules here.
  
sub get_settings {
    return {
        'CONTACTHOOKURL' => {
            'name'     => 'Mattermost',
            'shadow'   => 1,
            'type'     => 'text',
            'checkval' => sub {
                my $value = shift();
                return $value;
            },
            'label' => 'Mattermost Incoming Hook URL',
            'help' => 'Generated when an incoming hook is created in the Mattermost Integrations preferences',
        },
    };
}
  
sub get_config {
    my $image = ' data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAAAXNSR0IArs4c6QAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAAIK2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiCiAgICAgICAgICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIj4KICAgICAgICAgPHRpZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjUwMTwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjUwMTwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDx4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ+eG1wLmRpZDphNzNjOTNmZi0zMWYyLTQ5MzMtYjU5ZC0xM2IyMjA5MmYxZGI8L3htcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD4KICAgICAgICAgPHhtcE1NOkhpc3Rvcnk+CiAgICAgICAgICAgIDxyZGY6U2VxPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKE1hY2ludG9zaCk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTYtMDMtMDhUMjA6MDQ6MTYrMDU6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6YTczYzkzZmYtMzFmMi00OTMzLWI1OWQtMTNiMjIwOTJmMWRiPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNyZWF0ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8eG1wTU06SW5zdGFuY2VJRD54bXAuaWlkOmE3M2M5M2ZmLTMxZjItNDkzMy1iNTlkLTEzYjIyMDkyZjFkYjwveG1wTU06SW5zdGFuY2VJRD4KICAgICAgICAgPHhtcE1NOkRvY3VtZW50SUQ+eG1wLmRpZDphNzNjOTNmZi0zMWYyLTQ5MzMtYjU5ZC0xM2IyMjA5MmYxZGI8L3htcE1NOkRvY3VtZW50SUQ+CiAgICAgICAgIDx4bXA6Q3JlYXRlRGF0ZT4yMDE2LTAzLTA4VDIwOjA0OjE2KzA1OjAwPC94bXA6Q3JlYXRlRGF0ZT4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxNi0wNC0wNVQyMDoxOToxMiswNTowMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpNb2RpZnlEYXRlPjIwMTYtMDQtMDVUMjA6MTk6MTIrMDU6MDA8L3htcDpNb2RpZnlEYXRlPgogICAgICAgICA8eG1wOkNyZWF0b3JUb29sPkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChNYWNpbnRvc2gpPC94bXA6Q3JlYXRvclRvb2w+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgqfErCaAAABY0lEQVQoz11RTytEURQ/MwxJk2wYYsz9nWfegpBZSvkCfACWsvEBfINJamKGyULCykKhkUmxkJ1okhW7WbGaWUykpnCc++6Y5NY7nfs7vz/3vktEFNaPeJR3TIULXjtRIkZuhZsFWU/wymnEicySOVAk3tv5OyUUk4JVJzI+Cx8pNo/bhg/WfeG0Y/tRPCn5UCN78IldqxhT8/JMqyOg6AkLTgPhgieJCcKGL1gjGuhQ1cqw4EMF55aQiuANe4T7pJhFIuuBEjvClc5bdH+DMvGLqpaJ7PVwrP1XUjhj9TYQ4gj7jjDYr1CVC+hShxCF8Iy62qplbaiPaKTNJvtRWy3dTOukRGYzOPeZg61xKmLHFMadni6n14SgrtyTeDc1VyJmrhX79iaD36yneNdtlTNmlqfMHLKosSiSb/DNhVLqUMjG2Wp7XP55MZPjYKhx0ujy/97TjPMWHkwFVTxiO8gOJj87S4R4uN95KQAAAABJRU5ErkJggg=='
    return {
        'default_level'    => 'High', # Maps to what you'd see in the WHM >> Contact Manager UI as the default notification level. In /var/cpanel/clevels.conf, this would be translated to '3'.
        'display_name'     => 'MatterMost', # Maps to what your provider shows up as in the WHM >> Contact Manager UI.
        'icon_name'        => 'Mattermost', # Maps to what your icon is named. Currently irrelevant, as it does nothing to help your icon load, and falls back to 'display_name' above if not set.
		'icon'			   => $image,
    };
}
  
1;

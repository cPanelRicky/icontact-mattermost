# Summary

This iContact plugin allows you to send your server notifications to your Mattermost instance. For more information on Mattermost, take a look at their about page linked to below.

https://about.mattermost.com/

# Install

- Create the iContact Provider directory if it doesn't already exist
    mkdir -p /var/cpanel/perl/Cpanel/iContact/Provider

- Copy the contents of the icontact-mattermost directory into the Provider directory created previously
    cp -R icontact-package/* /var/cpanel/perl/Cpanel/iContact/Provider

# Configure

- Generate your incoming webhook for Mattermost. See the [Mattermost documentation](https://docs.mattermost.com/developer/webhooks-incoming.html) for the steps to generate the webhook
- Save the webhook to the Mattermost configuration option in the Contact Information section of WHM.

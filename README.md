# activerecord_session_cleaner [![Gem Version](https://badge.fury.io/rb/activerecord_session_cleaner.png)](http://badge.fury.io/rb/activerecord_session_cleaner) [![Build Status](https://travis-ci.org/ninech/activerecord_session_cleaner.svg)](https://travis-ci.org/ninech/activerecord_session_cleaner)

Gem to remove old sessions from your ActiveRecord DB.

## Installation

In your Gemfile, add:

``` ruby
gem 'activerecord_session_cleaner'
```

## Features

* Delete all sessions
* Delete sessions not updated in the last `$x` days
* Setup cleanup cron to delete old sessions

## Tasks

    # Delete old sessions from an Active Record session store
    rake activerecord_session_cleaner:cleanup:old[days_to_keep]
    # Delete all session from an Active Record session store
    rake activerecord_session_cleaner:cleanup:all

    # Setup/update cron for session cleanup
    rake activerecord_session_cleaner:crontab:update[application_name,days_to_keep]
    # Remove cleanup cron for session cleanup
    rake activerecord_session_cleaner:crontab:clear[application_name]

Default values:

* `days_to_keep`: `10`
* `application_name`: basename of the current working directory (`example` if you are in `/home/gooby/example`)

## License

activerecord_session_cleaner is released under the MIT License. See [LICENSE.txt](LICENSE.txt) for further details.

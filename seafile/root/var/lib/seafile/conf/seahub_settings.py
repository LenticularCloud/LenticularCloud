SECRET_KEY = "__SECRET_KEY__"

FILE_SERVER_ROOT="https://__SEAFILE_DOMAIN__/seafhttp"

SITE_BASE = 'https://__SEAFILE_DOMAIN__/'

SITE_NAME = '__DOMAIN__'

SITE_TITLE = 'Seafile'

# If you don't want to run seahub website on your site's root path, set this option to your preferred path.
# e.g. setting it to '/seahub/' would run seahub on http://example.com/seahub/.
SITE_ROOT = '/'

# Whether to use pdf.js to view pdf files online. Default is `True`,  you can turn it off.
# NOTE: since version 1.4.
USE_PDFJS = True

# Enalbe or disalbe registration on web. Default is `False`.
# NOTE: since version 1.4.
ENABLE_SIGNUP = False

# Activate or deactivate user when registration complete. Default is `True`.
# If set to `False`, new users need to be activated by admin in admin panel.
# NOTE: since version 1.8
ACTIVATE_AFTER_REGISTRATION = False

# Whether to send email when a system admin adding a new member. Default is `True`.
# NOTE: since version 1.4.
SEND_EMAIL_ON_ADDING_SYSTEM_MEMBER = True

# Whether to send email when a system admin resetting a user's password. Default is `True`.
# NOTE: since version 1.4.
SEND_EMAIL_ON_RESETTING_USER_PASSWD = True

# Online preview maximum file size, defaults to 30M.
FILE_PREVIEW_MAX_SIZE = 30 * 1024 * 1024

# Age of cookie, in seconds (default: 2 weeks).
SESSION_COOKIE_AGE = 60 * 60 * 24 * 7 * 2

# Whether to save the session data on every request.
SESSION_SAVE_EVERY_REQUEST = False

# Whether a user's session cookie expires when the Web browser is closed.
SESSION_EXPIRE_AT_BROWSER_CLOSE = False

# Whether a user can make group as public. Default is False.
ENABLE_MAKE_GROUP_PUBLIC = False

# Enable or disable thumbnails
# NOTE: since version 4.0.2
ENABLE_THUMBNAIL = True

# Absolute filesystem path to the directory that will hold thumbnail files.
THUMBNAIL_ROOT = '/var/lib/seafile/seahub-data/thumbnail/thumb/'
THUMBNAIL_EXTENSION = 'png'
THUMBNAIL_DEFAULT_SIZE = '24'
PREVIEW_DEFAULT_SIZE = '100'

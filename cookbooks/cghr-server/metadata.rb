name             'cghr-server'
maintainer       'Centre for Global Health Research'
maintainer_email 'PatkeS@smh.ca'
license          'All rights reserved'
description      'Installs/Configures cghr-server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apache'
depends 'trac'
depends 'tomcat'

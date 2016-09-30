# Revision history for Mezuro module Prezento

Prezento is the web interface for Mezuro.

The version numbers below try to follow the conventions at http://semver.org/.

## Unreleased

- Remove the repository's instance that has remained in the db
- Adding translation of the periodicity options in repository helper
- Fixing wrong configurations translation in portuguese navbar
- Fix warnings about 'prezento_errors'
- Creates pattern for creation tooltips in Compound Metric Configuration
- Update development Ruby target to 2.3.1

## v1.1.0 - 01/06/2016

- Always load Kalibro service addresses from file

## v1.0.1 - 11/05/2016

- Fix kalibro services address init under production

## v1.0.0 - 11/05/2016

- Remove Show button for hotspot metric configurations
- Remove side menu
- Refactor footer as a grid
- Add latest repositories list to the homepage
- Add latest configurations list to the homepage
- Move tutorials to mezuro.github.io
- Pluralize navigation menu links
- Add missing translation for CompoundMetric
- Make Compound Metric Config. metric list not include Hotspot metrics
- Fix 'Tree Metrics' and 'Hotspot Metrics' PT translations in Configuration show view
- Show the notify push url for the repository's owner (Gitlab only)
- Support for hiding repositories
- Fix home latest content caching effectiveness
- Fix setup script
- Update README
- Create HACKING and CONTRIBUTING files

## v0.11.3 - 01/04/2016

- Update KalibroClient error API which now uses Likeno errors

## v0.11.2 - 09/03/2016

- Set development Ruby version to 2.3.0

## v0.11.1 - 26/02/2016

- Fix default database.yml to avoid encoding conflicts in PostgreSQL

## v0.11.0 - 22/02/2016

- Change Hotspot Metric Configuration to work in a more "native" fashion and refactor the Metric Configuration controllers
- Replace url helpers by the path ones. Those were left unchanged on the previous release
- Update docs
- Update kalibro_client
- Changes on memcached configuration
- Aggregation form fix

## v0.10.1 - 12/01/2016

- Replace URL route helpers by path ones

## v0.10.0 - 30/11/2015

- Add Gitlab hook notifications

## v0.9.2 - 17/11/2015

- Put foreman gem in global scope on Gemfile

## v0.9.1 - 17/11/2015

- Add better acceptance tests for Ruby MetricResults
- Fix deployment branch on capistrano
- Fix ProjectAttributes association with Project
- Fix parent module navigation when on root module
- Add foreman in order to export scripts
- Add postgresql database sample configuration

## v0.9.0 - 28/10/2015

- Gem updates
- Update home page information
- Update humans.txt
- Fix test that use external connections
- Add after configuration hook to cucumber
- Use Ruby metrics for module navigation feature
- List hotspot metric configurations

## v0.8.6 - 16/09/2015

- Fixes module tree ordering with FUNCTION granularity

## v0.8.5 - 14/09/2015

- Update kalibro_client - fixes MetricResult retrieval

## v0.8.4 - 11/09/2015

- Cascade user destroy to its attributes
- Use kalibro_client ranges

## v0.8.3 - 03/09/2015

- Using railsstrap instead of twitter-bootstrap-rails

## v0.8.2 - 03/09/2015

- Fixed hardcoded routes on JS files by using generated ones

## v0.8.1 - 01/09/2015

- README and humans.txt updated
- Gem updates and dependancy review on Gemfile
- Home text updated
- Fixes bug for showing independent repositories
- FactoryGirl is no longer used by seeds
- kalibro_client major update to version 1
- Translations fixes

## v0.8.0 - 05/08/2015

- Travis build reliability improved by disabling jQuery on acceptance tests
- Metric's list collapsed by default
- Seed script creates default user who owns the default KalibroConfigurationAttributes and ReadingGroupAttributes
- Updated Home to include new features and an apology message

## v0.7.0 - 08/07/2015

- All repositories list with a link at the top menu
- Repositories may be created independent of a Project
- Missing translations fix

## v0.6.0 - 26/06/2015

- General updates and bug fixes
- Specific repository branches
- Error handling for pages non existent or formats unsupported

## v0.5.0 - 29/05/2015

- KalibroConfiguration hidding
- ReadingGroup hidding
- Translation fixes

Prezento is the web interface for Mezuro.
Copyright (C) 2015  The Mezuro Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This file is part of KalibroEntities
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
FactoryGirl.define do
  factory :repository, class: Repository do
    id 1
    name "SBKing"
    description "A simple calculator"
    license "GPLv3"
    period 1
    scm_type "GIT"
    address "https://github.com/rafamanzo/runge-kutta-vtk.git"
    kalibro_configuration_id 1
  end

  factory :ruby_repository, class: Repository do
    id 2
    name "KalibroConfigurations"
    description "Kalibro Configurations"
    license "GPLv3"
    period 1
    scm_type "GIT"
    address "https://github.com/mezuro/kalibro_processor.git"
    kalibro_configuration_id 1
  end

  factory :kalibro_client_gitlab_repository, class: Repository do
    id 3
    name "KalibroClient"
    description "KalibroClient"
    license "GPLv3"
    period 1
    scm_type "GIT"
    address "https://gitlab.com/mezuro/kalibro_client.git"
    branch 'master'
    kalibro_configuration_id 1
  end

  factory :another_repository, parent: :repository do
    id 2
  end

  trait :with_project_id do
    project_id 1
  end
end

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
  factory :metric_configuration_snapshot, class: KalibroGatekeeperClient::Entities::MetricConfigurationSnapshot do
		code "code"
		weight "1.0"
		aggregation_form 'AVERAGE'
		metric {FactoryGirl.build(:metric)}
		base_tool_name "Analizo"
		range {FactoryGirl.build(:range_snapshot)}
  end
end
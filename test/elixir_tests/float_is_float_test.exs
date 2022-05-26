#
# This file is part of AtomVM.
#
# Copyright 2022 TAG Universal Machine <taguniversalmachine@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0 OR LGPL-2.1-or-later
#
defmodule FloatTest do
  use ExUnit.Case

  def id(i) when is_float(i), do: i
  def pow(_n, 0), do: 1
  def pow(n, m) do
    n*pow(n,m-1)
  end

  def testval(val) when is_float(val), do: 32
  def testval(val) when is_integer(val), do: 16
  def testval(_val), do: 8

  test "float is float" do
     res = (pow(-2, 63) + id(10.0)) * id(-1.0)
     test_res = testval(res)
     assert test_res = 32
  end
end
##
# Copyright 2012 Jerome Quere < contact@jeromequere.com >.
#
# This file is part of JStl.
#
# JStl is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# JStl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with JStl.If not, see <http://www.gnu.org/licenses/>.
##

jstl.foreach = (first, last, f) ->
        while first.neq last
                f first.get()
                first.next()
        return f;

jstl.min = (obj1, obj2) ->
        if (typeof obj1 == "number" || typeof obj1 == "bool" || typeof obj1 == "string" || obj1 instanceof Array)
                return if !(obj2<obj1) then obj1 else obj2;
        if !(obj2.lt(obj1)) then obj1 else obj2;

jstl.max = (obj1, obj2) ->
        if (typeof obj1 == "number" || typeof obj1 == "bool" || typeof obj1 == "string" || obj1 instanceof Array)
                return if (obj1<obj2) then obj2 else obj1;
        if (obj1.lt(obj2)) then obj2 else obj1;
--
--  D_Bus/Ada - An Ada binding to D-Bus
--
--  Copyright (C) 2012  Reto Buerki <reet@codelabs.ch>
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
--  USA.
--
--  As a special exception, if other files instantiate generics from this
--  unit,  or  you  link  this  unit  with  other  files  to  produce  an
--  executable   this  unit  does  not  by  itself  cause  the  resulting
--  executable to  be  covered by the  GNU General  Public License.  This
--  exception does  not  however  invalidate  any  other reasons why  the
--  executable file might be covered by the GNU Public License.
--

with GNAT.Regpat;

package body D_Bus.Types is

   -------------------------------------------------------------------------

   function "+" (Path : String) return Obj_Path
   is
   begin
      if not Is_Valid (Path => Path) then
         raise D_Bus_Error with "Invalid D-Bus object path: '" & Path & "'";
      end if;

      return P : Obj_Path do
         P.Value := Ada.Strings.Unbounded.To_Unbounded_String (Path);
      end return;
   end "+";

   -------------------------------------------------------------------------

   function Is_Valid (Path : String) return Boolean
   is
      use type GNAT.Regpat.Match_Location;

      Path_Regex : constant GNAT.Regpat.Pattern_Matcher := GNAT.Regpat.Compile
        (Expression => "^/([-_a-zA-Z0-9]+(/[-_a-zA-Z0-9]+)*)?$");
      Matches    : GNAT.Regpat.Match_Array (0 .. 1);
   begin
      GNAT.Regpat.Match (Self    => Path_Regex,
                         Data    => Path,
                         Matches => Matches);
      return Matches (0) /= GNAT.Regpat.No_Match;
   end Is_Valid;

   -------------------------------------------------------------------------

   function To_String (Path : Obj_Path) return String
   is
   begin
      return Ada.Strings.Unbounded.To_String (Source => Path.Value);
   end To_String;

end D_Bus.Types;

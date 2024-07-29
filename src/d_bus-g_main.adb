--
--  D_Bus/Ada - An Ada binding to D-Bus
--
--  Copyright (C) 2011  Reto Buerki <reet@codelabs.ch>
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

with System;

with Interfaces.C;

package body D_Bus.G_Main is

   use type System.Address;

   Main_Loop : System.Address := System.Null_Address;

   function g_main_loop_new
     (context    : System.Address;
      is_running : Interfaces.C.int)
      return System.Address;
   pragma Import (C, g_main_loop_new, "g_main_loop_new");

   procedure g_main_loop_run (the_loop : System.Address);
   pragma Import (C, g_main_loop_run, "g_main_loop_run");

   -------------------------------------------------------------------------

   procedure Init
   is
   begin
      if Main_Loop /= System.Null_Address then
         raise D_Bus_Error with "GLib main loop already initialized";
      end if;

      Main_Loop := g_main_loop_new
        (context    => System.Null_Address,
         is_running => 0);

      if Main_Loop = System.Null_Address then
         raise D_Bus_Error with "Could not initialize GLib main loop";
      end if;
   end Init;

   -------------------------------------------------------------------------

   procedure Start
   is
   begin
      if Main_Loop = System.Null_Address then
         Init;
      end if;

      g_main_loop_run (the_loop => Main_Loop);
   end Start;

end D_Bus.G_Main;
